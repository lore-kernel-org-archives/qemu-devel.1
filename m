Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C74C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC92E20700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NxdjAipN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC92E20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS5Up-0006Eh-QV
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS5Ok-0004zm-9z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS5Oj-000844-Le
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:58:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:33309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jS5Oj-0007y8-3Z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587761877;
 bh=Y7M5KzT+T5sJOC2naW5SJJl9NbH4rAG+3a3/TmjMdA8=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=NxdjAipNm5/X0NGbKXRaaF3YMPIXbnGj7UbUgsnVlrF47ll4GkxBDNx8m2amq521N
 cZtPnoplC3IZh1rrHvnYwNHXoW0HetdtqiokZRKy7JwftdlXdSo0Y1rCWQQ9fTH23S
 0hz67TjdLbS+clqLaybw998OS5HS/4nsueItIUQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.192]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1j0AUl0mzO-00hiXZ; Fri, 24
 Apr 2020 22:57:57 +0200
Date: Fri, 24 Apr 2020 22:57:55 +0200
From: Helge Deller <deller@gmx.de>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Drop unnecessary check in dup3 syscall
Message-ID: <20200424205755.GA26282@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:asytLhm1AYbVB71ENR2XnH6r/+ajXAPZgEy30GTIDP8LxXOvhfs
 zakPbwy1o31rcMcbex3vdkTHhNs8iwgDwKrtnmGyIQctPwn+a1ZorZtIEKArrGB7D2vRWnR
 o/za+zl1KgQeHktG2wCP2JDTwT1pIRDzCCByOpVKlmVa61/9Nc27KRzZUFSk3C5jXPlp5f5
 fDHd1969w7qMu1GFJOZAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7JLBFDNXn+E=:3SPG7gWvGYQB37voW8dbWO
 RBMmKEgjtTH64BnH3+2XlbFT2qnOMglPXuNmBWSq2I/OnJFzIAqdlc8QX11nbWkl9ABAnHTWk
 W+G1qC3E2KyNaql9m2Miu/AsHCHUwYfY6+kvXKD8s1BuUY/qXpMqPzQPk0smIFTBYIBsupiWv
 d5NaA+IKYKDEFDboQev/Mbp2dOuf1CzuAc6T/QMEVRaXbjJjtgkOTo6XoUpaMhgBQ2tSLpfhi
 8uftFIKC3Ci/rOxXnFuuAtavOCuQhv3zNMx1ktOhcvjGYMSOpXTYfSed3roZYaL8MR6U4068a
 Q/ye+ex7T98vwsS5qNJwxbR/qlpXM99Xi4W6LOscV2qPq9J4d4OGEQC31lu8Eu89ANYVFfk7R
 aY06cBL9iGtCEuRV2I1VO3Y3mo3Aof1MNC8BUUfyeHCzkRfGTR8UW0Me/4/pg4TevhYFgEUWm
 vE5HDUcqyqeqdfMFV9db1oWPlnOwijzQJh0fTy9V1jDgUmNrIHezEsG2bNsMZOx1sNr/AdEg0
 6eBTRTB/AG+vgszwT5fEdtbfpbI6PVLj6CzEwfK/6oo4jHNizQwMbBv9aPj2SXERyHM2FcYgq
 oaYsepcnnWUb0iwDSbB2ekT5SdRESpZBafDH7m14E5cQeOPAv8loybwfbsMELKY28pM7Zhm5x
 DhKAGFQZ+YqoZ7eZLL9rTL06/wqclfMON4XPLZtPLVzcQWupR8aZAAo9QNi1Ra84H80JsA2MP
 KKwKsl+11ImSNhKVK8R+WBM/U8kITxZK14ilHM5u4fYRdOUlhVTf60a7l8XAipgHT90viZBqF
 axlWEDa3LS+Z63P4CQPhAAmvS6jxHasjJqsClLvNfpHBEqqcuHXPWFxE5/OCh+dziJfe/TuBn
 tu9ahFW4WV0N1PSWjop2n06NGGuP6XfsO74AY4oWIWbC2pF+NxMkouTHBvVOasYLURnqqOGR/
 a0TxoaVAtN5aP2j/WuzYS3Gxk3+K7IJiE8khTfpnXF8foRrUjpzCmJ5olk6K6xUFx9t4McAlf
 EONHGcTKNHj1U43P5561DdYSwwscNG7h++iotPwmHz0BPcdtaaCH4ynUmtgZQXlvj5/qqMsNj
 GJEkShjMezxrV/vKHTVRubJzRElGtPr8XWMjt5JXysmQvvsoRjFrHj51BegNuKHgcepncHnzA
 k/wHOXugVkn3hw8UM53R36iE/b0l5pu5zv4ac1j4jdNDo9Pm7rxxVMxr6gVDQ5l+Y6Xfil34f
 uCIkQVXI49lbWD0y9
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 16:58:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop the extra check in dup3() if anything other than FD_CLOEXEC (aka
O_CLOEXEC) was given. Instead simply rely on any error codes returned by
the host dup3() syscall.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..ebf0d38321 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8301,12 +8310,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
     case TARGET_NR_dup3:
     {
-        int host_flags;
-
-        if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
-            return -EINVAL;
-        }
-        host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+        int host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
         ret = get_errno(dup3(arg1, arg2, host_flags));
         if (ret >= 0) {
             fd_trans_dup(arg1, arg2);

