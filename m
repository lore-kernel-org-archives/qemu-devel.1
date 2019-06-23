Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18883C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 18:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C8520645
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 18:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C8520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf7AV-0006b9-4l
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 14:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hf78I-0005Yx-Gc
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 14:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hf78B-0006WJ-Jp
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 14:22:25 -0400
Resent-Date: Sun, 23 Jun 2019 14:22:24 -0400
Resent-Message-Id: <E1hf78B-0006WJ-Jp@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hf785-0006LH-4s
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 14:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561311374; cv=none; d=zoho.com; s=zohoarc; 
 b=LeCX5rWartUN7u9Zy5xWMVaZe2U/B7cENJAFlB270OyqGEzp4+te02XqPyQyMqLaRw/w3RZ/kOuw5XHvU9wW3Lvnv3r6PlVM4iadcUOW6CP1jLzOwUA/1JUt9tfEl3u4STyvqm+OR+eOQSrDSeHhlvEeFC1fXwWMZ4MVFp1x9iQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561311374;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=L5/nSCRymEDojfpOxfWgiztQyhO9MigLVABwj+tu8tk=; 
 b=ZYu+jcVg7S3IewAXKammYw3wC+SpKtFJK4MqrK71T3tJeeHp/QTnam0C0jL3u6PwXLd3X+P6ZQxaMWK8ieESNfjYMFyYEB9p5Sd/MLvH7vZ7hk9up394JrdfJi99ujmAdoGdVUZsv6s4MX+Ncj8DQjkBGKHl+21VAd2uqLOTb3k=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561311373759627.9100495419506;
 Sun, 23 Jun 2019 10:36:13 -0700 (PDT)
