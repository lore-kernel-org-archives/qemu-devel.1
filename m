Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50C0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C761212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dp3R1gRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C761212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokY8-0002CP-D8
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jokXK-0001L3-4E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:20:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jokXH-00016z-Ph
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 05:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593163238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lc/QeDq9aXyprvmtcQfCI3TkZtelMBZkeTtO1Imexec=;
 b=dp3R1gRo4cBm4o78KWCNPHTfQYsWWLGWLw5FbqHGq1758qRKlIPyMeg5PBpFz5sa3yrqYP
 kA2H+jP8M4YSrs9nTd0izttqgU/uzlQ32mcjyJjd7ysIONY2TOosWITzngCiz1w/TNvkbn
 Zl7HOa0KzinEe/EhyyZY2CbAuY1iAWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-HoxND6Z7ONSqu_fnDfk9kA-1; Fri, 26 Jun 2020 05:20:35 -0400
X-MC-Unique: HoxND6Z7ONSqu_fnDfk9kA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA3D6805EE1;
 Fri, 26 Jun 2020 09:20:33 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41EE360BF4;
 Fri, 26 Jun 2020 09:20:32 +0000 (UTC)
Subject: Re: [Bug 1885247] [NEW] Build error in Intel 32-bit hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bug 1885247 <1885247@bugs.launchpad.net>, arilou@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
 <CAHiYmc7_ra2qWJ8mkZ-vqL5vN2BKdWxAZeKNnMEkPtien5-fsw@mail.gmail.com>
 <b34bf27c-3189-addc-0c50-b0c0c533876d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2657f75-26fe-117b-183d-732d88da2653@redhat.com>
Date: Fri, 26 Jun 2020 11:20:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b34bf27c-3189-addc-0c50-b0c0c533876d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/2020 11.13, Philippe Mathieu-Daudé wrote:
> On 6/26/20 9:37 AM, Aleksandar Markovic wrote:
>> пет, 26. јун 2020. у 09:11 Aleksandar Markovic
>> <1885247@bugs.launchpad.net> је написао/ла:
>>>
>>> Public bug reported:
>>>
>>> The code base is on master, checked out on Thursday June25th 2020,
>>> 0250c595c9d. The build procedure:
>>>
>>> $ mkdir build-gcc
>>> $ cd build-gcc
>>> $ ../configure
>>> $ make
>>>
>>> The build error message is:
>>>
>>>    CC      x86_64-softmmu/hw/hyperv/hyperv.o
>>>    CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
>>>    CC      x86_64-softmmu/hw/hyperv/vmbus.o
>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function ‘gpadl_iter_io’:
>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>>>           p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
>>>               ^
>>> cc1: all warnings being treated as errors
>>> make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69: hw/hyperv/vmbus.o] Error 1
>>> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
> 
> FWIW there is no CI job covering x86 KVM on 32-bit host build.
> Should this be covered? I guess the problem is no CI services
> provide 32-bit x86...

You can certainly provide either a container, or install the 32-bit 
libraries in a 64-bit environment. Then run

PKG_CONFIG_LIBDIR=... ./configure --extra-cflags=-m32

and it should be possible to build 32-bit binaries, too.

Alternatively, we could add a cross-compilation job that builds with 
i686-w64-mingw32 in 32-bit.

  Thomas


