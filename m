Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135CDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F4A20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F4A20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDcAQ-0004zZ-VS
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9k-0003pF-6k
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:39709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9i-0004qS-Gl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:07 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1My3AX-1kV9mC3tfj-00zTax; Thu, 03 Sep 2020 01:27:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] linux-user: fix implicit conversion from enumeration type
 error
Date: Thu,  3 Sep 2020 01:26:53 +0200
Message-Id: <20200902232701.13299-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902232701.13299-1-laurent@vivier.eu>
References: <20200902232701.13299-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BF5KImGEIkpO0eoBG+XYKykPNC8DYx//J6NyWjNPDhcQHLaymDN
 +tj7fQPvQ5UOykUqg60ynkw76N5phaFrwuMEgKJf5Mnbcn/DdMFNYlpv4Rs70/0k/Zsi889
 QpG/ZfKXSOvbauM7mJnx04GvY7hQfUQynr8Ko7KP0Mp32+kp25L6wvLCz2BArQSxpm9pwoL
 MzoBgavgzTeyDySYgPhDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cgIW17SNrhY=:cFC0MqCJAnXeVWUNnVZOnu
 kgJKryIdGnfhQnlFtdxft6nMg5EQUxze3DQvJ/9sgRWHqZRrAuA+Fmlc5JZDu/EhikxBhcW22
 ixKabhLgOxV8IGNS5T2iCs3mkUrQvz/CKZ9zvTdKjiSy4rVtn+fWmyUlUya1Y3bPhXFPj+6YZ
 fSbDNkPCKmcmBKDbpIE7AjH8Bnk6ikoOZiZpb4BMALOyYWYKcgh/IHhcFHOG2maJkBpl+Yw4M
 q7x7AYWGDqG1inPDqeSug7XHUJafeB8LMilwYCv7HrEKBOuUuv2d5CL8NMTupK74DXBfrcfaL
 ODfCZ35CPNn/ewL8TUs0heD7cY8DlFlGlV+qng/K5+IC4i5M58G4tW3E/bvJ75wKX5HqqdhaY
 NToa9eErdNgNS3fTVOWLl0OlHtUFqV33uHVmgmCGykoUBQTBo1e8YIy/KLntjcxNk5Rtru6kJ
 dzQkHcpam3vGwez8BTyZg07GsYxQvfMW1QDXyyZ9QDv/u7eDj3xf+tqyhIiXlj0bb6CIVZT8I
 1Ni6B3fA3Yb/kE9OoWvu9RIVeCnF2ruHlVTeFTgp5Vk5a4Lz5bzX4quP81C8jboNWGU4LhiRW
 zZrhktIAwO99Tbn3a+3lVBO9yvuWzwz79bKKcppKLk/wMafZC0MRANLg+JNQC+arPHN4RZsig
 F+Ae53+gnMKosL/ecYqnkkphSIqTRg7UNETk77OdDqygH7bM06kGyJ6VXGucBHljB674mRd0H
 43EjTI2agbIcsMbevZziutImbBlH1drnAJdvJlTqW0uj7zE7/nlwJf/09251WmdusbEu6i6TZ
 duevqrEglwwgjICae8M9/FMofo3ZvS3qxITNGS8dtf9pBJNKlzRchFcyYS2znBQl+89jnIr
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 19:27:04
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MK_ARRAY(type,size) is used to fill the field_types buffer, and if the
"size" parameter is an enum type, clang [-Werror,-Wenum-conversion] reports
an error when it is assigned to field_types which is also an enum, argtypes.

To avoid that, convert "size" to "int" in MK_ARRAY(). "int" is the type
used for the size evaluation in thunk_type_size().

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200902125752.1033524-1-laurent@vivier.eu>
---
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


