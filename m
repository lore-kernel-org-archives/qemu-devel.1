Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E6C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E192171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E192171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFaY-0000nb-Vf
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAFL6-000655-Ql
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAFL5-000648-6N
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:24 -0400
Resent-Date: Tue, 17 Sep 2019 11:24:24 -0400
Resent-Message-Id: <E1iAFL5-000648-6N@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAFL4-00063u-VK
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568733840; cv=none; d=zoho.com; s=zohoarc; 
 b=V+oiEsIR350w60uzdmMetXqEQe4l6q7lLQLzBylvxy45x2yy5ptGwcM2rSN67FrgXSvSqqp1H632Z+KUGhpu4GZ7zHtnRyT8mVgxCK9SerwA5g7afBd987dw6deH+kMniJbMozSSlKkphXx4/NnY5AHIfWVPNa4aWn8EH7MOKrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568733840;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=3lzdjf9soqmXLZXNTxqX6agaKnLUpK+uHx1ERicdGa4=; 
 b=QMYbK+VtFVCheC1HRXs1f9qghL2k6gqBaBC4MOLw7V1YDOrX0lEFL5m94iPjdpB+FrrSCj0JtIwZoOfeTd6uIXzMCL5vKYmXdoC/IpFq4H0QU7LrMivIsLUd2GhvNPYDXAMpNTYje1kOtaH4YchlxW79j9zpDTTkxjQ1ykCZiT0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568733831763296.5174668560245;
 Tue, 17 Sep 2019 08:23:51 -0700 (PDT)
In-Reply-To: <20190917130708.10281-1-imammedo@redhat.com>
Message-ID: <156873382970.17151.13691154631311827620@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Tue, 17 Sep 2019 08:23:51 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [edk2-devel] [PATCH 0/2] q35: mch: allow to lock
 down 128K RAM at default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, jiewen.yao@intel.com,
 jun.nakajima@intel.com, michael.d.kinney@intel.com, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, rfc@edk2.groups.io, lersek@redhat.com,
 joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNzEzMDcwOC4xMDI4
MS0xLWltYW1tZWRvQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFr
ZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi4vdGVzdHMvZG9ja2VyL2RvY2tl
ci5weSAtLWVuZ2luZSBhdXRvIGJ1aWxkIHFlbXU6ZmVkb3JhIHRlc3RzL2RvY2tlci9kb2NrZXJm
aWxlcy9mZWRvcmEuZG9ja2VyICAgLS1hZGQtY3VycmVudC11c2VyICAKSW1hZ2UgaXMgdXAgdG8g
ZGF0ZS4KICBMRCAgICAgIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYS5tbwpjYzogZmF0YWwgZXJy
b3I6IG5vIGlucHV0IGZpbGVzCmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCm1ha2U6ICoqKiBbZG9j
a2VyLXRlc3QtZGVidWdAZmVkb3JhLm1vXSBFcnJvciA0CgoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTcxMzA3MDguMTAyODEtMS1p
bWFtbWVkb0ByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


