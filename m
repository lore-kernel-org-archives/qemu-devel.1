Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E1AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA61A235FD
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou8x6dys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA61A235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAab-0005EZ-Jq
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAY5-0002o0-5H; Wed, 23 Sep 2020 15:35:32 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733]:41096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAY2-00005k-P9; Wed, 23 Sep 2020 15:35:28 -0400
Received: by mail-qk1-x733.google.com with SMTP id g72so901316qke.8;
 Wed, 23 Sep 2020 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=foegIg+R6xGelzocg1qpmzjKagMlOEuwe5qYOlr3pzs=;
 b=Ou8x6dysWim4r6RU+56H3ddgEWpce8rwfSKHIMQIQ1WQs/JGedU2zxoSPR8MVrOrah
 p4upj6XztlJniyHB29XkChim+6dH9Wct19ABkHPMOIqsv19TymO/cyYKOg2O/kJ/J40Z
 xOij4GnEW0kTyypUBMfEZdcMZOr0hPRI/8bYRtV1lhUihjs6nidhxPJHSHpNZPyKwAoJ
 ZJvtUXT1W6Nw90y/T32iDj5Z3AMSxMhKmYylFYc9ocm+28mbHSe9Tj1S7s/PZPvvtEyx
 INKz28D23TqJggnAIbIctF+oWoesVaJ3tm2AqFJhQ7Lb2CJdmJlkK8Mf80JWT45KIxK5
 MR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=foegIg+R6xGelzocg1qpmzjKagMlOEuwe5qYOlr3pzs=;
 b=G7O+j0sDlgPTTD5Dt3h4SfQIajBgoOdxUGY2u2JGOvJzv4lUfEIABG9qeSBmWTiwdu
 BCInNIYkD9QwrJmQdWicNz7Dj0aHQTFfzse2NiaGyWyG7kmizOFB+4z8CwlAilbWExXH
 yOz2txe6HkO0mItJhxbfzKbgc2tOUOz4jyyy6aEvLMfZ0bgOveYqasJ4BELYmotezLSU
 iynPFyFa/AFJaHcVYLHKUIaTzftAnS3noRFSKgB5d3QzQx7utpfEqdRCvvRKlKx+esXH
 xB89eyXAbHuVTlYuMDY1RV61E1PBlLEWbDX3LdoeC1WKjpKTFm7pq1xyUA/Dwdv1bTs4
 EuTA==
X-Gm-Message-State: AOAM531Uy7JNDyl64XNAs6MSk2M34qHBfhQfgEt3bFhCMdOz6VWsaOc7
 tI99GqT8Au6684AA9NpOaWUGUvZtmKu6NA==
X-Google-Smtp-Source: ABdhPJy37BANjZRnSzqNB4/hTJsxcDyAjIzWsNcN25VBd9p6OUxgqj5RyJxyyXy8n+UxmR8CAZv2qg==
X-Received: by 2002:a37:9e87:: with SMTP id h129mr1409013qke.276.1600889724944; 
 Wed, 23 Sep 2020 12:35:24 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:9e50:6b84:53b8:5d9d:d408])
 by smtp.gmail.com with ESMTPSA id u4sm612362qkk.68.2020.09.23.12.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 12:35:24 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] specs/ppc-spapr-numa: update with new NUMA support
Date: Wed, 23 Sep 2020 16:34:58 -0300
Message-Id: <20200923193458.203186-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923193458.203186-1-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x733.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This update provides more in depth information about the
choices and drawbacks of the new NUMA support for the
spapr machine.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 docs/specs/ppc-spapr-numa.rst | 213 ++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/docs/specs/ppc-spapr-numa.rst b/docs/specs/ppc-spapr-numa.rst
index e762038022..994bfb996f 100644
--- a/docs/specs/ppc-spapr-numa.rst
+++ b/docs/specs/ppc-spapr-numa.rst
@@ -189,3 +189,216 @@ QEMU up to 5.1, as follows:
 
 This also means that user input in QEMU command line does not change the
 NUMA distancing inside the guest for the pseries machine.
