Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD745C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:00:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA17E206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZ9x8gmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA17E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaTR-0001xB-VR
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqaSq-0001Ut-T8
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:59:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqaSo-0003Ig-LK
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593601178;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gn/SV4+wjUydLJZRE4nVTJtAnwdLLiBqTehOZKW9NhM=;
 b=KZ9x8gmrBoxE9IeWUtkdWOGUzBSbkhpfO5TT6cXWi+aPLBbWgNrIJPkCmAY0kiG2EFGmOs
 u3nbTXE7fHAgjSVAeM2VMZ+Sua6kWofP9YugTs3wCKquMKleqDa7rM0E88JCdcPxQKgX2d
 1nhgEn9tG3Pou2haWOQvYgbxxD0D9Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-C_BMhtTBPDmAIjICJ5RTCQ-1; Wed, 01 Jul 2020 06:59:31 -0400
X-MC-Unique: C_BMhtTBPDmAIjICJ5RTCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E12800D5C;
 Wed,  1 Jul 2020 10:59:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2D5CB3A8A;
 Wed,  1 Jul 2020 10:59:25 +0000 (UTC)
Date: Wed, 1 Jul 2020 11:59:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 6/6] hw/mips/malta: Introduce the 'malta-unleashed'
 64-bit machine
Message-ID: <20200701105922.GG1427561@redhat.com>
References: <20200630145236.27529-1-f4bug@amsat.org>
 <20200630145236.27529-7-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200630145236.27529-7-f4bug@amsat.org>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Ximin Luo <infinity0@debian.org>, debian-mips@lists.debian.org,
 Yunqiang Su <ysu@wavecomp.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonathan Jackson <jnthjackson@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Martin Quinson <mquinson@debian.org>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 04:52:36PM +0200, Philippe Mathieu-Daudé wrote:
> Introduce the 'malta-unleashed' machine. This machine does not
> model any existing hardware (as the default 'malta' neither model
> a real hardware). The purpose of this machine is to allow user
> of the current 'malta' machine to use more RAM, as it has been
> reported to be useful for build farms.
> 
> References:
> - https://www.mail-archive.com/debian-mips@lists.debian.org/msg10912.html
> - https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2019-January/004844.html
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg691406.html

I'm not convinced that there's any real value in adding the malta-strict
and malta-unleashed machine types.

If you want to closely model a real physical machine it doesn't matter
what the "max ram" setting says - you can just choose a "-m MB" value
to match the physical machine you want to model.

Similarly if users want to exceed what the physical machine would do
there's no compelling reason for QEMU to artificially prevent that
or force use of a different machine.  Neither i440fx or q35 force
users to the max RAM limit of the physical machine they were originally
designed from. We have frequently just bumped the max limits in QEMU
for i440fx/q35 as we had users who requested a higher level.

IIUC, The current 2 GB limit is just a historical artifact from the
limited address space in 32-bit, which we don't have to be bound by
for 64-bit. 

IOW, instead of adding new machine types I would think we can just
modify the existing limit for TARGET_MIPS64, by doing something akin
to:


diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index d95926a89c..48e34da39c 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1247,9 +1247,14 @@ void mips_malta_init(MachineState *machine)
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
 
     /* allocate RAM */
-    if (ram_size > 2 * GiB) {
+#ifdef TARGET_MIPS64
+#define MAX_RAM_MB 3056
+#else
+#define MAX_RAM_MB 2048
+#endif
+    if (ram_size > MAX_RAM_MB * MiB) {
         error_report("Too much memory for this machine: %" PRId64 "MB,"
-                     " maximum 2048MB", ram_size / MiB);
+                     " maximum " MAX_RAM_MB "MB", ram_size / MiB);
         exit(1);
     }
 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


