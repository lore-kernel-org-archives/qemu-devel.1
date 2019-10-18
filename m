Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4119BCA9EC8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 00:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D09721897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 00:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMryWd4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D09721897
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLG06-0007su-SU
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 20:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47174)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3FQWpXQMKCrYoYsckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--scw.bounces.google.com>)
 id 1iLFzU-0007UJ-J0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3FQWpXQMKCrYoYsckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--scw.bounces.google.com>)
 id 1iLFzT-0003dd-C5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:19:36 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a]:41231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3FQWpXQMKCrYoYsckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--scw.bounces.google.com>)
 id 1iLFzT-0003dQ-49
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 20:19:35 -0400
Received: by mail-pf1-x44a.google.com with SMTP id 22so3133229pfx.8
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 17:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=UdbBcmCLPRnveWCVrsP73N+BiQY65mZZxM9m0KDS0ds=;
 b=rMryWd4bUz37a+YylXuOCIKLAHaD/g5br8VCB0ob8rZ71QapUp1Dt5rAd0Od/Q9qDW
 K2CL8ogxYwA32QSSjVR9QKazhZcLSFVrN94fODv18cLRGDz5SkKzFfby4F0EZ13CAsR3
 CVIQH6g0qaekxdXjFQBdu+3o/eykrRmUpXNOd61J5m+ijbBpbca1xw9dyW7HPaHZaUf4
 BceiZrgxt6Oi7olcBI1EMP5IebF09ZX25I/sAHF2SYYg1mCYgvud/PhljIaXGAp/qpDg
 Zms+wX/1Af5sfnmI4Z2qXPIs+J6kelz6oLyUj8U0iqzcpfx1lf30CC0Wf+sEFV8OhlM8
 j0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=UdbBcmCLPRnveWCVrsP73N+BiQY65mZZxM9m0KDS0ds=;
 b=k+h4zTNc+AnIC46pUFzPnpYOynQYHb+hgk2raPDGWrFRFXRiABLUzHN8Rvxi22y6K2
 0WX7qYOGqKrSC9TfuV+vxq4YtjNuWejXjeHH5dvEQ8cmOscrJFbmEU5460qEFmXfTq1p
 toiqJi29d/obdrxLHqZ92QMhexyKvfURt7THmtrQMlIoh5NC5ZfpgZNxlkxigEIeWYK5
 BvAp3d1l9SPXDPC9jUxXPdKido7eUKllrBgt2hojhzxtFnzSKqoJy+mHq8PKC1WaKhuU
 FFeAQzJzWqZh66ZUb9pxsyKktWXcU/84VxtvB5a4OMoES1gbSrJxK2iOgThc+ur44qAQ
 tToA==
X-Gm-Message-State: APjAAAWu3NGgLCj/mgJMGanyzjApydtkMAwtXTLoQzXA/DxAq8kH2oat
 iRvk+XUoFQyTmeHmh8mzVguaZ9g=
X-Google-Smtp-Source: APXvYqyeORYpQPiMJ1ol4WwL8+7yCMdKdYQJuussJHbI/1dAeUUobcboPmgVdLkEMreUMNLqlLMFOVQ=
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr6833780pgt.38.1571357973208;
 Thu, 17 Oct 2019 17:19:33 -0700 (PDT)
Date: Thu, 17 Oct 2019 17:19:20 -0700
Message-Id: <20191018001920.178283-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH] Fix unsigned integer underflow in fd-trans.c
From: Shu-Chun Weng <scw@google.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::44a
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

In any of these `*_for_each_*` functions, the last entry in the buffer (so the
"remaining length in the buffer" `len` is equal to the length of the
entry `nlmsg_len`/`nla_len`/etc) has size that is not a multiple of the
alignment, the aligned lengths `*_ALIGN(*_len)` will be greater than `len`.
Since `len` is unsigned (`size_t`), it underflows and the loop will read
pass the buffer.

This may manifest as random EINVAL or EOPNOTSUPP error on IO or network
system calls.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/fd-trans.c | 51 +++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 60077ce531..9b92386abf 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -279,6 +279,7 @@ static abi_long host_to_target_for_each_nlmsg(struct nlmsghdr *nlh,
                                                        (struct nlmsghdr *))
 {
     uint32_t nlmsg_len;
+    uint32_t aligned_nlmsg_len;
     abi_long ret;
 
     while (len > sizeof(struct nlmsghdr)) {
@@ -312,8 +313,13 @@ static abi_long host_to_target_for_each_nlmsg(struct nlmsghdr *nlh,
             break;
         }
         tswap_nlmsghdr(nlh);
-        len -= NLMSG_ALIGN(nlmsg_len);
-        nlh = (struct nlmsghdr *)(((char*)nlh) + NLMSG_ALIGN(nlmsg_len));
+
+        aligned_nlmsg_len = NLMSG_ALIGN(nlmsg_len);
+        if (aligned_nlmsg_len >= len) {
+            break;
+        }
+        len -= aligned_nlmsg_len;
+        nlh = (struct nlmsghdr *)(((char*)nlh) + aligned_nlmsg_len);
     }
     return 0;
 }
