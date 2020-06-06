Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FAFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D61206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D61206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYpl-0008Mw-V9
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYge-0007P4-Gx
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:36 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgb-0007fx-Ut
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:36 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWRmF-1jRQTL1J51-00XqCz; Sat, 06 Jun 2020 15:16:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/19] configure: Avoid building TCG when not needed
Date: Sat,  6 Jun 2020 15:15:56 +0200
Message-Id: <20200606131607.1250819-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:euRh+2bSeRHBL0yyFQR5Tn3qrNSUgtcO0BzEgWzoR3PFD5VIN2W
 Y2YCfjhUH8Uzp+9LI79M6AAHfVq4Zr4jTj6AKKIMM/a9qKbS+O2bbsWbPpFiimALZ2sR2up
 6hfa8ZllXd52AE5OR79gTU8QJ93r6SilGsfvqxzGwx/2J2oeDyuf0ZW44JFBI7aS2BHuzR6
 2tiR/U+DkZb+zyJ+PljKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iFs+jX96zEU=:szVbC4Jtsnaf49lrpV7DDv
 fttqqejwaLFLlHMYjooGD/Z5ukxhmdwzYfeGsYvnbDyrZT1I6keADM2/iLYmrk4wbPTyIpd99
 Y0VLFRgp4O7SoxygUqHMbecu9znNafKfOxT3smrgHeGITlY5Vjk0LK8DLzdIKA3q7rC2eCE8k
 bj6L0gwniGMJzfV2lzwteUFpWOMbZZMS5nCeONWaS5ztiKrfy1PhLjtUSI7vDYLEhUywaRL1Z
 pD/pbTbhzmjPCLi813aA60ZjsK+SEt027IVxRuvbMqtK1FXsl7GAXy0zbPck/eHMEUDOFZ7sP
 /w9n95W12L8d7ltvPwYWcLGKN6FqPMHwEE1PupXSVIMxyavPcXYB/jKnCZ0AfiO+lQHd4Rip0
 MM/12D3aUTp1bQfKBB41/DHJjrjAYw91XPhg6gRuyMqX0rsvM26rSy4Hjx5T8PU2EQJE1UV3s
 hOe8Fw2PTyjGteZBcMNyby8qBPSAK9FuQXRIHVY4Tm1FMk17/fz9J28eS8rSEq1A4b4QVCvXd
 aLwOjsGVsZ9TplwCwv+uvC3iOuTazyOx1i9pBV65M8Z3jJl5kvfnX6USNwbG2a2CynDduQ09E
 ZlMN8wntbjaw9hn1HCCjYsh+nfv/QWMkyr5ND43aDisT1JhZTfZMOoryKi+4qTbDjMIYW1Qv4
 T43RWKTI9WY33/ONKVRfdEZebdXmLYKXdkks3qurA9FEPEMnDzJAAi7wT6Vz6lPlouWEGjF4r
 hhgcrkoTNZkkIeK1KGs4k058tt9lqUL9rj5Xh3CsR/QHL3/Nz6a26rMeO3JJAwa/1GZdr7qPI
 8wZENyE0JKyq/c1+mik8+qwaIj2RHt7hdFGbKoebVPRlRqLFkaip4luXO0wftTX8yPTFFtp
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid building TCG when building only tools:

  ./configure --enable-tools --disable-system --disable-user

This saves us from running the soft-float tests enabled since
commit 76170102508.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index b969dee675bb..fccc56bd4d1f 100755
--- a/configure
+++ b/configure
@@ -1663,6 +1663,10 @@ if [ "$ARCH" = "unknown" ]; then
   linux_user="no"
 fi
 
+if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
+  tcg="no"
+fi
+
 default_target_list=""
 
 mak_wilds=""
-- 
2.26.2