In-Reply-To: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <156131137251.4070.16221244619259102410@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Sun, 23 Jun 2019 10:36:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v5 00/16] tcg/ppc: Add vector opcodes
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
Cc: richard.henderson@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, amarkovic@wavecomp.com, hsp.cat7@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxMzA5NDg5LTE2MTQ2LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0ggdjUgMDAvMTZdIHRjZy9wcGM6IEFkZCB2ZWN0b3Igb3Bjb2RlcwpUeXBlOiBzZXJpZXMK
TWVzc2FnZS1pZDogMTU2MTMwOTQ4OS0xNjE0Ni0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIu
bWFya292aWNAcnQtcmsuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
RnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWdd
ICAgICAgICAgICAgICAgcGF0Y2hldy8xNTYxMzA5NDg5LTE2MTQ2LTEtZ2l0LXNlbmQtZW1haWwt
YWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20gLT4gcGF0Y2hldy8xNTYxMzA5NDg5LTE2MTQ2
LTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20KU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyMmQxMzNiN2QzIHRjZy9wcGM6IFVwZGF0ZSB2ZWN0b3Ig
c3VwcG9ydCB0byB2My4wMAo5MGJiZjUxMTYzIHRjZy9wcGM6IFVwZGF0ZSB2ZWN0b3Igc3VwcG9y
dCB0byB2Mi4wNwpiNTMzNTY4OGM4IHRjZy9wcGM6IFVwZGF0ZSB2ZWN0b3Igc3VwcG9ydCB0byB2
Mi4wNgpiNTIxOTAxNDg4IHRjZy9wcGM6IFN1cHBvcnQgdmVjdG9yIGR1cDIKODkyNGU2OGY5NyB0
Y2cvcHBjOiBTdXBwb3J0IHZlY3RvciBtdWx0aXBseQplMjkzZmZmODBiIHRjZy9wcGM6IFN1cHBv
cnQgdmVjdG9yIHNoaWZ0IGJ5IGltbWVkaWF0ZQpmNjkwMjIzNzIyIHRjZy9wcGM6IEFkZCBlbXB0
eSBmaWxlIHRjZy10YXJnZXQub3BjLmgKZTRlNjQxOWY4YyB0Y2cvcHBjOiBQcmVwYXJlIGNhc2Ug
Zm9yIHZlY3RvciBtdWx0aXBseQo3OTU3ZjhmNDFjIHRjZy9wcGM6IEFkZCBzdXBwb3J0IGZvciB2
ZWN0b3Igc2F0dXJhdGVkIGFkZC9zdWJ0cmFjdApmZTgwNTM5NmFlIHRjZy9wcGM6IEFkZCBzdXBw
b3J0IGZvciB2ZWN0b3IgYWRkL3N1YnRyYWN0CjVjYjZjZDBmYzAgdGNnL3BwYzogQWRkIHN1cHBv
cnQgZm9yIHZlY3RvciBtYXhpbXVtL21pbmltdW0KNDc0N2NlY2RiMSB0Y2cvcHBjOiBBZGQgc3Vw
cG9ydCBmb3IgbG9hZC9zdG9yZS9sb2dpYy9jb21wYXJpc29uCjQyMWJjNmQ3ZDMgdGNnL3BwYzog
SW50cm9kdWNlIG1hY3JvcyBWUlQoKSwgVlJBKCksIFZSQigpLCBWUkMoKQowMzc5NzA1ZjhkIHRj
Zy9wcGM6IEludHJvZHVjZSBtYWNybyBWWDQoKQo3ZmM0NTU0NjQ3IHRjZy9wcGM6IEludHJvZHVj
ZSBmbGFnIGhhdmVfaXNhX2FsdGl2ZWMKMjljNTVkZGQ5ZiB0Y2cvcHBjOiBJbnRyb2R1Y2UgQWx0
aXZlYyByZWdpc3RlcnMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hlY2tpbmcgY29tbWl0
IDI5YzU1ZGRkOWYyZSAodGNnL3BwYzogSW50cm9kdWNlIEFsdGl2ZWMgcmVnaXN0ZXJzKQoyLzE2
IENoZWNraW5nIGNvbW1pdCA3ZmM0NTU0NjQ3ODkgKHRjZy9wcGM6IEludHJvZHVjZSBmbGFnIGhh
dmVfaXNhX2FsdGl2ZWMpCjMvMTYgQ2hlY2tpbmcgY29tbWl0IDAzNzk3MDVmOGQzMSAodGNnL3Bw
YzogSW50cm9kdWNlIG1hY3JvIFZYNCgpKQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0
aGF0ICd8JyAoY3R4OlZ4VikKIzIxOiBGSUxFOiB0Y2cvcHBjL3RjZy10YXJnZXQuaW5jLmM6MzIz
OgorI2RlZmluZSBWWDQob3BjKSAgKE9QQ0QoNCl8KG9wYykpCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNyBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAzLzE2IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzE2IENoZWNraW5nIGNvbW1p
dCA0MjFiYzZkN2QzMDggKHRjZy9wcGM6IEludHJvZHVjZSBtYWNyb3MgVlJUKCksIFZSQSgpLCBW
UkIoKSwgVlJDKCkpCjUvMTYgQ2hlY2tpbmcgY29tbWl0IDQ3NDdjZWNkYjFiMCAodGNnL3BwYzog
QWRkIHN1cHBvcnQgZm9yIGxvYWQvc3RvcmUvbG9naWMvY29tcGFyaXNvbikKNi8xNiBDaGVja2lu
ZyBjb21taXQgNWNiNmNkMGZjMDQzICh0Y2cvcHBjOiBBZGQgc3VwcG9ydCBmb3IgdmVjdG9yIG1h
eGltdW0vbWluaW11bSkKNy8xNiBDaGVja2luZyBjb21taXQgZmU4MDUzOTZhZWUzICh0Y2cvcHBj
OiBBZGQgc3VwcG9ydCBmb3IgdmVjdG9yIGFkZC9zdWJ0cmFjdCkKOC8xNiBDaGVja2luZyBjb21t
aXQgNzk1N2Y4ZjQxYzYzICh0Y2cvcHBjOiBBZGQgc3VwcG9ydCBmb3IgdmVjdG9yIHNhdHVyYXRl
ZCBhZGQvc3VidHJhY3QpCjkvMTYgQ2hlY2tpbmcgY29tbWl0IGU0ZTY0MTlmOGM4OCAodGNnL3Bw
YzogUHJlcGFyZSBjYXNlIGZvciB2ZWN0b3IgbXVsdGlwbHkpCjEwLzE2IENoZWNraW5nIGNvbW1p
dCBmNjkwMjIzNzIyMDIgKHRjZy9wcGM6IEFkZCBlbXB0eSBmaWxlIHRjZy10YXJnZXQub3BjLmgp
CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5F
UlMgbmVlZCB1cGRhdGluZz8KIzE0OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCldBUk5JTkc6IEJs
b2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiMxOTogRklM
RTogdGNnL3BwYy90Y2ctdGFyZ2V0Lm9wYy5oOjE6CisvKiBUYXJnZXQtc3BlY2lmaWMgb3Bjb2Rl
cyBmb3IgaG9zdCB2ZWN0b3IgZXhwYW5zaW9uLiAgVGhlc2Ugd2lsbCBiZQoKV0FSTklORzogQmxv
Y2sgY29tbWVudHMgdXNlICogb24gc3Vic2VxdWVudCBsaW5lcwojMjA6IEZJTEU6IHRjZy9wcGMv
dGNnLXRhcmdldC5vcGMuaDoyOgorLyogVGFyZ2V0LXNwZWNpZmljIG9wY29kZXMgZm9yIGhvc3Qg
dmVjdG9yIGV4cGFuc2lvbi4gIFRoZXNlIHdpbGwgYmUKKyAgIGVtaXR0ZWQgYnkgdGNnX2V4cGFu
ZF92ZWNfb3AuICBGb3IgdGhvc2UgZmFtaWxpYXIgd2l0aCBHQ0MgaW50ZXJuYWxzLAoKV0FSTklO
RzogQmxvY2sgY29tbWVudHMgdXNlIGEgdHJhaWxpbmcgKi8gb24gYSBzZXBhcmF0ZSBsaW5lCiMy
MTogRklMRTogdGNnL3BwYy90Y2ctdGFyZ2V0Lm9wYy5oOjM6CisgICBjb25zaWRlciB0aGVzZSB0
byBiZSBVTlNQRUMgd2l0aCBuYW1lcy4gICovCgp0b3RhbDogMCBlcnJvcnMsIDQgd2FybmluZ3Ms
IDMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTAvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
MTEvMTYgQ2hlY2tpbmcgY29tbWl0IGUyOTNmZmY4MGIzOSAodGNnL3BwYzogU3VwcG9ydCB2ZWN0
b3Igc2hpZnQgYnkgaW1tZWRpYXRlKQoxMi8xNiBDaGVja2luZyBjb21taXQgODkyNGU2OGY5N2M2
ICh0Y2cvcHBjOiBTdXBwb3J0IHZlY3RvciBtdWx0aXBseSkKRVJST1I6IGNvZGUgaW5kZW50IHNo
b3VsZCBuZXZlciB1c2UgdGFicwojMTMzOiBGSUxFOiB0Y2cvcHBjL3RjZy10YXJnZXQuaW5jLmM6
MzIxOToKK15JYnJlYWs7JAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxODUgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMTIvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjEzLzE2IENo
ZWNraW5nIGNvbW1pdCBiNTIxOTAxNDg4NDUgKHRjZy9wcGM6IFN1cHBvcnQgdmVjdG9yIGR1cDIp
CjE0LzE2IENoZWNraW5nIGNvbW1pdCBiNTMzNTY4OGM4MjcgKHRjZy9wcGM6IFVwZGF0ZSB2ZWN0
b3Igc3VwcG9ydCB0byB2Mi4wNikKMTUvMTYgQ2hlY2tpbmcgY29tbWl0IDkwYmJmNTExNjM0OSAo
dGNnL3BwYzogVXBkYXRlIHZlY3RvciBzdXBwb3J0IHRvIHYyLjA3KQoxNi8xNiBDaGVja2luZyBj
b21taXQgMjJkMTMzYjdkMzI2ICh0Y2cvcHBjOiBVcGRhdGUgdmVjdG9yIHN1cHBvcnQgdG8gdjMu
MDApCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1
NjEzMDk0ODktMTYxNDYtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJr
LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


