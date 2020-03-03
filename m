Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99537C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E8020838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95Ey-0004ML-Ga
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j95ED-0003On-HI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j95EC-0006xx-Gq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:56:45 -0500
Resent-Date: Tue, 03 Mar 2020 05:56:45 -0500
Resent-Message-Id: <E1j95EC-0006xx-Gq@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j95EC-0006uW-66
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:56:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583232991; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MJCA/AmGlf/Ci+loW+lQzc3yBXId1RedykRx/FXd/w5H2hGRGCHnEJCR65mQBt5hPDtnRKsZ/Hw/8MJjkrIU8TWuvARW1Z0gLen2KNk/TYMKtb3Rg6gvjsgzO3KahOwluA5winEn2By1+yyZDfKTxUP/t3qhWvq4YB7gqaLBW78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583232991;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=usaj3eJk9Llyu5xE1ZqF6q3Rfl8EoEnMMzx9z5anxCY=; 
 b=cdk7U5p4IN3TF7/8E4+oPPsKc2F8sqzRt1DhfCHZb2NxYKL3ds82PAp4XsfLyaFLZTaYqL5lrdKLw9nwkRJPtDU3/13II8qP32+2N8Ny5aZquC5Iypr7yNwUmQ8y0lSbaA2CNQZrbfQMWzgzeH14Eqdajdo5Lrruy25O4gK1T/c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583232989253410.64991838380286;
 Tue, 3 Mar 2020 02:56:29 -0800 (PST)
In-Reply-To: <20200303104724.233375-1-ppandit@redhat.com>
Subject: Re: [PATCH v3 0/2] net: tulip: add checks to avoid OOB access
Message-ID: <158323298807.8962.14122866075079206643@abdcc9e1aa82>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ppandit@redhat.com
Date: Tue, 3 Mar 2020 02:56:29 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: pjp@fedoraproject.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 pangpei.lq@antfin.com, svens@stackframe.org, ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwMzEwNDcyNC4yMzMz
NzUtMS1wcGFuZGl0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMwMzEwNDcyNC4yMzMz
NzUtMS1wcGFuZGl0QHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