@@ -323,6 +329,7 @@ static abi_long target_to_host_for_each_nlmsg(struct nlmsghdr *nlh,
                                               abi_long (*target_to_host_nlmsg)
                                                        (struct nlmsghdr *))
 {
+    uint32_t aligned_nlmsg_len;
     int ret;
 
     while (len > sizeof(struct nlmsghdr)) {
@@ -349,8 +356,13 @@ static abi_long target_to_host_for_each_nlmsg(struct nlmsghdr *nlh,
                 return ret;
             }
         }
-        len -= NLMSG_ALIGN(nlh->nlmsg_len);
-        nlh = (struct nlmsghdr *)(((char *)nlh) + NLMSG_ALIGN(nlh->nlmsg_len));
+
+        aligned_nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len);
+        if (aligned_nlmsg_len >= len) {
+            break;
+        }
+        len -= aligned_nlmsg_len;
+        nlh = (struct nlmsghdr *)(((char *)nlh) + aligned_nlmsg_len);
     }
     return 0;
 }
@@ -363,6 +375,7 @@ static abi_long host_to_target_for_each_nlattr(struct nlattr *nlattr,
                                                          void *context))
 {
     unsigned short nla_len;
+    unsigned short aligned_nla_len;
     abi_long ret;
 
     while (len > sizeof(struct nlattr)) {
@@ -377,8 +390,13 @@ static abi_long host_to_target_for_each_nlattr(struct nlattr *nlattr,
         if (ret < 0) {
             return ret;
         }
-        len -= NLA_ALIGN(nla_len);
-        nlattr = (struct nlattr *)(((char *)nlattr) + NLA_ALIGN(nla_len));
+
+        aligned_nla_len = NLA_ALIGN(nla_len);
+        if (aligned_nla_len >= len) {
+            break;
+        }
+        len -= aligned_nla_len;
+        nlattr = (struct nlattr *)(((char *)nlattr) + aligned_nla_len);
     }
     return 0;
 }
@@ -389,6 +407,7 @@ static abi_long host_to_target_for_each_rtattr(struct rtattr *rtattr,
                                                         (struct rtattr *))
 {
     unsigned short rta_len;
+    unsigned short aligned_rta_len;
     abi_long ret;
 
     while (len > sizeof(struct rtattr)) {
@@ -403,8 +422,13 @@ static abi_long host_to_target_for_each_rtattr(struct rtattr *rtattr,
         if (ret < 0) {
             return ret;
         }
-        len -= RTA_ALIGN(rta_len);
-        rtattr = (struct rtattr *)(((char *)rtattr) + RTA_ALIGN(rta_len));
+
+        aligned_rta_len = RTA_ALIGN(rta_len);
+        if (aligned_rta_len >= len) {
+            break;
+        }
+        len -= aligned_rta_len;
+        rtattr = (struct rtattr *)(((char *)rtattr) + aligned_rta_len);
     }
     return 0;
 }
@@ -1058,6 +1082,7 @@ static abi_long target_to_host_for_each_rtattr(struct rtattr *rtattr,
                                                abi_long (*target_to_host_rtattr)
                                                         (struct rtattr *))
 {
+    unsigned short aligned_rta_len;
     abi_long ret;
 
     while (len >= sizeof(struct rtattr)) {
@@ -1071,9 +1096,13 @@ static abi_long target_to_host_for_each_rtattr(struct rtattr *rtattr,
         if (ret < 0) {
             return ret;
         }
-        len -= RTA_ALIGN(rtattr->rta_len);
-        rtattr = (struct rtattr *)(((char *)rtattr) +
-                 RTA_ALIGN(rtattr->rta_len));
+
+        aligned_rta_len = RTA_ALIGN(rtattr->rta_len);
+        if (aligned_rta_len >= len) {
+            break;
+        }
+        len -= aligned_rta_len;
+        rtattr = (struct rtattr *)(((char *)rtattr) + aligned_rta_len);
     }
     return 0;
 }
-- 
2.23.0.866.gb869b98d4c-goog


