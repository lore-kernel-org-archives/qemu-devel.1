Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65114C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3296C207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3296C207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLdO-0005aU-8y
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iBLC6-0003D6-6V
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iBLC4-0005Bj-2m
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:51:37 -0400
Resent-Date: Fri, 20 Sep 2019 11:51:37 -0400
Resent-Message-Id: <E1iBLC4-0005Bj-2m@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iBLC3-0005BI-QL; Fri, 20 Sep 2019 11:51:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568994543; cv=none; d=zoho.com; s=zohoarc; 
 b=eY+DaVum+8J2w3I39Wv+zC0De/xZIen719ey7V+lw8yiPLkgNTExqmWnzGReGWt57DGBSBHC6cOYUkA0DJ+W66y2Rd1XctvWT+cuNFGmUQ3iNHA74kljSELUwffwhfUxxgOsiKqUhaxolSmxX41HubzAm1Tj0llfEFgm7YNWREg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568994543;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=tTfi92Ime6VEmjFx6bJ8LSyWC6FS7DF0UtbG/sW8nm8=; 
 b=RvmGCMBVcRn5rXArOBAxqnider8RzSnIuSLrqpr2s+pL1wEdTrIA7LwNZt5Liqa9mNiWuBCAxnj21ZwJ0fks5bjt3KPbn8BdbyPn6b885AClhCoFUYYRMOa/zJ4Hbs/0z0bNANSWQiZ5STA8Noti7YjZjWHVhFb8yXyDNidgYiE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568994541676383.26895998389296;
 Fri, 20 Sep 2019 08:49:01 -0700 (PDT)
In-Reply-To: <20190918130633.4872-1-shameerali.kolothum.thodi@huawei.com>
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v11 00/11] ARM virt: ACPI memory
 hotplug support
Message-ID: <156899453956.5071.11055733674708746891@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shameerali.kolothum.thodi@huawei.com
Date: Fri, 20 Sep 2019 08:49:01 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
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
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2
XzY0OiB0ZXN0cy92bWdlbmlkLXRlc3QKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE4MTMwNjMzLjQ4NzItMS1zaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==


