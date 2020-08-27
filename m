Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B702F207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKe1hnu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B702F207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIBh-0006k6-UD
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8q-000111-7j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26029
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8o-0006Jn-9L
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MryNRxQ6ULiJofurlt8UiScI0QAkE96jDnD1eW9uNs=;
 b=MKe1hnu1v4r/pvnN8D50hGg0WEKRyy7pT0R+gcpZ+YW+aXHgngvTVdcKfb5P2CqAJTn0g+
 Ev+98LzZabqNW2x7KdHibFOpLcj5QVPvSE87TtfrQOaIdwjytiXA/ELrXw6XoS+Djhe3WB
 oqtZzBVbhWm0ND9mTJixcJjCR1UAPRM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-39iPnWfVOf2GwUK1W_2Vtg-1; Thu, 27 Aug 2020 09:40:32 -0400
X-MC-Unique: 39iPnWfVOf2GwUK1W_2Vtg-1
Received: by mail-wm1-f72.google.com with SMTP id p184so2145852wmp.7
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9MryNRxQ6ULiJofurlt8UiScI0QAkE96jDnD1eW9uNs=;
 b=XwpL10FP1lvXChYUs3Y3IN4VrDO9a6nyRqlGrN1+wMoJiJOi6/KsxjhOB1UNgJkdC7
 a9h0jIciX4FGik6WHfa4swnAhq8tXDHOn/iZRbb5orn2ClbZubU94+1Xzy/PgokSrX4L
 pnj5DHQzYp8vOQaRNmZgeKPQ1mVz7yFlLvTaVRrE8SbY7cAIxdBcQax4erZOklPph17O
 kCpl2ulfALt70XKR5BcOXwWAMxaycypDtEMEeLRuLB3lsYrN+h0ohB0M3PE765a8U9D9
 bCvfxlY1tvBAzilUyPrmnW/HtZkzAf5KJBwlsdTbB1VAEtiVfL1Z2CsyJu72PLbTzYP2
 UWEA==
X-Gm-Message-State: AOAM5323+I5Dd0MgaVeU0neycaC83Ptnu1CNL90ZFgGGNdbA61BZ5stn
 aR1pV35F/TyMUSocwWdOeKvKVV9KvNCjtjIkCll506ey41vEjtGHxtQTzYt7An/pDIjJsR9x3K+
 0FoROCo+oQRcB0eo=
X-Received: by 2002:adf:f812:: with SMTP id s18mr21035837wrp.96.1598535630670; 
 Thu, 27 Aug 2020 06:40:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqResxLo3RawtVvCSWJBwxtNx2KGjGYVdM/JalwNYFRdf0mTV2aa53HteXwYgm2v/CXOYO9Q==
X-Received: by 2002:adf:f812:: with SMTP id s18mr21035825wrp.96.1598535630462; 
 Thu, 27 Aug 2020 06:40:30 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id d10sm6344774wrg.3.2020.08.27.06.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:29 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] disassemble-aml: -o actually works
Message-ID: <20200827133954.2118749-5-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turns out that option was borken due to weird iasl
command line handling. Fix it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/disassemle-aml.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
index 1d8a4d0301..253b7620a0 100755
--- a/tests/data/acpi/disassemle-aml.sh
+++ b/tests/data/acpi/disassemle-aml.sh
@@ -42,11 +42,16 @@ do
         else
             extra=""
         fi
-        asl=${aml}.dsl
         if [[ "${outdir}" ]];
         then
-            asl="${outdir}"/${machine}/${asl}
+            # iasl strips an extension from prefix if there.
+            # since we have some files with . in the name, the
+            # last component gets interpreted as an extension:
+            # add another extension to work around that.
+            prefix="-p ${outdir}/${aml}.dsl"
+        else
+            prefix=""
         fi
-        iasl -d -p ${asl} ${extra} ${aml}
+        iasl ${extra} ${prefix} -d ${aml}
     done
 done
-- 
MST


