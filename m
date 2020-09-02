Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1054C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC09820709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC09820709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSLX-0005Cu-R0
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDSKu-0003qb-IT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:58:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDSKs-0006sV-R3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:58:00 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhUDj-1kq4XJ1rNr-00ebXT; Wed, 02 Sep 2020 14:57:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: fix implicit conversion from enumeration type
 error
Date: Wed,  2 Sep 2020 14:57:52 +0200
Message-Id: <20200902125752.1033524-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gvEqwXmBaIrlhBX1mj0oaC0WTvEwYq2UWm+cp7LK1cRhHidNSjJ
 +Wo/oRaokKTRVJc1kFyg3pVwpex7PJ7IUpflILgG0yD2gL6mxWATSZAt/MJyLWDBd0wtoLW
 uYQDy8Jjn8+uyD3HeIM0KwTtqEOUd/5xFXBP3z1fn8AhGXu+hAJQJUe+9MgjXbve5MkFFlC
 4TX4XVDsS7RJAZddJnHoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kcuyfCzr53U=:X/8nppnkxh/fBO3moCa2GM
 zUx2eYcq7bmUfzg76wUDqk+rX21GNi1VBZ8qzJgdrhQ+34J3AyHiSbdIzpYkPuWdsTgkHbkfa
 DnOZuIovqt4qo1W0HYrFh4hnJ6p+wMwfVZ5pKC+C8jeUF21QbwBlaNblu0uR0M/UnIwYn1jFM
 SHQGOgsNxV8NBiaiBWJ3ceifNjGBHsclLw4TuYcTK/hkhWp5nFaz/yhBEQ+fORFXgJ+2ui8dw
 R5GWNp3uYs5T66d3QNJH5p2OI0DGwV8ThoAVt/3rhP4VaWw0huUlIJua9+v33TCQ4/pOS+GVc
 QuX9l/L/MFiO8F21zEg9Z48rXAFPxXe9mzzUo67LGouyfqWd37e1OQhXlEOIkkujX52wUVmZ4
 OMws4u2sB1f7IT6cLmJUV7N48mYdseM4Bw28XpD56IEDSTU8jhQONDRaiVwDEKS9M4e8/xEjs
 /hEW4q5iNgpi0wMXKi+BymBWcSJmCwLmsW3eHjr6WwiymXUXQ1AbGu07POP37J60Wv5PosN7E
 ytl6R/RMxPYqir+HjnlTXSPeC2wiuCiuMRyWVeL9I6oXpPEN/hsNwLVTOZEbEDlaZWEGnruZa
 X85MJxyHoVZON/7GInlWB8vsozcb721+GBlTQHkp9j7mjv9VY1k9jTPm2gh4SIA2h3435dBVj
 kom+gliAsbdmyuyHFu22yw8ufuylGZb8+WQNLSGmcqL/53tqsvGtj2fwaO7PgAfEH/+mxz7Kj
 LPhElHKavf2AT+JU9roDyJFO6ljlnPb0oCVCGqmo/p4HnPIVFGhmuw+BROj4x/t6av/2uyTlh
 dNBxFkTxFQTsMmuojLqan9L6JL0cCjHexZyXmuH5uFZ3RGctdWFLyMatZG509q5MbWp+rcC
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 08:57:56
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>, Laurent Vivier <laurent@vivier.eu>
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

Notes:
    v2: put "size" in parentheses as it can be an expression

 include/exec/user/thunk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index a5bbb2c73331..b281dfa30f8c 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -42,7 +42,7 @@ typedef enum argtype {
 } argtype;
 
 #define MK_PTR(type) TYPE_PTR, type
-#define MK_ARRAY(type, size) TYPE_ARRAY, size, type
+#define MK_ARRAY(type, size) TYPE_ARRAY, (int)(size), type
 #define MK_STRUCT(id) TYPE_STRUCT, id
 
 #define THUNK_TARGET 0
-- 
2.26.2


