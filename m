Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE93C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA383206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEt2Wj+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA383206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsu5V-0003MA-Pc
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsu4e-0002pv-7z
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:20:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28617
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsu4b-0004dw-JC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594153211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3zLjhzdd0tcuk5mJaSqmcdSc4NJNFYLwjDuAyZnPtXk=;
 b=JEt2Wj+tph37SK+VxT4pEUudNjk/gtwDBgGzQQ2Ju5Hwv3L4AQn3f0TeWo3uhHyRElil5p
 Xh+Wve1DlRZoyuOpC6euM6OR0DhSZdyhL7JxBaWV7ThpaLe2iib48yIR053WtNtzWyp3jH
 r3gFMhpzsqUUOYGHEqYQos2HAmRwUTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-_Ky0ii7GN5SdbVQzfs3DaA-1; Tue, 07 Jul 2020 16:20:07 -0400
X-MC-Unique: _Ky0ii7GN5SdbVQzfs3DaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADB4B8015CE;
 Tue,  7 Jul 2020 20:20:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8881F60BF3;
 Tue,  7 Jul 2020 20:19:57 +0000 (UTC)
Subject: Re: [PULL 0/3] MIPS + TCG Continuous Benchmarking queue for July 7th, 
 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <05a9301c-dbad-f11c-12a0-3c60fe0fcccb@redhat.com>
Date: Tue, 7 Jul 2020 22:19:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/2020 18.40, Aleksandar Markovic wrote:
> The following changes since commit 710fb08fd297d7a92163debce1959fae8f3b6ed7:
> 
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-06' into staging (2020-07-07 12:41:15 +0100)
> 
> are available in the git repository at:
> 
>   https://github.com/AMarkovic/qemu tags/mips-queue-jul-07-2020
> 
> for you to fetch changes up to fa6e7da119b6da4067e757924e165bc737bb1260:
> 
>   scripts/performance: Add dissect.py script (2020-07-07 18:32:20 +0200)
> 
> ----------------------------------------------------------------
> 
> MIPS + TCG Continuous Benchmarking queue for July 7th, 2020
> 
>   Highlights:
> 
>      - Fix for a regression in FPU emulation add.s.
>      - Add Loongson 2F disassembler.
>      - Add a script for a GSoC project.
> 
>   Note:
> 
>      - A checkpatch error and a checkpatch warning are known and
>      should be ignored.
> 
> ----------------------------------------------------------------
> 
> Ahmed Karaman (1):
>   scripts/performance: Add dissect.py script
> 
> Alex Richardson (1):
>   target/mips: fpu: Fix recent regression in add.s after 1ace099f2a
> 
> Stefan Brankovic (1):
>   disas: mips: Add Loongson 2F disassembler
> 
>  configure                      |    1 +
>  disas/loongson2f.h             | 2562 +++++++++++++
>  include/disas/dis-asm.h        |    1 +
>  include/exec/poison.h          |    1 +
>  target/mips/cpu.c              |    6 +
>  target/mips/fpu_helper.c       |    2 +-
>  MAINTAINERS                    |    1 +
>  disas/Makefile.objs            |    1 +
>  disas/loongson2f.cpp           | 8154 ++++++++++++++++++++++++++++++++++++++++

Honestly, no. Peter, please don't merge this pull request.

That disassembler source code is really huge, and I think someone should
give this a *proper* review first before we include this in our repo. I
just had a quick look at it, and I don't think that it is in the right
shape already. For example, there are hard-coded magic numbers there, like:

bool ADD::disas_output(disassemble_info *info)
+{
+    char alias1[5];
+    char alias2[5];
+    char alias3[5];
...

and in a completely different function, this hard-coded 5 is used again:

+void Instruction32::getAlias(char *buffer, int regNo)
+{
+    switch (regNo) {
+    case 0:
+        strncpy(buffer, "zero", 5);
+        break;
+    case 1:
+        strncpy(buffer, "at", 5);
...

That definitely needs to be turned into a proper #define or the length
needs to be passed as parameter to the function.

Also the coding style is weird in a couple of places, and there were
checkpatch warnings.

Apart from that, Paolo asked you to take a break from MIPS
maintainership for a while, Aleksandar. I strongly support that
suggestion. Your derogatory behavior during the last weeks, especially
in the last one, looked completely unacceptable to me. In my opinion you
really need some time to reflect yourself. You, and we all as a
community, now cannot continue just like nothing happened.

 Thanks,
  Thomas


