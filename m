Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD38AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789B22068E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLxX++bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789B22068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfLZ-0000wW-QG
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jjfKZ-0000Nh-HI; Fri, 12 Jun 2020 04:46:31 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36024)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jjfKX-0005Zp-PD; Fri, 12 Jun 2020 04:46:31 -0400
Received: by mail-ed1-x542.google.com with SMTP id y6so587107edi.3;
 Fri, 12 Jun 2020 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qfeE6zmcSql8OhesVzb1Sr68zmtX88A+xWed9/ZkMoc=;
 b=QLxX++bzdLH9/Gtgw3ZkjSp+0bjUZLmkQLCUaOHD3a7krlQHpqlu1bRO5IXTDxfDlH
 S0B2gu5MzH6ApelMYSQ3XPNijURUDBFpRFCc7fH/WY2wZ052xKH1mIhYUqQ4sfkx1gMY
 ndAvm5iGqnRW4vy+jHicRCeXS8GaywHqeqZ0k6kehtDwWSM843z3jOJfaq7ujs/A/Zta
 U/FbE9qVaVQd5WD6peXBu+n8v8+kSA3lieHsLrTvbFqppAP0Ttxe5JahVQY/lrHvsttV
 9Rb/OdALxl/rT9utjH8m5AX6vahmxJ13A+t2QRGb6JxmJ/0wGQtJW3szyxsPV+l19MC3
 j74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qfeE6zmcSql8OhesVzb1Sr68zmtX88A+xWed9/ZkMoc=;
 b=bBR5vVsVdbR2oRwCjE7VTUy6Ot3CUsj/cVrKM8pVdcsjjGc6Yhvx6kArYJ5L3PlU8F
 9jr/Sq6892H6FRWLkxEA8HhozX025GTOG8vsYAujcVy1QTnps+1p8cLGg4B/LR2qEYFk
 KsJIMob9sNoEcOsX/N2KFpsmqSu43IZNq4z4hI5ZzQLqY2ssUXpf6KltUJ4GFc/7rMr4
 vlIqT3e2ld9bAvOQF0fk96zcABMIrmHIT8qwFYYrO/Mmh1QqcjzLaG3jKIZm7bkzzbzv
 qhoxjlcpg8dx8RXZUANathNojo4GUgbjUgOJPWJkAWLpyYHeCYMbxzL12Ow/9UTSAXiO
 ldsw==
X-Gm-Message-State: AOAM530kN3LaCZhmt8ePNr/72dL599d8nrVFV/6Bjm0G4eChosmuLW1Z
 hzJ0gsB3+IZ0YZ8UDnikQ8eCWmscq8OG3/mNFPo=
X-Google-Smtp-Source: ABdhPJx+Fz0JUOkxeBwLeE8uYPRWuojwjeWFoBku3zlEl+MDZ9ciVIDAR648CxcV6R+1RAsOwDVEu4vrMb+8vM/8iD0=
X-Received: by 2002:aa7:da14:: with SMTP id r20mr10857133eds.7.1591951577200; 
 Fri, 12 Jun 2020 01:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqwHSBd_TSFqipO6bn=hVSV8+Mdm3y=_i6gQoGBxRsjS0g@mail.gmail.com>
 <e7df4877-7700-ea36-ceb0-3bf84fec8df8@vivier.eu>
In-Reply-To: <e7df4877-7700-ea36-ceb0-3bf84fec8df8@vivier.eu>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 12 Jun 2020 09:46:06 +0100
Message-ID: <CA+XhMqxTU6PUSQBpbA9VrS1QZfqgrCAKUCtUF-x2aF=fCMTDOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] util/getauxval: Porting to FreeBSD getauxval feature
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From d7f9d40777d1ed7c9450b0be4f957da2993dfc72 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 12 Jun 2020 09:39:17 +0100
Subject: [PATCH] util/getauxval: Porting to FreeBSD getauxval feature

FreeBSD has a similar API for auxiliary vector.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/getauxval.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/util/getauxval.c b/util/getauxval.c
index 36afdfb9e6..b124107d61 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -98,6 +98,16 @@ unsigned long qemu_getauxval(unsigned long type)
     return 0;
 }

+#elif defined(__FreeBSD__)
+#include <sys/auxv.h>
+
+unsigned long qemu_getauxval(unsigned long type)
+{
+    unsigned long aux =3D 0;
+    elf_aux_info(type, &aux, sizeof(aux));
+    return aux;
+}
+
 #else

 unsigned long qemu_getauxval(unsigned long type)
--=20
2.27.0

On Fri, 12 Jun 2020 at 08:13, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 11/06/2020 =C3=A0 23:10, David CARLIER a =C3=A9crit :
> >
> Hi,
>
> please don't put your patch in attachements, you can use "git
> send-email" if your emailer doesn't allow it.
>
> https://wiki.qemu.org/Contribute/SubmitAPatch#Do_not_send_as_an_attachmen=
t
>
> I think your patch is not correct, you put a "#if defined(__linux__)" in
> a block that is followed by "#elif defined(__linux__)" and there is no
> return value if none of the "defined()" is true.
>
> I think you should not modify the configure and add directly a "#if
> defined(__FreeBSD__)" at the beginning of getauxval.c to define your
> function.
>
> Thanks,
> Laurent

