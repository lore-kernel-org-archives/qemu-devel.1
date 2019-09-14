Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC79C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 00:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6BF2089F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 00:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6BF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8vwq-0000ET-Hg
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 20:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i8vvz-00082A-NR
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 20:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i8vvy-000659-6c
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 20:29:03 -0400
Resent-Date: Fri, 13 Sep 2019 20:29:03 -0400
Resent-Message-Id: <E1i8vvy-000659-6c@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i8vvy-00064D-1p
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 20:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568420910; cv=none; d=zoho.com; s=zohoarc; 
 b=fP9u639jUUXbWKxbPxum+ItStbXhhaWfY7fxSlDyjXABrmGY5RTO0eSeLGpi/vQ59uqXdQ7d0pWk3DGzrqNjZ+UehEwDs9xKhIX5UYokgDSft11LLlrfYZQmbqmDYzK7TSjzgxm4ZBfNADpGpWQGG4R/Lyi77wFlNwn4CYEzGJQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568420910;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=NztylV4/HfyQo9XRuRqYrfHgXnd+aG8lGHG/Q2A4VUk=; 
 b=gL3mAH/pLIix02kNvweqYfg5Oy0zKJZk8rRffjCsN8OHSzQohc9PP92L/PfcBI0LY0zTROU0vdAuF0BgLotpwCVj2kRJKu6YQVQu31bnzAO1SGS0lvlodTNs0+jKR1uR/Ma0SOqjQGgcUeUN3tysubqI47/GGIlkpeD3PiYH/ik=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568420909480147.17839072762172;
 Fri, 13 Sep 2019 17:28:29 -0700 (PDT)
In-Reply-To: <20190913172741.5662-1-mlevitsk@redhat.com>
Message-ID: <156842090797.31080.6142961078768911120@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Fri, 13 Sep 2019 17:28:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6 0/3] Fix qcow2+luks corruption
 introduced by commit 8ac0f15f335
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
Cc: kwolf@redhat.com, mlevitsk@redhat.com, vsementsov@virtuozzo.com,
 berrange@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMzE3Mjc0MS41NjYy
LTEtbWxldml0c2tAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpsaWJ1ZGV2ICAgICAgICAgICBu
bwpkZWZhdWx0IGRldmljZXMgICB5ZXMKCndhcm5pbmc6IFB5dGhvbiAyIHN1cHBvcnQgaXMgZGVw
cmVjYXRlZAp3YXJuaW5nOiBQeXRob24gMyB3aWxsIGJlIHJlcXVpcmVkIGZvciBidWlsZGluZyBm
dXR1cmUgdmVyc2lvbnMgb2YgUUVNVQpjcm9zcyBjb250YWluZXJzICBubwoKTk9URTogZ3Vlc3Qg
Y3Jvc3MtY29tcGlsZXJzIGVuYWJsZWQ6IGNjCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxMzE3Mjc0MS41NjYyLTEtbWxldml0c2tA
cmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t


