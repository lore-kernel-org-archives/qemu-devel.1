Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9205DC48BE1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 21:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEBD206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 21:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEBD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he4jx-0001O3-GF
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 17:37:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1he4fn-0007xu-Ub
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 17:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1he4fm-0007Qn-HP
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 17:32:47 -0400
Resent-Date: Thu, 20 Jun 2019 17:32:47 -0400
Resent-Message-Id: <E1he4fm-0007Qn-HP@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1he4fk-0007Q9-K3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 17:32:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561066272; cv=none; d=zoho.com; s=zohoarc; 
 b=BxYcrQX1vsK7vbtNPs4U4OWTDvGFLBe9kCC4EG9EnA8Zix3d0BnUjzC8wN5Ih7tC75ksSDHqVrttJKFOBbLarMTNvXgl5BsSyZpcnjDkvn2OQ268bh2wtFqwIExF76DKYtNe7J1IaV3rXu46GcBnDXvfac2lDirw8e15TtY4Tc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561066272;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=pVe138RqlDScDYwm0S8KKLKRuk3gNqgBu18GLFaI19k=; 
 b=Usx/DHp4JyYKoroUiw+5fzS0LtM9wM6SUTM4pxL+h84uQmmFj/7bFVFI9fOA8ZLZpIT6l5fFlPU/p2VuO5ukFS/+ikOnRFjiG79qph/t3O6rHRt2UyVP/hr6VpK0ZYf0PSRDUA2tjiy8hiFC1jBi0j23wkyZ1kotVnUjQuGsVwk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561066270226340.61188514923026;
 Thu, 20 Jun 2019 14:31:10 -0700 (PDT)
In-Reply-To: <20190620203616.22715-1-ehabkost@redhat.com>
Message-ID: <156106626908.29212.2766222596090316863@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Thu, 20 Jun 2019 14:31:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/2] i386: Introduce X86CPUCacheCPUID struct
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, babu.moger@amd.com,
 imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyMDIwMzYxNi4yMjcx
NS0xLWVoYWJrb3N0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBh
c2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVp
ciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJv
YmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFr
ZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4ODZfNjQtc29m
dG1tdS90YXJnZXQvaTM4Ni9zdm1faGVscGVyLm8KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L3Rh
cmdldC9pMzg2L21hY2hpbmUubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvdGFyZ2V0L2kzODYv
YXJjaF9tZW1vcnlfbWFwcGluZy5vCi90bXAvcWVtdS10ZXN0L3NyYy90YXJnZXQvaTM4Ni9jcHUu
YzoxNDg0OjE1OiBlcnJvcjogaW5pdGlhbGl6ZXIgZWxlbWVudCBpcyBub3QgYSBjb21waWxlLXRp
bWUgY29uc3RhbnQKICAgIC5jcHVpZDIgPSBlcHljX2NhY2hlX2luZm8sCiAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+CjEgZXJyb3IgZ2VuZXJhdGVkLgoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA2MjAyMDM2MTYuMjI3MTUtMS1l
aGFia29zdEByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


