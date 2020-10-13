Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C71DC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB0C207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB0C207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEM4-0001wA-I4
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBg-0005FD-Ja; Tue, 13 Oct 2020 02:53:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBc-0000GI-Ek; Tue, 13 Oct 2020 02:53:32 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N336L-1kKLNi2uCr-013Lja; Tue, 13 Oct 2020 08:53:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/15] hw/block/nvme: Simplify timestamp sum
Date: Tue, 13 Oct 2020 08:53:02 +0200
Message-Id: <20201013065313.7349-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:thAWqtsOGGWdyx3A3Sp8/A5qpp41eiSiBlLglRFkNQzyIPGxnZ6
 x5L+hByGdftKt6F+PJpwtI6/zjr4w6CDEYGZufyqNwjYVinqUjasEQ0mcA3cw0MucGk9/kX
 2VbeNfo4/IjDKETZMvycvD/3kwxi67wlt51ZHxfnQyq+0w0jcdZb5bzYP2/GzgACJu6J1cc
 fDIBke9v00Is49KOW/SJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jtwOttJ3RqU=:166esNlX+yG2yLk+OMflJW
 0uixCK4xUl3jtdGKtfKeTH70kCiAwKeP1LIDMJ0onYPE41iuiN8iS960z3ra4QkqbsGc8SHQO
 p0H3eYVQ51rQid0Szc1uzYLo0TzX0Kt4lC7uXGtQ8HN8vYgyLANlztfeIIVEx4k5QFekUJHBe
 i6YFFLMmXCh7JLWM6CtI1TpXtkZ/avvbDxlp1Ph76/HZ6GZMutGqFVGIVcP2tJoVQcYNEqqke
 NTwKLSiXMndv+vIQ8VHUENKYLSoogOxc4br4xREnD5XXcJO1SKQtR5ev1hSafSGUQxvBRFdPO
 BZGFwRZvvn6uxJXVJM/opJdCKkzNtMoyYra5e7SDBBtTekqZwVgI6Ghh86mobwLmW/IXSYz6q
 kkS2l+wTB/glZEJZRR3Pd6eXSVcyJ2TpexZLNKTygC/WBOtQwyimsKRjn4CnHqGfNBkrAixvy
 MzqvWjuDwVoWH1zEl6V0dMFgcKncrAUJeqmR6+3DAIVlnGeZWhrk7fnJHBJmL3zPSuACXgTNQ
 /i5vjWEHj50raUCymIS4B9qzHfHBwOFyz1xQdb9E+UFU1LPaSPPuItRBYeHyOx9a5jBeta5qg
 5fMX9DWGDSJ1BnYMJrhuqOekKrJEItTPuTrlF+sowdp6EI4RF+eIalT9wYEZNVkGOvzdP5OQj
 mKdyPgiaLauY9eaujfTXuZRxEdTdRRTap59GcWdpnw2wPyVBKBmBj4ry04AlYi1fJkYqhFg0e
 v05CZqhYvyIt0utbQAFD0YvUKU8OKUF9lJ8RZdUwS2fXrTrWZ1J/IDfr92gDXdF9YpBulr9Jn
 cZk8WnHTQa/zc3jtVHqLeEjJzQNJFjQsPNio30dtPbDLdghgc6haYmbjxFp6ye8p+2KQ+lL
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:21
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As the 'timestamp' variable is declared as a 48-bit bitfield,
we do not need to wrap the sum result.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Message-Id: <20201002075716.1657849-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/block/nvme.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63078f600920..44fa5b90769b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1280,12 +1280,7 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
 
     union nvme_timestamp ts;
     ts.all = 0;
-
-    /*
-     * If the sum of the Timestamp value set by the host and the elapsed
-     * time exceeds 2^48, the value returned should be reduced modulo 2^48.
-     */
-    ts.timestamp = (n->host_timestamp + elapsed_time) & 0xffffffffffff;
+    ts.timestamp = n->host_timestamp + elapsed_time;
 
     /* If the host timestamp is non-zero, set the timestamp origin */
     ts.origin = n->host_timestamp ? 0x01 : 0x00;
-- 
2.26.2


