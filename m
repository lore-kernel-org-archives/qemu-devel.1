Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C35BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A3E20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="DRsple8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A3E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAytD-0004Ej-Id
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAysb-0003my-41
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:06:33 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:50266 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAysY-0004rg-HC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:06:32 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 9573556C26;
 Wed, 26 Aug 2020 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1598461585;
 x=1600275986; bh=8WlhbQa1vTefMol5y04s42mHdYHA5X2o/3BWSvAGFkk=; b=
 DRsple8frADvSe9HGUYssPLY1thO0HkyUW3iE03r46V27Wiv54ufqROH5v6n6FsA
 5M1nlZ3dXK9NX6Zh3fToiUFbEBLHlmLOKFOpHm5lDQv3LOj2KGu7Z1qXNfZUaY+0
 SWPfwSIpUgl6Er7bafL5+zq8SnlLwrs/hEGtPiGAAfI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Civt0ioqzz1; Wed, 26 Aug 2020 20:06:25 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id CFE9F5282A;
 Wed, 26 Aug 2020 20:06:24 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 26
 Aug 2020 20:06:24 +0300
Date: Wed, 26 Aug 2020 20:06:24 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 00/74] qom: Automated conversion of type checking
 boilerplate
Message-ID: <20200826170624.GB16356@SPB-NB-133.local>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200826102238.GA50795@SPB-NB-133.local>
 <20200826111815.GV642093@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200826111815.GV642093@habkost.net>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 13:06:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 07:18:15AM -0400, Eduardo Habkost wrote:
