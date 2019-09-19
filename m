Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15346C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 04:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF2621907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 04:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF2621907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAoTk-0003ny-RB
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 00:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAoSb-00037h-LH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 00:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAoSY-0007M6-Pp
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 00:54:29 -0400
Resent-Date: Thu, 19 Sep 2019 00:54:29 -0400
Resent-Message-Id: <E1iAoSY-0007M6-Pp@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAoSY-0007Gt-5s; Thu, 19 Sep 2019 00:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568868820; cv=none; d=zoho.com; s=zohoarc; 
 b=iGP6xSziePBKGCjhzGXnjsurza9PXRVNWAVVYI2LVOLPeTjl5P18c225HY7U7O7kwsvUzHWd2FAdWVKeFt3Uqbuw73EJlVzNfrdLjyk4zmciNRcnR2LyGWRUzD+4E01doN5E1C2IkGBYIatF/3RbGA+uvrWkYLEDWmPugil9i4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568868820;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=YdtUza1sOX8e9ej9RGyJQYGWtj1HqKpyz579XlI9Cuc=; 
 b=FeHbXM/0h08L5cCeAR2Ogd3HG7HlybmHNPnwIElLk0rWf9n6KavG9+B1asVBWRPw2+G31WFQNB2eDkSRttGkSYNv6XL9i5cX3o/OCpju7M6N2gaYCv+/QL+sE8r+6G+pYh91Vm/hSr/g6GRQ7Es5VYmEwBa67J5smm/d2sqOkpk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15688688196655.492372173410217;
 Wed, 18 Sep 2019 21:53:39 -0700 (PDT)
In-Reply-To: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
Message-ID: <156886881774.17151.14880568020719741460@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shameerali.kolothum.thodi@huawei.com
Date: Wed, 18 Sep 2019 21:53:39 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v11 00/11] ARM virt: ACPI memory
 hotplug support
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
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 shannon.zhaosl@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, sebastien.boeuf@intel.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxODEzMDYzMy40ODcy
LTEtc2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2Vy
aWVzIGZhaWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZp
bmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhh
dmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxs
eS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1h
Z2UtY2VudG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50
b3M3IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmxp
YnVkZXYgICAgICAgICAgIG5vCmRlZmF1bHQgZGV2aWNlcyAgIHllcwoKd2FybmluZzogUHl0aG9u
IDIgc3VwcG9ydCBpcyBkZXByZWNhdGVkCndhcm5pbmc6IFB5dGhvbiAzIHdpbGwgYmUgcmVxdWly
ZWQgZm9yIGJ1aWxkaW5nIGZ1dHVyZSB2ZXJzaW9ucyBvZiBRRU1VCmNyb3NzIGNvbnRhaW5lcnMg
IG5vCgpOT1RFOiBndWVzdCBjcm9zcy1jb21waWxlcnMgZW5hYmxlZDogY2MKLS0tCkxvb2tpbmcg
Zm9yIGV4cGVjdGVkIGZpbGUgJ3Rlc3RzL2RhdGEvYWNwaS92aXJ0L1NSQVQubnVtYW1lbScKTG9v
a2luZyBmb3IgZXhwZWN0ZWQgZmlsZSAndGVzdHMvZGF0YS9hY3BpL3ZpcnQvU1JBVCcKKioKRVJS
T1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL2Jpb3MtdGFibGVzLXRlc3QuYzozMjc6bG9hZF9l
eHBlY3RlZF9hbWw6IGFzc2VydGlvbiBmYWlsZWQ6IChleHBfc2R0LmFtbF9maWxlKQpFUlJPUiAt
IEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvYmlvcy10YWJsZXMtdGVz
dC5jOjMyNzpsb2FkX2V4cGVjdGVkX2FtbDogYXNzZXJ0aW9uIGZhaWxlZDogKGV4cF9zZHQuYW1s
X2ZpbGUpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQpUcmFjZWJhY2sg
KG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5
IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxODEzMDYzMy40ODcyLTEtc2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


