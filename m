Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77FC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F73B21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 07:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F73B21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkkrV-00053t-Gc
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 03:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hkkqe-0004aJ-Dn
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hkkqd-0006KX-DH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:47:36 -0400
Resent-Date: Tue, 09 Jul 2019 03:47:36 -0400
Resent-Message-Id: <E1hkkqd-0006KX-DH@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hkkqd-0006Jd-5S
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 03:47:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562658378; cv=none; d=zoho.com; s=zohoarc; 
 b=BWf6BHuHIo+reO3wZmT1vHgeTaBDee0EknghsPUATtHj+vC4eBuRQmXE3Etkbb62EYmkbWJ3JhcML/TWvXCViy7p7I5vEnWjku3eyXMZmOj6AaAW8f10pCRKUZm7deG7WjJM2415apVczK9jQzqYOX9PHjJ0xJGsWMQnXfG0zDI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562658378;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=fPWusUpxLdBhB1NtCVvk2CsPnOjDljp2tuWm0okOFfc=; 
 b=h2BwyqqCkyRIC+FYIpCP4RtwWi4amL/jgki7/EwVKHyS3x9SzPHgRP2nAE9nvmohOJOIjFbNtsBoeGSdOlJO/2yy+InuzO+Nlj9A35isaDeyhedMqlYkKJI33boLV/DTAn9LOyPmiPP6FpsoLnziOyGEI0B6kT13hL9IoLF3MyY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562658378198924.0888617927673;
 Tue, 9 Jul 2019 00:46:18 -0700 (PDT)
Message-ID: <156265837660.29610.11551024573363799482@c4a48874b076>
In-Reply-To: <20190709071520.8745-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Tue, 9 Jul 2019 00:46:18 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH RESEND v6 00/14] Build ACPI Heterogeneous
 Memory Attribute Table (HMAT)
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, tao3.xu@intel.com,
 fan.du@intel.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwOTA3MTUyMC44NzQ1
LTEtdGFvMy54dUBpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBk
b2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9hdWRpby9hYzk3
Lm8KICBDQyAgICAgIGh3L2F1ZGlvL2Ztb3BsLm8KICBDQyAgICAgIGh3L2F1ZGlvL2FkbGliLm8K
L3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvaG1hdC5jOjI2MToyMzogZXJyb3I6IHRha2luZyBh
ZGRyZXNzIG9mIHBhY2tlZCBtZW1iZXIgJ29mZnNldCcgb2YgY2xhc3Mgb3Igc3RydWN0dXJlICdI
bWF0SG1hbUluJyBtYXkgcmVzdWx0IGluIGFuIHVuYWxpZ25lZCBwb2ludGVyIHZhbHVlIFstV2Vy
cm9yLC1XYWRkcmVzcy1vZi1wYWNrZWQtbWVtYmVyXQogICAgICAgIGxlMzJfdG9fY3B1cygmaW4t
Pm9mZnNldCk7CiAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+CjEgZXJyb3IgZ2VuZXJh
dGVkLgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTA3MDkwNzE1MjAuODc0NS0xLXRhbzMueHVAaW50ZWwuY29tL3Rlc3RpbmcuYXNhbi8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