> On Wed, Aug 26, 2020 at 01:22:38PM +0300, Roman Bolshakov wrote:
> > On Tue, Aug 25, 2020 at 03:19:56PM -0400, Eduardo Habkost wrote:
> > > git tree for this series:
> > > https://github.com/ehabkost/qemu-hacks/tree/work/qom-macros-autoconvert
> > > 
> > 
> > Hi Eduardo,
> > 
> > another assert fires during QEMU start:
> > 
> > $ lldb -- $QEMU -cpu nahelem -M q35,accel=hvf -cdrom test.iso
> > (lldb) target create "[...]/qemu/build/qemu-system-x86_64"
> > Current executable set to '[...]/qemu/build/qemu-system-x86_64' (x86_64).
> > (lldb) settings set -- target.run-args  "-cpu" "nahelem" "-M" "q35,accel=hvf" "-cdrom" "test.iso"
> > (lldb) r
> > Process 92411 launched: '[...]/qemu/build/qemu-system-x86_64' (x86_64)
> > **
> > ERROR:../qom/object.c:505:object_initialize_with_type: assertion failed: (size >= type->instance_size)
> > Bail out! ERROR:../qom/object.c:505:object_initialize_with_type: assertion failed: (size >= type->instance_size)
> > Process 92411 stopped
> > * thread #3, stop reason = signal SIGABRT
> >     frame #0: 0x00007fff6a75e33a libsystem_kernel.dylib`__pthread_kill + 10
> > libsystem_kernel.dylib`__pthread_kill:
> > ->  0x7fff6a75e33a <+10>: jae    0x7fff6a75e344            ; <+20>
> >     0x7fff6a75e33c <+12>: movq   %rax, %rdi
> >     0x7fff6a75e33f <+15>: jmp    0x7fff6a758629            ; cerror_nocancel
> >     0x7fff6a75e344 <+20>: retq
> > Target 0: (qemu-system-x86_64) stopped.
> > (lldb) bt
> > * thread #3, stop reason = signal SIGABRT
> >   * frame #0: 0x00007fff6a75e33a libsystem_kernel.dylib`__pthread_kill + 10
> >     frame #1: 0x00007fff6a81ae60 libsystem_pthread.dylib`pthread_kill + 430
> >     frame #2: 0x00007fff6a6e5808 libsystem_c.dylib`abort + 120
> >     frame #3: 0x0000000101314c36 libglib-2.0.0.dylib`g_assertion_message + 406
> >     frame #4: 0x0000000101314c9e libglib-2.0.0.dylib`g_assertion_message_expr + 94
> >     frame #5: 0x0000000100366f0c qemu-system-x86_64`object_initialize_with_type(obj=<unavailable>, size=<unavailable>, type=<unavailable>) at object.c:505:5 [opt]
> >     frame #6: 0x0000000100400e48 qemu-system-x86_64`qbus_create_inplace(bus=0x0000000000000000, size=<unavailable>, typename=<unavailable>, parent=0x0000000000000000, name="main-system-bus") at bus.c:153:5 [opt]
> >     frame #7: 0x000000010006800a qemu-system-x86_64`sysbus_get_default [inlined] main_system_bus_create at sysbus.c:346:5 [opt]
> >     frame #8: 0x0000000100067fe2 qemu-system-x86_64`sysbus_get_default at sysbus.c:354 [opt]
> >     frame #9: 0x00000001002b774f qemu-system-x86_64`qemu_init(argc=<unavailable>, argv=<unavailable>, envp=<unavailable>) at vl.c:3890:41 [opt]
> >     frame #10: 0x0000000100008c99 qemu-system-x86_64`qemu_main(argc=<unavailable>, argv=<unavailable>, envp=<unavailable>) at main.c:49:5 [opt]
> >     frame #11: 0x000000010007bbd6 qemu-system-x86_64`call_qemu_main(opaque=<unavailable>) at cocoa.m:1710:14 [opt]
> >     frame #12: 0x00000001004631ee qemu-system-x86_64`qemu_thread_start(args=<unavailable>) at qemu-thread-posix.c:521:9 [opt]
> >     frame #13: 0x00007fff6a81b109 libsystem_pthread.dylib`_pthread_start + 148
> >     frame #14: 0x00007fff6a816b8b libsystem_pthread.dylib`thread_start + 15
> > (lldb) f 7
> > qemu-system-x86_64 was compiled with optimization - stepping may behave oddly; variables may not be available.
> > frame #7: 0x000000010006800a qemu-system-x86_64`sysbus_get_default [inlined] main_system_bus_create at sysbus.c:346:5 [opt]
> >    343      /* assign main_system_bus before qbus_create_inplace()
> >    344       * in order to make "if (bus != sysbus_get_default())" work */
> >    345      main_system_bus = g_malloc0(system_bus_info.instance_size);
> > -> 346      qbus_create_inplace(main_system_bus, system_bus_info.instance_size,
> >    347                          TYPE_SYSTEM_BUS, NULL, "main-system-bus");
> >    348      OBJECT(main_system_bus)->free = g_free;
> >    349  }
> > (lldb) f 6
> > frame #6: 0x0000000100400e48 qemu-system-x86_64`qbus_create_inplace(bus=0x0000000000000000, size=<unavailable>, typename=<unavailable>, parent=0x0000000000000000, name="main-system-bus") at bus.c:153:5 [opt]
> >    150  void qbus_create_inplace(void *bus, size_t size, const char *typename,
> >    151                           DeviceState *parent, const char *name)
> >    152  {
> > -> 153      object_initialize(bus, size, typename);
> >    154      qbus_init(bus, parent, name);
> >    155  }
> >    156
> > (lldb) f 5
> > frame #5: 0x0000000100366f0c qemu-system-x86_64`object_initialize_with_type(obj=<unavailable>, size=<unavailable>, type=<unavailable>) at object.c:505:5 [opt]
> >    502
> >    503      g_assert(type->instance_size >= sizeof(Object));
> >    504      g_assert(type->abstract == false);
> > -> 505      g_assert(size >= type->instance_size);
> >    506
> >    507      memset(obj, 0, type->instance_size);
> >    508      obj->class = type->class;
> 
> Oops, sorry for not catching this before submitting.  This is
> caused by patch 72/74, which is not really important right now.
> I will drop it from the series by now.
> 
> I've pushed the new tree to
> https://github.com/ehabkost/qemu-hacks/tree/work/qom-macros-autoconvert
> 

This one is good. For the series (without trying individual commits in
the middle):
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>

There's a test failure due to missing qemu-nbd on macOS but the fix is
already queued.

Thanks,
Roman

