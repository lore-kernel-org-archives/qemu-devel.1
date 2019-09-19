Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5899BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AABC207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 20:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AABC207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB3B3-00019x-C3
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 16:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iB3AJ-0000cu-NT
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iB3AI-0004RQ-6n
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 16:36:35 -0400
Resent-Date: Thu, 19 Sep 2019 16:36:35 -0400
Resent-Message-Id: <E1iB3AI-0004RQ-6n@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iB3AH-0004Px-Sq; Thu, 19 Sep 2019 16:36:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568925364; cv=none; d=zoho.com; s=zohoarc; 
 b=gt9DBHuFrT7KDdTTp+7NP3Q2hYX4cSbl8LBcmHtCJRwFv2HmtXdQIe81GUWfT75Cudzaky+WyVb+EfLPwzmic06Qq0PTVzYbxLVjrH7jOScgatEDLHuYQ/yDz1WMBl70H+TpwRVH7hhlH5yv/bb0RlpC5knioqW6adqF+/epwTo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568925364;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=R72mvsuUMNUeF2BRaD/Sg20ZXQtPF7ABPpl4agGrgqo=; 
 b=RcJWPBVJPcE5l8poYEftTyQkgSmmXIaR8FAlA8HI0eXIO5ccGd8aOAlZNJo8WzPrrgsHartMuvSgiX1ov16utKffIC95loCIMSeqXD2HBqCHuKiw4PWAutqzopyZR8wFj7RSM5l4Bft+76vW4z5u5lk8jy9uERnm2GVPAY3QOF8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156892536309234.18677297019735;
 Thu, 19 Sep 2019 13:36:03 -0700 (PDT)
In-Reply-To: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v11 00/11] ARM virt: ACPI memory
 hotplug support
Message-ID: <156892536124.2125.1611674387800637332@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shameerali.kolothum.thodi@huawei.com
Date: Thu, 19 Sep 2019 13:36:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
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
X2ZpbGUpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpDb3VsZCBub3QgYWNjZXNzIEtWTSBrZXJu
ZWwgbW9kdWxlOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxODEzMDYzMy40ODcyLTEt
c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNr
QGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


