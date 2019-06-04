Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B27DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E3E20717
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E3E20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYZrx-0000gi-4e
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:38:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYZr3-0000IO-Q6
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYZr1-0000ha-5X
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:37:41 -0400
Resent-Date: Wed, 05 Jun 2019 13:37:40 -0400
Resent-Message-Id: <E1hYZr1-0000ha-5X@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hYZr0-0000b1-3x
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:37:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559670511; cv=none; d=zoho.com; s=zohoarc; 
	b=eYohwTz8QRClS4VOt4hkjTp0LFGwKLLCr8vNqb6QDtHUPczYtLCDebYWT890POPY78MQKgl8Q1cMDuQUIj3KuXI3mtGMrHLrv1plKBzZOTd3bLJNmvwoVIVsCXBiZ7zUtKrXbKsqvoz4TVOdcI56OYQC8sNm0FFpYjnHNc/AgXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559670511;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=FN768EYvq+LaacDGAHiEJGxPV3tmthpjoFnaodlkK1s=; 
	b=BGfWAk1UwfucOPAnRW6bW1PJ4yYmA+qkeDMPnRdDBQoLeS8ewQgcg0RjBQhnYFpyV+WEloDmhcmAyjTP+BVp6DucubpyIWG7a+G41mZkSjjJSQMp/3FKqVeTcPxjUieMSEVm0JqhAr6Xtwn57svU9zCBKPpCG3jzHF3mpZQxrJ0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559670509815498.45104372456433;
	Tue, 4 Jun 2019 10:48:29 -0700 (PDT)
In-Reply-To: <20190604161514.262241-1-vsementsov@virtuozzo.com>
Message-ID: <155967050840.32260.4549003262973982966@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Tue, 4 Jun 2019 10:48:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
	stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYwNDE2MTUxNC4yNjIy
NDEtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFu
ZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBj
YW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VU
X0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KCiAgQ0MgICAgICBhY2NlbC90Y2cvdHJhY2UubwogIENDICAgICAgY3J5cHRvL3RyYWNlLm8K
ICBDQyAgICAgIGF1dGh6L3RyYWNlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvaW92LmM6NDI4
Ojk6IGVycm9yOiB2YXJpYWJsZSAnbWlkX25pb3YnIGlzIHVzZWQgdW5pbml0aWFsaXplZCB3aGVu
ZXZlciAnaWYnIGNvbmRpdGlvbiBpcyBmYWxzZSBbLVdlcnJvciwtV3NvbWV0aW1lcy11bmluaXRp
YWxpemVkXQogICAgaWYgKG1pZF9sZW4pIHsKICAgICAgICBefn5+fn5+Ci90bXAvcWVtdS10ZXN0
L3NyYy91dGlsL2lvdi5jOjQzMzozMTogbm90ZTogdW5pbml0aWFsaXplZCB1c2Ugb2NjdXJzIGhl
cmUKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMTkwNjA0MTYxNTE0LjI2MjI0MS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5n
LmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


