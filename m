Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2677FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22C1205F4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22C1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htTiC-0000Hy-53
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1htThb-0008FR-Mg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1htTha-0002e4-Mn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:18:19 -0400
Resent-Date: Fri, 02 Aug 2019 05:18:19 -0400
Resent-Message-Id: <E1htTha-0002e4-Mn@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1htTha-0002dI-Ey
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564737486; cv=none; d=zoho.com; s=zohoarc; 
 b=CAgAODmzMF8SdDCnLnbidyFj6LszfKjB70ShK/J3uoBAv0lvyshzcr0reIRGkyFZVoXWeqJMioBoRHZQCr9Gahb2RLiFQak72srMarWrE3DLQuGJLEultLiuDz33GMgfIDx1OCvz+CrAkGMi55GL9sFihgB3/9YCpjSUNw8tHXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564737486;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=J7svWgw4ut89qwrH9/hYgoQdWE4XEC0xIyZTZRLuBtw=; 
 b=ADeC2kMXK/3fIJcIKT0I9NIg7ODESTiZyVJURmi35tWFgbnf3zKOfKfeagmJ7kYt1jEtU1N5tLTtYUi83/zh2oxPH+qFcrlXMqpZEx2xTPSDgndJkDL6gvHtEjnCHn1SPGu/3k6tJz3D5XRGAMOBtuGOz/R6hvgdo9JlBuYbMw8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1564737484816341.4516498485194;
 Fri, 2 Aug 2019 02:18:04 -0700 (PDT)
Message-ID: <156473748376.29356.13491393800448965202@c4a48874b076>
In-Reply-To: <1564736786-26495-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: renyime@gmail.com
Date: Fri, 2 Aug 2019 02:18:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v2] migration: always initial ram_counters
 for a new migration
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
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY0NzM2Nzg2LTI2NDk1LTEt
Z2l0LXNlbmQtZW1haWwtaXZhbnJlbkB0ZW5jZW50LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBm
YWlsZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14ODZfNjQt
c29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBBUyAgICAg
IHBjLWJpb3Mvb3B0aW9ucm9tL211bHRpYm9vdC5vCiAgQ0MgICAgICBxZ2EvY29tbWFuZHMtcG9z
aXgubwogIEFTICAgICAgcGMtYmlvcy9vcHRpb25yb20vbGludXhib290Lm8KL3RtcC9xZW11LXRl
c3Qvc3JjL21pZ3JhdGlvbi9taWdyYXRpb24uYzozMDMzOjg6IGVycm9yOiB0eXBlIHNwZWNpZmll
ciBtaXNzaW5nLCBkZWZhdWx0cyB0byAnaW50JyBbLVdlcnJvciwtV2ltcGxpY2l0LWludF0Kc3Rh
dGljIHVwZGF0ZV9pdGVyYXRpb25faW5pdGlhbF9zdGF0dXMoTWlncmF0aW9uU3RhdGUgKnMpCn5+
fn5+fiBeCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vbWlncmF0aW9uLmM6MzA0MjoxOiBl
cnJvcjogY29udHJvbCByZWFjaGVzIGVuZCBvZiBub24tdm9pZCBmdW5jdGlvbiBbLVdlcnJvciwt
V3JldHVybi10eXBlXQp9Cl4KMiBlcnJvcnMgZ2VuZXJhdGVkLgoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2NDczNjc4Ni0yNjQ5NS0xLWdp
dC1zZW5kLWVtYWlsLWl2YW5yZW5AdGVuY2VudC5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


