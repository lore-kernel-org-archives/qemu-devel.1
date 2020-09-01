Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16BEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45B7204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45B7204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8qK-0005fS-NW
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kD8Hv-0003yL-JS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:33:35 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kD8Ht-0008UR-Tu
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:33:35 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MdwRi-1kkp920jWI-00b5nn; Tue, 01 Sep 2020 17:33:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: fix implicit conversion from enumeration type
 error
Date: Tue,  1 Sep 2020 17:33:21 +0200
Message-Id: <20200901153321.920490-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t7fLNYjmVWVsgcmOTqVx4r3QPEP4kaIRaNw9xN6EIFmSHG7iR9P
 W4Ub5il91XLJYPGE4Eeawqy/CWyKQgss5X+3XnKjSGCjB3vl/KM2CBsxpw8aE3zk4EymJGv
 Doh3p3I0kEQh7aXwbdacnDPu+k0mM5b71ylyyuiyEOjn692mp+XGeiVDG1ffgT6TeVu6PiI
 0ci/wk/LOVg1vaAcCnS2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:44/Vfp6phLY=:Zz1wh/nZdiMpnjhU5kWyGv
 FQgTT/eRNhxORP2Q0i0Dyb/iViOw74sVfds+rghUg6qiKs8peEM8+EUkn3C6Pme94ehy7RkmM
 x/BI6Zb+PglHR3HuKZJl9Gx/YIwBu8QvxhK5CSA+9uFij7fN8ATou9qrU+f0HwxQDQgm6fMDh
 WPsJcraaHMj9zLTiA3Mqc59jqjCxOX790piUxDaeGqMKmEXR9eGxvR3ZvYc4dO/BPMcmVKRTl
 3lc6kSIm+Ima5fcbz/7oLDt/Hj1NHK11m3qTO2pLJ75zZeJwXSElnT9PRfirqyepLGPdpCQP3
 Dvq6XyavGMjUXEO4xDAWy9m7QlFLPhEnV4+pfmM5i8YreKzefGt/DuDINg6VR0aLi6Ol17J39
 Kn6+FHEpOqYop2QKr+7khQf8AC1kNrS5riLHpqa0Xhww7MX/HgXkKUogASf56r4oQBoi8miEc
 vh50DchrODrsbuCTssPN1MfovCyyc1dQ3VJC9O18wWl4Ct6w1Ak39rZ3+c30iWn/mxO2YXDYo
 iaQ0mglkb+u/eY/4n0T/JKvBikNLWZygkXXvQYugy07mpuxdWfs/U2yh9T9vTSYZnLEVnP9FO
 LfE8SKzlYVTCwvrj4ORMN7ZIGlvMYettRltDlTdIdYniHaU82pW6JO4I/8NTMr8HLslsy+3yh
 tHyljK5wDPZL/OhGAjLNQ/c7i0M73Vx1ZneUXRy/V+8zAAJjNVoOKvw5ltix6GZUQeRaAPzf6
 BCn56uy4QwZsj+bj0qLrxxgli/w4V961wSk++HuWnCne/R2PlO9xfsX6qdV2TgashlmTfvC9C
 jzOcnF12HLUqGjuhIewBPBLoCkUJTPMAl4Rt1qLT4mkuqNpHIFCYuYCY2PX0aekBreGGj0E
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MK_ARRAY(type,size) is used to fill the field_types buffer, and if the
"size" parameter is an enum type, clang [-Werror,-Wenum-conversion] reports
an error when it is assigned to field_types which is also an enum, argtypes.

To avoid that, convert "size" to "int" in MK_ARRAY(). "int" is the type
used for the size evaluation in thunk_type_size().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/user/thunk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index a5bbb2c73331..b798fcb69cf4 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -42,7 +42,7 @@ typedef enum argtype {
 } argtype;
 
 #define MK_PTR(type) TYPE_PTR, type
-#define MK_ARRAY(type, size) TYPE_ARRAY, size, type
+#define MK_ARRAY(type, size) TYPE_ARRAY, (int)size, type
 #define MK_STRUCT(id) TYPE_STRUCT, id
 
 #define THUNK_TARGET 0
-- 
2.26.2


