Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B5C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 22:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B5D2089C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 22:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B5D2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hobSD-000588-SW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 18:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hobS2-0004gn-ST
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hobRz-000148-3s
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:34:05 -0400
Resent-Date: Fri, 19 Jul 2019 18:34:04 -0400
Resent-Message-Id: <E1hobRz-000148-3s@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hobRw-0000vG-9w; Fri, 19 Jul 2019 18:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563575606; cv=none; d=zoho.com; s=zohoarc; 
 b=U0qDgJLf6nA4ajDu68absSgkXmiJ5H2MS2HoiCgixfKlx0ALSw38Zu97L9WUaQq/GKW3xk2UOVd3WqYw7e4g9QFr0YrBqXPt7kOYY0jQTIczY+6oBb7LNVBKhHFycMIXVOni/Q08VJ7pwTvCm5Nxs2/2eCWbodHFbvF84Pl9w6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563575606;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=6byU/KpHKvGMvBM0yQXyCrXPUb1eTkD4goy5f+PGoC0=; 
 b=HKOxNypCQiu6xSqHsJn6MfJiokd5aBzeH08kKMH5TC7bVyA45tsR/xAJLaXiRwOp6Kg83wFv3j9r9RUUxyEVbRdLjSugjq2eXpxydt/YX1qfYi3N3ERpxehAs4o/TZaB9ix/A/QxehTJ7BVfRfiut4QNi+rHhDFzo09TuZ04P5U=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563575604033164.72184125182343;
 Fri, 19 Jul 2019 15:33:24 -0700 (PDT)
Message-ID: <156357560202.15703.7605955257042860106@c4a48874b076>
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mehta.aaru20@gmail.com
Date: Fri, 19 Jul 2019 15:33:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v6 00/14] Add support for io_uring
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
Cc: fam@euphon.net, kwolf@redhat.com, stefan@redhat.com, qemu-block@nongnu.org,
 slp@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 saket.sinha89@gmail.com, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, mlevitsk@redhat.com, jusual@mail.ru,
 mehta.aaru20@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxOTEzMzUzMC4yODY4
OC0xLW1laHRhLmFhcnUyMEBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0
aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4g
cHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUg
bWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9hcm0v
dHJhY2UubwogIENDICAgICAgaHcvYXVkaW8vdHJhY2UubwpJbiBmaWxlIGluY2x1ZGVkIGZyb20g
YmxvY2svdHJhY2UuYzo0OgovdG1wL3FlbXUtdGVzdC9idWlsZC9ibG9jay90cmFjZS5oOjE3MDQ6
OTY6IGVycm9yOiBleHBlY3RlZCAnKScKICAgICAgICBxZW11X2xvZygiJWRAJXp1LiUwNnp1Omx1
cmluZ19yZXN1Ym1pdF9zaG9ydF9yZWFkICIgIkx1cmluZ1N0YXRlICVwIGx1cmluZ2NiICVwIG5y
ZWFkICJcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3Fl
bXUtdGVzdC9idWlsZC9ibG9jay90cmFjZS5oOjE3MDQ6MTc6IG5vdGU6IHRvIG1hdGNoIHRoaXMg
JygnCiAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTpsdXJpbmdfcmVzdWJtaXRfc2hvcnRf
cmVhZCAiICJMdXJpbmdTdGF0ZSAlcCBsdXJpbmdjYiAlcCBucmVhZCAiXG4iLAogICAgICAgICAg
ICAgICAgXgovdG1wL3FlbXUtdGVzdC9idWlsZC9ibG9jay90cmFjZS5oOjE3MDQ6OTg6IGVycm9y
OiBtaXNzaW5nIHRlcm1pbmF0aW5nICciJyBjaGFyYWN0ZXIgWy1XZXJyb3IsLVdpbnZhbGlkLXBw
LXRva2VuXQogICAgICAgIHFlbXVfbG9nKCIlZEAlenUuJTA2enU6bHVyaW5nX3Jlc3VibWl0X3No
b3J0X3JlYWQgIiAiTHVyaW5nU3RhdGUgJXAgbHVyaW5nY2IgJXAgbnJlYWQgIlxuIiwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KICBDQyAgICAgIGh3L2Jsb2NrL3Ry
YWNlLm8KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMTkwNzE5MTMzNTMwLjI4Njg4LTEtbWVodGEuYWFydTIwQGdtYWlsLmNvbS90ZXN0aW5n
LmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


