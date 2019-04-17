Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2637EC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E034D205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xs5VXEJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E034D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqaA-0006Pq-78
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:50:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.santos@pobox.com>) id 1hGqZ9-0005tf-AM
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.santos@pobox.com>) id 1hGqZ8-0004qF-Dq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:49:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <daniel.santos@pobox.com>)
	id 1hGqZ8-0004pd-5e
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:49:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 18F2F1545CA;
	Wed, 17 Apr 2019 15:49:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	s=sasl; bh=gNgTozfoALilmKS1VxPz6y35oGM=; b=Xs5VXEJSKNJxa5uwdTFl
	jO11g6X6JAbG/w88VyPwlN7dDnHbfRz6e3dUVqgczRTyaFS4G7jPJ9qPuCkijN7U
	yGzP9G7H1vEDVk0SOvUtagTbu2sX9X2JTT+iNODZ6XzV6d116hm9T9J/NxB4IfRT
	80wbZTzIUxnhis9sDvFTdhA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	q=dns; s=sasl; b=qXq7+nWbpZ14D+GxOawJ57duW5KlEH5B6cquWeo6S6+kbj
	HaNO7WuI1TGo51GKlilDrp3jMMydQ+/Uw+MPFea++E/P5c34TVsH3JF3iYmEYsrq
	w8xuKS/gsH2u1Z3ZjTbcxSoDfBY9ZmC9G+XeNsh+/VyQhHBTsgC+VWn55hFis=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 110EE1545C9;
	Wed, 17 Apr 2019 15:49:52 -0400 (EDT)
Received: from love.attlocal.net (unknown [108.91.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3619E1545C8;
	Wed, 17 Apr 2019 15:49:51 -0400 (EDT)
From: Daniel Santos <daniel.santos@pobox.com>
To: qemu-devel <qemu-devel@nongnu.org>
Date: Wed, 17 Apr 2019 14:48:21 -0500
Message-Id: <20190417194821.23017-1-daniel.santos@pobox.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Pobox-Relay-ID: F6DE6408-6149-11E9-9887-DF19F34BB12D-06139138!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 64.147.108.71
Subject: [Qemu-devel] [PATCH] mips: Fix "Unexpected FPU mode"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Daniel Santos <daniel.santos@pobox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417194821.kpr8ozijgYBkMo4q8fQHIuI8sMbhcJQ3Q4eTR4vLMHk@z>

In load_elf_binary, struct image_info interp_info is used without being
properly initialized.  One result is that when the ELF's program header
doesn't contain an entry for the ABI flags, then the value of the struct
image_info's fp_abi field is set to whatever happened to be in stack
memory at the time.

This patch both sanitizes interp_info and initializes fp_abi for
TARGET_MIPS to MIPS_ABI_FP_UNKNOWN so that when we don't know the FP
ABI, we don't just blow up.  Currently, this bug is a complete stopper
for some MIPS binaries.

***PLEASE NOTE***
There may be other bugs as a result of struct image_info interp_info
fields not being properly initialized -- this patch only addresses the
fp_abi field.  I reccomend somebody who knows the code better than I
audit this function and the whole of that execution path.

Fixes bug #1825002 and affects 3.1.0 and 4.x, reccomend backporting to
3.1.0.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a26021f8..7f09d572a2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, str=
uct image_info *info)
     char *elf_interpreter =3D NULL;
     char *scratch;
=20
+    memset(&interp_info, 0, sizeof(interp_info));
+#ifdef TARGET_MIPS
+    interp_info.fp_abi =3D MIPS_ABI_FP_UNKNOWN;
+#endif
+
     info->start_mmap =3D (abi_ulong)ELF_START_MMAP;
=20
     load_elf_image(bprm->filename, bprm->fd, info,
--=20
2.19.2


