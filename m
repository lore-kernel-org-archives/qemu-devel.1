Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE622C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 10:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEFD20727
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 10:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEFD20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZuXb-0007If-Rh
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 06:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZuX5-0006s1-7f
 for qemu-devel@nongnu.org; Sat, 16 May 2020 06:59:07 -0400
Resent-Date: Sat, 16 May 2020 06:59:07 -0400
Resent-Message-Id: <E1jZuX5-0006s1-7f@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZuX3-00010i-JD
 for qemu-devel@nongnu.org; Sat, 16 May 2020 06:59:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589626738; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gEhhSnoINIe0UPXgwTHeExovoHco18d9uZPmbh61LEUvSAiuSQIckat6tyFlaJTAloHF/lqsU+SnO0ZBksHAgx6AX/TAgNiXqsrZS6M6j085l0pdh5gQnQFV6xlYUAPLty3jSjJauVk191XgWFWATk+6fZjbEE8kbwXefn7CFiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589626738;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SDQESqk0rDKzkYZq4I8VNASdxaZfb/zjE1IbsDKz2ms=; 
 b=NHGkvhfr8eKB8Orwk0BzDfU0LstODn/tyCeTlTZJDqZeYltvdPwghM01MIt25yo/2imqIyaiBrFHqHeNm+UaJxMdplc8fgZg6H5MhBR+x0d4jIPIrJxkMugTVx3q/M+jO7K+obrH27uIlAEu3RUe1k3DxUUcNrfguVU7vHp8xRs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589626736704752.2773019318399;
 Sat, 16 May 2020 03:58:56 -0700 (PDT)
Message-ID: <158962673556.15373.8073080573998703700@45ef0f9c86ae>
In-Reply-To: <20200515190153.6017-1-richard.henderson@linaro.org>
Subject: Re: [PATCH 00/10] softfloat: misc cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sat, 16 May 2020 03:58:56 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 06:59:03
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNTE5MDE1My42MDE3
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MTUxOTAxNTMuNjAxNy0xLXJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIIDAwLzEwXSBzb2Z0Zmxv
YXQ6IG1pc2MgY2xlYW51cHMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmQ2YzE1NzIgc29mdGZsb2F0OiBS
ZXR1cm4gYm9vbCBmcm9tIGFsbCBjbGFzc2lmaWNhdGlvbiBwcmVkaWNhdGVzCmQ1MjE5ZTAgc29m
dGZsb2F0OiBJbmxpbmUgZmxvYXR4ODAgY29tcGFyZSBzcGVjaWFsaXphdGlvbnMKMTc0YzExNCBz
b2Z0ZmxvYXQ6IElubGluZSBmbG9hdDEyOCBjb21wYXJlIHNwZWNpYWxpemF0aW9ucwo1MzU5ZmNm
IHNvZnRmbG9hdDogSW5saW5lIGZsb2F0NjQgY29tcGFyZSBzcGVjaWFsaXphdGlvbnMKZGZiZDgy
YyBzb2Z0ZmxvYXQ6IElubGluZSBmbG9hdDMyIGNvbXBhcmUgc3BlY2lhbGl6YXRpb25zCjQ4MDBl
Mjcgc29mdGZsb2F0OiBOYW1lIGNvbXBhcmUgcmVsYXRpb24gZW51bQo3ZmEzMjk3IHNvZnRmbG9h
dDogTmFtZSByb3VuZGluZyBtb2RlIGVudW0KN2NkMjY0OSBzb2Z0ZmxvYXQ6IENoYW5nZSB0aW5p
bmVzc19iZWZvcmVfcm91bmRpbmcgdG8gYm9vbAplN2M1NWRkIHNvZnRmbG9hdDogUmVwbGFjZSBm
bGFnIHdpdGggYm9vbAphNjExYzZkIHNvZnRmbG9hdDogVXNlIHBvc3QgdGVzdCBmb3IgZmxvYXRO
X211bAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMCBDaGVja2luZyBjb21taXQgYTYxMWM2ZDJh
MDU3IChzb2Z0ZmxvYXQ6IFVzZSBwb3N0IHRlc3QgZm9yIGZsb2F0Tl9tdWwpCjIvMTAgQ2hlY2tp
bmcgY29tbWl0IGU3YzU1ZGQ3ZTBkNSAoc29mdGZsb2F0OiBSZXBsYWNlIGZsYWcgd2l0aCBib29s
KQozLzEwIENoZWNraW5nIGNvbW1pdCA3Y2QyNjQ5ZjBjZTAgKHNvZnRmbG9hdDogQ2hhbmdlIHRp
bmluZXNzX2JlZm9yZV9yb3VuZGluZyB0byBib29sKQpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBi
ZWZvcmUgdGhhdCBjbG9zZSBwYXJlbnRoZXNpcyAnKScKIzY3OiBGSUxFOiBmcHUvc29mdGZsb2F0
LmM6Mzg3NzoKKyAgICAgICAgICAgICAgICAgIHx8ICh6RXhwIDwgMCApCgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDE0MyBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzEwIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo0LzEwIENoZWNraW5nIGNvbW1pdCA3ZmEzMjk3ZTBjZmUgKHNvZnRm
bG9hdDogTmFtZSByb3VuZGluZyBtb2RlIGVudW0pCjUvMTAgQ2hlY2tpbmcgY29tbWl0IDQ4MDBl
Mjc1M2FkOSAoc29mdGZsb2F0OiBOYW1lIGNvbXBhcmUgcmVsYXRpb24gZW51bSkKNi8xMCBDaGVj
a2luZyBjb21taXQgZGZiZDgyY2Y0Yjc1IChzb2Z0ZmxvYXQ6IElubGluZSBmbG9hdDMyIGNvbXBh
cmUgc3BlY2lhbGl6YXRpb25zKQo3LzEwIENoZWNraW5nIGNvbW1pdCA1MzU5ZmNmZTZhNDggKHNv
ZnRmbG9hdDogSW5saW5lIGZsb2F0NjQgY29tcGFyZSBzcGVjaWFsaXphdGlvbnMpCjgvMTAgQ2hl
Y2tpbmcgY29tbWl0IDE3NGMxMTQzY2ZkMSAoc29mdGZsb2F0OiBJbmxpbmUgZmxvYXQxMjggY29t
cGFyZSBzcGVjaWFsaXphdGlvbnMpCjkvMTAgQ2hlY2tpbmcgY29tbWl0IGQ1MjE5ZTA4ZmU2OSAo
c29mdGZsb2F0OiBJbmxpbmUgZmxvYXR4ODAgY29tcGFyZSBzcGVjaWFsaXphdGlvbnMpCjEwLzEw
IENoZWNraW5nIGNvbW1pdCBkNmMxNTcyYzc5MWMgKHNvZnRmbG9hdDogUmV0dXJuIGJvb2wgZnJv
bSBhbGwgY2xhc3NpZmljYXRpb24gcHJlZGljYXRlcykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MTUxOTAxNTMuNjAxNy0xLXJpY2hhcmQu
aGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t

