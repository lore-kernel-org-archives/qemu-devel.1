Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20804C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58F120679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 05:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58F120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgLfW-00085p-6G
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 01:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgLez-0007Yc-Eu
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:09:53 -0400
Resent-Date: Wed, 03 Jun 2020 01:09:53 -0400
Resent-Message-Id: <E1jgLez-0007Yc-Eu@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgLex-0007fF-Ms
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 01:09:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591160976; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hwfC74Jlzm6Mp2uUELBYnYA2xm2yk0QS03VrfJ592fO25c4tbfzP8AbXCuL9Yt9+Wrznn48fdH3nLn/evIIMcMipBiz6wCn45cWtVazEZ14Y6eR5ey8wpwbX/5rkJTgSc8Sag+dp5zLVP3AMvwz30i3ic1hHh3jrE3Ul77qG8YA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591160976;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=N5d1FUk/esIO+MpiUf46wX87Jb2pR+LRFyoi60WcuTc=; 
 b=NpgQ+SqhySj9RUskne4hu6GY0aH8DXqHPoO3JoYxlwjUhF9IDePiCqPkMV9Plwt1xNh9wtfczpEZh5+TVqINdNWscIH6q/YB560+ZqaY+Kf9NBeZdE9OWUeZacoWJnpbu+VoHFUxiKUtaFtCraBQ10jBdDY0hasobOcilo91pLY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591160974003209.26388636515514;
 Tue, 2 Jun 2020 22:09:34 -0700 (PDT)
Message-ID: <159116097292.18153.16073681352611258549@45ef0f9c86ae>
In-Reply-To: <20200603044701.10748-1-agrecascino123@gmail.com>
Subject: Re: [PATCH] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: agrecascino123@gmail.com
Date: Tue, 2 Jun 2020 22:09:34 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:09:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: chocola@animebitch.es, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMzA0NDcwMS4xMDc0
OC0xLWFncmVjYXNjaW5vMTIzQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDMwNDQ3MDEuMTA3NDgtMS1hZ3Jl
Y2FzY2lubzEyM0BnbWFpbC5jb20KU3ViamVjdDogW1BBVENIXSB0Y2c6IFNhbml0aXplIHNoaWZ0
IGNvbnN0YW50cyBvbiBwcGM2NGxlIHNvIHRoYXQgc2hpZnQgb3BlcmF0aW9ucyB3aXRoIGxhcmdl
IGNvbnN0YW50cyBkb24ndCBnZW5lcmF0ZSBpbnZhbGlkIGluc3RydWN0aW9ucy4KVHlwZTogc2Vy
aWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2Ug
YmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCmQwOTdiNTMgdGNnOiBTYW5pdGl6ZSBzaGlmdCBjb25zdGFudHMgb24gcHBjNjRs
ZSBzbyB0aGF0IHNoaWZ0IG9wZXJhdGlvbnMgd2l0aCBsYXJnZSBjb25zdGFudHMgZG9uJ3QgZ2Vu
ZXJhdGUgaW52YWxpZCBpbnN0cnVjdGlvbnMuCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjog
TWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDI1IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBkMDk3YjUzMWRmNjcgKHRjZzogU2FuaXRpemUg
c2hpZnQgY29uc3RhbnRzIG9uIHBwYzY0bGUgc28gdGhhdCBzaGlmdCBvcGVyYXRpb25zIHdpdGgg
bGFyZ2UgY29uc3RhbnRzIGRvbid0IGdlbmVyYXRlIGludmFsaWQgaW5zdHJ1Y3Rpb25zLikgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MDMwNDQ3MDEuMTA3NDgtMS1hZ3JlY2FzY2lubzEyM0Bn
bWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

