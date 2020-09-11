Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC89C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7718521D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7718521D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGov9-0007L8-C3
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo6-0003BT-67; Fri, 11 Sep 2020 15:34:02 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGoo4-0000rI-Is; Fri, 11 Sep 2020 15:34:01 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MJnnV-1jwgST02wr-00K7QZ; Fri, 11 Sep 2020 21:33:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] target/i386/kvm: Add missing fallthrough comment
Date: Fri, 11 Sep 2020 21:33:30 +0200
Message-Id: <20200911193330.1148942-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8eSCGAMo/5u/kTK+WDIR9jqTjryidJYbIvMIkdsfMbq/F3g0UGc
 FZmmzLd7xa5mMG0LC6Vz/IOJWOta9MTeMy6Fv9YBBnVVu0VlFfPtH/YvXbog9cVn0/mMS7o
 9x8wiSFOFK75QV37p4PzKzKLrQn2MDWFJ++Mlj4w5SkDFXG5DfgjKRdXXhONkmOEJHR5cHf
 xc2F3v8gL/5rDYMMhTwHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BFyx7pkX1ws=:DrsyTQEothKm/cGvb43DTC
 JMSQyjCQ+ACR28sXJrMjaf72G5aCM5KbH/StTZHDyIrFF9tzK4wd9oibiSNDh6eisfcLgOrnR
 RlqoirwiJakCUjLHvq4uqo9KwZWjNZ2+lz5yzg9TyMuheoaeFwbFMVrZKaFamHnHXJLJd7iPA
 TbzhQQyajWKY4rOh2rJ1GMX0O7P7kH6+7tbVqSAM7j6ORHDKXuHdxNhj+JIKhWGuOI9OlTE2D
 0W0HrmvVnt6E/fWcVheE0EYnw8krXMYWuJZtirh+v8fMctFKDsBHvuceI/fA+H38bRdn+hxx+
 NsWZSxbTjLl/PT7QnKQXcwZVoZUAC0N50j+aeOFRcOX+hgnHU6WDqszKaAVPmx3a8AKFi+H9B
 gqUovXvL+HhjQEz6JXGksS1GLiK4O+3cekMbUthvwd18f1F0750YsFFSdaFvx/nitrtjCnHm5
 kqeDFIOzYUK0y59Y3ivpVRhE15T4PapGt0fN2NNlY/WbDoIIzWhrYzkf0Yj84UMfsCUxr2lo2
 JuoTXfNYMhRQqMS2TN5ZEaj2NL2DqAnQhV9AqT6FwUWsDJjY6rmbL1X4RnNZ42r0AuMOztMWL
 mLak7DXOL8vX2kVjPungn6H/9TYcBLBg88sr/cUib3Dkk5YwQerRHPIYFGF/m8HpIq4UIrBtc
 FljG1Dy/zlRjVE38JtEOJDnEYcUd+k/E2mWkA/dGy1vUQARSA2eSVlhtWv31SE4ITakDDduRz
 iBS8hl0RGS28lvNibl8jKadFBhFpZ5q1Zv1TK8Linxwi3rOa1jM3zGnCy6tczPCRA0qfVUfux
 wiKvXDKekg5AoZGcb/uRh3WFytYU2rZCsfzj8UVSVW8AMmTAP8LYXz/VX7MQGH3lyJ1Z9YN
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:34
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Let's make this file compilable with -Werror=implicit-fallthrough :
Looking at the code, it seems like the fallthrough is intended here,
so we should add the corresponding "/* fallthrough */" comment here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200911125301.413081-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3d640a8decf6..d87af57a23ce 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1568,6 +1568,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             if (env->nr_dies < 2) {
                 break;
             }
+            /* fallthrough */
         case 4:
         case 0xb:
         case 0xd:
-- 
2.26.2