+
+New NUMA mechanics for pseries in QEMU 5.2
+==========================================
+
+Starting in QEMU 5.2, the pseries machine now considers user input when
+setting NUMA topology of the guest. The following changes were made:
+
+* ibm,associativity-reference-points was changed to {0x4, 0x3, 0x2, 0x1}, allowing
+  for 4 distinct NUMA distance values based on the NUMA levels
+
+* ibm,max-associativity-domains was changed to support multiple associativity
+  domains in all NUMA levels. This is needed to ensure user flexibility
+
+* ibm,associativity for all resources now varies with user input
+
+These changes are only effective for pseries-5.2 and newer machines that are
+created with more than one NUMA node (disconsidering NUMA nodes created by
+the machine itself, e.g. NVLink 2 GPUs). The now legacy support has been
+around for such a long time, with users seeing NUMA distances 10 and 40
+(and 80 if using NVLink2 GPUs), and there is no need to disrupt the
+existing experience of those guests.
+
+To bring the user experience x86 users have when tuning up NUMA, we had
+to operate under the current pseries Linux kernel logic described in
+`How the pseries Linux guest calculates NUMA distances`_. The result
+is that we needed to translate NUMA distance user input to pseries
+Linux kernel input.
+
+Translating user distance to kernel distance
+--------------------------------------------
+
+User input for NUMA distance can vary from 10 to 254. We need to translate
+that to the values that the Linux kernel operates on (10, 20, 40, 80, 160).
+This is how it is being done:
+
+* user distance 11 to 30 will be interpreted as 20
+* user distance 31 to 60 will be interpreted as 40
+* user distance 61 to 120 will be interpreted as 80
+* user distance 121 and beyond will be interpreted as 160
+* user distance 10 stays 10
+
+The reasoning behind this aproximation is to avoid any round up to the local
+distance (10), keeping it exclusive to the 4th NUMA level (which is still
+exclusive to the node_id). All other ranges were chosen under the developer
+discretion of what would be (somewhat) sensible considering the user input.
+Any other strategy can be used here, but in the end the reality is that we'll
+have to accept that a large array of values will be translated to the same
+NUMA topology in the guest, e.g. this user input:
+
+::
+
+      0   1   2
+  0  10  31 120
+  1  31  10  30
+  2 120  30  10
+
+And this other user input:
+
+::
+
+      0   1   2
+  0  10  60  61
+  1  60  10  11
+  2  61  11  10
+
+Will both be translated to the same values internally:
+
+::
+
+      0   1   2
+  0  10  40  80
+  1  40  10  20
+  2  80  20  10
+
+Users are encouraged to use only the kernel values in the NUMA definition to
+avoid being taken by surprise with that the guest is actually seeing in the
+topology. There are enough potential surprises that are inherent to the
+associativity domain assignment process, discussed below.
+
+
+How associativity domains are assigned
+--------------------------------------
+
+LOPAPR allows more than one associativity array (or 'string') per allocated
+resource. This would be used to represent that the resource has multiple
+connections with the board, and then the operational system, when deciding
+NUMA distancing, should consider the associativity information that provides
+the shortest distance.
+
+The spapr implementation does not support multiple associativity arrays per
+resource, neither does the pseries Linux kernel. We'll have to represent the
+NUMA topology using one associativity per resource, which means that choices
+and compromises are going to be made.
+
+Consider the following NUMA topology entered by user input:
+
+::
+
+      0   1   2   3
+  0  10  20  20  40
+  1  20  10  80  40
+  2  20  80  10  20
+  3  40  40  20  10
+
+Honoring just the relative distances of node 0 to every other node, one possible
+value for all associativity arrays would be:
+
+* node 0: 0 B A 0
+* node 1: 0 0 A 1
+* node 2: 0 0 A 2
+* node 3: 0 B 0 3
+
+With the reference points {0x4, 0x3, 0x2, 0x1}, for node 0:
+
+* distance from 0 to 1 is 20 (no match at 0x4, will match at 0x3)
+* distance from 0 to 2 is 20 (no match at 0x4, will match at 0x3)
+* distance from 0 to 3 is 40 (no match at 0x4 and 0x3, will match
+  at 0x2)
+
+The distances related to node 0 are well represented. Doing for node 1, and keeping
+in mind that we don't need to revisit node 0 again, the distance from node 1 to
+2 is 80, matching at 0x4:
+
+* node 1: C 0 A 1
+* node 2: C 0 A 2
+
+Over here we already have the first conflict. Even if we assign a new associativity
+domain at 0x4 for 1 and 2, and we do that in the code, the kernel will define
+the distance between 1 and 2 as 20, not 80, because both 1 and 2 have the "A"
+associativity domain from the previous step. If we decide to discard the
+associativity with "A" then the node 0 distances are compromised.
+
+Following up with the distance from 1 to 3 being 40 (a match in 0x2) we have another
+decision to make. These are the current associativity domains of each:
+
+* node 1: C 0 A 1
+* node 3: 0 B 0 3
+
+There is already an associativity domain at 0x2 in node 3, "B", which was assigned
+by the node 0 distances. If we define a new associativity domain at this level
+for 1 and 3 we will overwrite the existing associativity between 0 and 3. What
+the code is doing in this case is to assign the existing domain to the
+current associativity, in this case, "B" is now assigned to the 0x2 of node 1,
+resulting in the following associativity arrays:
+
+* node 0: 0 B A 0
+* node 1: C 0 A 1
+* node 2: C B A 2
+* node 3: 0 B 0 3
+
+In the last step we will analyze just nodes 2 and 3. The desired distance between
+2 and 3 is 20, i.e. a match in 0x3. Node 2 already has a domain assigned in 0x3,
+A, so we do the same as we did in the previous case and assign it to node 3
+at 0x3. This is the end result for the associativity arrays:
+
+* node 0: 0 B A 0
+* node 1: C 0 A 1
+* node 2: C B A 2
+* node 3: 0 B A 3
+
+The kernel will read these arrays and will calculate the following NUMA topology for
+the guest:
+
+::
+
+      0   1   2   3
+  0  10  20  20  20
+  1  20  10  20  20
+  2  20  20  10  20
+  3  20  20  20  10
+
+Which is not what the user wanted, but it is what the current logic and implementation
+constraints of the kernel and QEMU will provide inside the LOPAPR specification.
+
+Changing a single value, specially a low distance value, makes for drastic changes
+in the result. For example, with the same user input from above, but changing the
+node distance from 0 to 1 to 40:
+
+::
+
+      0   1   2   3
+  0  10  40  20  40
+  1  40  10  80  40
+  2  20  80  10  20
+  3  40  40  20  10
+
+This is the result inside the guest, applying the same heuristics:
+
+::
+
+  $ numactl -H
+  available: 4 nodes (0-3)
+  (...)
+  node distances:
+  node   0   1   2   3
+    0:  10  40  20  20
+    1:  40  10  80  40
+    2:  20  80  10  20
+    3:  20  40  20  10
+
+This result is much closer to the user input and only a single distance was changed
+from the original.
+
+The kernel will always match with the shortest associativity domain possible, and we're
+attempting to retain the previous established relations between the nodes. This means
+that a distance equal to 20 between nodes A and B and the same distance 20 between nodes
+A and F will cause the distance between B and F to also be 20. The same will happen to
+other distances, but shorter distances has precedent over it to the distance calculation.
+
+Users are welcome to use this knowledge and experiment with the input to get the
+NUMA topology they want, or as closer as they want. The important thing is to keep
+expectations up to par with what we are capable of provide at this moment: an
+approximation.
-- 
2.26.2


