Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD5C606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052DB20665
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052DB20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkUyE-0006qN-1Z
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hkUwb-0006N5-91
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hkUwZ-0001Mn-9K
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:48:41 -0400
Resent-Date: Mon, 08 Jul 2019 10:48:40 -0400
Resent-Message-Id: <E1hkUwZ-0001Mn-9K@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hkUwR-0000dJ-O8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:48:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562597292; cv=none; d=zoho.com; s=zohoarc; 
 b=PX+rl0kQkfGzBjnoHV5MSy97v1xt9xR7v+TrBj/hIt5cS40llkkPfZEwb75dq4x8F6WkE8BoozHZ3ZXTHXszPEW4vIJXfgCgFXOjRoXynvj4nc7V94Ffqviwe/EqORfjXOx6l8U8GhpxpLTprQdQnAIffUp9pRlDh43rSIm5cYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562597292;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=W0g0yuKMIvygZKq5gWJBh1vFLMf0IWmco4UPlF9uxbI=; 
 b=MLnbHM+Wuv9TvwX4ZnTFH/pcNcsCKzzrvfCy/2VAKq266DxqVZBYQ441+BiDZG7hb5XX5Py/Om3Qtzp4QTu8o5mpecKHZfyP9+C8/0+0aAuMJZTwZQVKYTYqp51rUApt1Mi7TOBGds6Od1KRz/IzcpdEXlqJgo12pfdK0GjkVYc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562597289801258.2605545374471;
 Mon, 8 Jul 2019 07:48:09 -0700 (PDT)
Message-ID: <156259728884.25785.136203748561002824@c4a48874b076>
In-Reply-To: <20190708132237.7911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Mon, 8 Jul 2019 07:48:09 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PULL 0/4] target-arm queue
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwODEzMjIzNy43OTEx
LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDcwODEzMjIzNy43OTExLTEtcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BV
TEwgMC80XSB0YXJnZXQtYXJtIHF1ZXVlCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIHQgW3Rh
ZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDcwODEzMjIzNy43OTExLTEtcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAxOTA3MDgxMzIyMzcuNzkxMS0xLXBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCgo9PT0g
T1VUUFVUIEJFR0lOID09PQpjaGVja3BhdGNoLnBsOiBubyByZXZpc2lvbnMgcmV0dXJuZWQgZm9y
IHJldmxpc3QgJzEnCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDI1NQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTA3MDgxMzIyMzcuNzkxMS0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


