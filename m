Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7875C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CE6207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CE6207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNSp-0005Pr-T9
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRu-0003nl-11
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:38 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNRs-00009t-4I
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:37 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MjjGX-1ksAzj22B9-00lGdp; Thu, 27 Aug 2020 21:20:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] linux-user: Add an api to print enumareted argument
 values with strace
Date: Thu, 27 Aug 2020 21:20:07 +0200
Message-Id: <20200827192018.2442099-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jqQMqOhtuR1A/Ay/ViJsseUcs9HDX+M+aq/wRRm2b7oNcoo5RUp
 7VwYdPfef6idsPuniy6ussWApKpvx12z50IuCwR4/I0GOnDHfCYbbxtppDkdlN61ue4EO6A
 VscrwklMYMt/FV1uqAS9e8BCjmYSZsIliKjdIcrokFuK6PREoWh2IWSG1dw+88txJ0IhVXP
 x4EbSxaUCKzyLSBr6WhBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vDy07wQdTt8=:LJFdc7Cr1LvZvocuP5OsH1
 zP9Fq3pkZiZpRbRBYm/R/gmsOtYKAFtILhlYC1RGbsJORG54xCFvfIYscUnhQXjhxfw/vm8F+
 38hVeayenUYODUWDXADQR/yWeb9lAStwfw5urH0a/nxgqITikSFM3EjIZG5UDY8fHsPaSz240
 f2P4VluBoTh5/JM6SLbO2Xqxfx2Cou1FosIABSMg3F/vvNoBzuySYhWFSNTz2d5uBOAYyLRHd
 5D80zHhVT7gfDn4ZOl1VJAoWo2CQW0G64+h+1QKSgU20F8p9i9yOTUPwxczIBEyR4XpgWg7Jr
 VXP6Tkrp9JzoMB7IYvXgOsH1/QCOPLNhcaU199vYThR30k6Q1kd/rMHthNTXYPm20d1t0RDIp
 HOUPOnVitzHHgQYLBpvJarypqly77o69IFQGuoR6YZa8/mzGL6Qma1PIJDkPLwrL0RACbd91h
 vYmIZ5TRy6nInvxLUStYiljCgesQsn1lVH2VDyLCxYDYOwcSLBlhT70ckZlI23qrHLA3uMGy4
 +cvdRJXsDve0Soet1XaEjSaSl2Ye1X86O16Xk5IQZdJyinV7q/bGBDuBKNR8V0fkPJhMsgFB9
 yEQIaLEBWcJ8n7FBeO+FKzDdA4pivKq/6/x5fk2fNNRGNVGfnAMaaw+5nIhTBQ+XmSo14Kbpn
 Kflsm/irUHKktNYd363EENGFomTVTcNQ7bnG1X4UweEtJMRbxA15VRdq14deSTInGpuzvt+KW
 sRtblsIJFNa58wr7Q9a9d2iH6y1OP9FfYCRhMbuTq75NmQ0yE4qPJXTN9Bw0JedM0vOKuzMDg
 +KhA2Xcr4dPXvBEEpdHJMRRkkOYP/xgEDRzHl0DsXThpEkdmpmL31spewGeGyQlplkfFV36
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:34
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch introduces a type 'struct enums' and function 'print_enums()'
that can be used to print enumerated argument values of some syscalls
in strace. This can be used in future strace implementations.

Also, macros 'ENUM_GENERIC()', 'ENUM_TARGET()' and 'ENUM_END', are
introduced to enable automatic generation of aproppriate enumarated
values and their repsective string representations (these macros are
exactly the same as 'FLAG_GENERIC()', 'FLAG_TARGET()' and 'FLAG_END').

Future patches are planned to modify all existing print functions in
'strace.c' that print arguments of syscalls with enumerated values to
use this new api.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200811164553.27713-5-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4ac54ecffe9c..d0731b888d29 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -52,9 +52,23 @@ struct flags {
 /* end of flags array */
 #define FLAG_END           { 0, NULL }
 
+/* Structure used to translate enumerated values into strings */
+struct enums {
+    abi_long    e_value;   /* enum value */
+    const char  *e_string; /* stringified enum */
+};
+
+/* common enums for all architectures */
+#define ENUM_GENERIC(name) { name, #name }
+/* target specific enums */
+#define ENUM_TARGET(name)  { TARGET_ ## name, #name }
+/* end of enums array */
+#define ENUM_END           { 0, NULL }
+
 UNUSED static const char *get_comma(int);
 UNUSED static void print_pointer(abi_long, int);
 UNUSED static void print_flags(const struct flags *, abi_long, int);
+UNUSED static void print_enums(const struct enums *, abi_long, int);
 UNUSED static void print_at_dirfd(abi_long, int);
 UNUSED static void print_file_mode(abi_long, int);
 UNUSED static void print_open_flags(abi_long, int);
@@ -1252,6 +1266,23 @@ print_flags(const struct flags *f, abi_long flags, int last)
     }
 }
 
+static void
+print_enums(const struct enums *e, abi_long enum_arg, int last)
+{
+    for (; e->e_string != NULL; e++) {
+        if (e->e_value == enum_arg) {
+            qemu_log("%s", e->e_string);
+            break;
+        }
+    }
+
+    if (e->e_string == NULL) {
+        qemu_log("%#x", (unsigned int)enum_arg);
+    }
+
+    qemu_log("%s", get_comma(last));
+}
+
 static void
 print_at_dirfd(abi_long dirfd, int last)
 {
-- 
2.26.2


