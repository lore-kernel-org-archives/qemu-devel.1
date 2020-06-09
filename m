Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D029C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D42D206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D42D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilU2-0005FP-Oe
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jilSh-0003zy-KK; Tue, 09 Jun 2020 17:07:11 -0400
Resent-Date: Tue, 09 Jun 2020 17:07:11 -0400
Resent-Message-Id: <E1jilSh-0003zy-KK@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jilSf-00006T-Pq; Tue, 09 Jun 2020 17:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591736823; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c/99t47SpDclkWI7Tivd1/egjAYw67JpuVcic1xhgOMBJm+6dmRIKR9ajx6iJ1qm/FJPdE0fm965VH8VwPFeruhQCpoU9H5DbmdTXAl59gYteDSIOWyQkjrkP8F2yHG9Y5G3I4MqWplZE1XvqYl/OM5DqmTUWuftTB/KcujcgIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591736823;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vUMKs4op1ArDIpkowX8Bf4+9YTIxf6fEvRU7ntyXPW4=; 
 b=cC8fE+rVRcEhWqmnNk0SZWOsFYauv8ojOwkdqdBt3EIZrQ5+0jIIB7lGfiCSenC9Y8+rWkS/x7QyOPUwbohAvcnLzmSdM8eybPuhMCXkwqL55nnaYLjJlJU/mn35XoNa3IieVaYd5jDiphArqs80GTePEHiWsPVpPLfINw4CjgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591736821786453.82644463988186;
 Tue, 9 Jun 2020 14:07:01 -0700 (PDT)
Message-ID: <159173682062.16186.15972281845002245700@45ef0f9c86ae>
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
Subject: Re: [PATCH 0/7] target/arm: Convert Neon 3-reg-diff to decodetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Tue, 9 Jun 2020 14:07:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 16:12:36
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwOTE2MDIwOS4yOTk2
MC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDkxNjAyMDkuMjk5NjAtMS1wZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIIDAvN10gdGFyZ2V0L2FybTogQ29u
dmVydCBOZW9uIDMtcmVnLWRpZmYgdG8gZGVjb2RldHJlZQpUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRj
aGV3LXByb2plY3QvcWVtdQogICA0OWVlMTE1Li4zMWQzMjFjICBtYXN0ZXIgICAgIC0+IG1hc3Rl
cgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmZiOWNkNTIgdGFyZ2V0L2FybTogQ29u
dmVydCBOZW9uIDMtcmVnLWRpZmYgcG9seW5vbWlhbCBWTVVMTAowOGM1MDMwIHRhcmdldC9hcm06
IENvbnZlcnQgTmVvbiAzLXJlZy1kaWZmIHNhdHVyYXRpbmcgZG91YmxpbmcgbXVsdGlwbGllcwpk
ZjA1ZWFlIHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiAzLXJlZy1kaWZmIGxvbmcgbXVsdGlwbGll
cwo0MmJmY2ZjIHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiAzLXJlZy1kaWZmIFZBQkFMLCBWQUJE
TCB0byBkZWNvZGV0cmVlCjUzMDI1YmMgdGFyZ2V0L2FybTogQ29udmVydCBOZW9uIDMtcmVnLWRp
ZmYgbmFycm93aW5nIG9wcyB0byBkZWNvZGV0cmVlCmJjMzIxNTcgdGFyZ2V0L2FybTogQ29udmVy
dCBOZW9uIDMtcmVnLWRpZmYgcHJld2lkZW5pbmcgb3BzIHRvIGRlY29kZXRyZWUKZjZkYzE2ZiB0
YXJnZXQvYXJtOiBGaXggbWlzc2luZyB0ZW1wIGZyZWVzIGluIGRvX3ZzaGxsXzJzaAoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KMS83IENoZWNraW5nIGNvbW1pdCBmNmRjMTZmNDYzZWUgKHRhcmdldC9h
cm06IEZpeCBtaXNzaW5nIHRlbXAgZnJlZXMgaW4gZG9fdnNobGxfMnNoKQoyLzcgQ2hlY2tpbmcg
Y29tbWl0IGJjMzIxNTc1NGQ4ZiAodGFyZ2V0L2FybTogQ29udmVydCBOZW9uIDMtcmVnLWRpZmYg
cHJld2lkZW5pbmcgb3BzIHRvIGRlY29kZXRyZWUpCjMvNyBDaGVja2luZyBjb21taXQgNTMwMjVi
YzBhNjFlICh0YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24gMy1yZWctZGlmZiBuYXJyb3dpbmcgb3Bz
IHRvIGRlY29kZXRyZWUpCjQvNyBDaGVja2luZyBjb21taXQgNDJiZmNmY2MwOGFjICh0YXJnZXQv
YXJtOiBDb252ZXJ0IE5lb24gMy1yZWctZGlmZiBWQUJBTCwgVkFCREwgdG8gZGVjb2RldHJlZSkK
NS83IENoZWNraW5nIGNvbW1pdCBkZjA1ZWFlODYyODIgKHRhcmdldC9hcm06IENvbnZlcnQgTmVv
biAzLXJlZy1kaWZmIGxvbmcgbXVsdGlwbGllcykKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVy
IHRoYXQgJywnIChjdHg6VnhWKQojOTM6IEZJTEU6IHRhcmdldC9hcm0vdHJhbnNsYXRlLW5lb24u
aW5jLmM6MjIwMzoKKyNkZWZpbmUgRE9fVk1MQUwoSU5TTixNVUxMLEFDQykgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAgICAgIF4KCkVS
Uk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzkzOiBGSUxFOiB0
YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjIyMDM6CisjZGVmaW5lIERPX1ZNTEFMKElO
U04sTVVMTCxBQ0MpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0
aGF0ICcsJyAoY3R4OlZ4VikKIzExMTogRklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUtbmVvbi5p
bmMuYzoyMjIxOgorRE9fVk1MQUwoVk1MQUxfUyxtdWxsX3MsYWRkKQogICAgICAgICAgICAgICAg
IF4KCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzExMTog
RklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUtbmVvbi5pbmMuYzoyMjIxOgorRE9fVk1MQUwoVk1M
QUxfUyxtdWxsX3MsYWRkKQogICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2Ug
cmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCiMxMTI6IEZJTEU6IHRhcmdldC9hcm0v
dHJhbnNsYXRlLW5lb24uaW5jLmM6MjIyMjoKK0RPX1ZNTEFMKFZNTEFMX1UsbXVsbF91LGFkZCkK
ICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcg
KGN0eDpWeFYpCiMxMTI6IEZJTEU6IHRhcmdldC9hcm0vdHJhbnNsYXRlLW5lb24uaW5jLmM6MjIy
MjoKK0RPX1ZNTEFMKFZNTEFMX1UsbXVsbF91LGFkZCkKICAgICAgICAgICAgICAgICAgICAgICAg
XgoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojMTEzOiBG
SUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjIyMjM6CitET19WTUxBTChWTUxT
TF9TLG11bGxfcyxzdWIpCiAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlIHJlcXVpcmVk
IGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojMTEzOiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0
ZS1uZW9uLmluYy5jOjIyMjM6CitET19WTUxBTChWTUxTTF9TLG11bGxfcyxzdWIpCiAgICAgICAg
ICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAo
Y3R4OlZ4VikKIzExNDogRklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUtbmVvbi5pbmMuYzoyMjI0
OgorRE9fVk1MQUwoVk1MU0xfVSxtdWxsX3Usc3ViKQogICAgICAgICAgICAgICAgIF4KCkVSUk9S
OiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzExNDogRklMRTogdGFy
Z2V0L2FybS90cmFuc2xhdGUtbmVvbi5pbmMuYzoyMjI0OgorRE9fVk1MQUwoVk1MU0xfVSxtdWxs
X3Usc3ViKQogICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMTAgZXJyb3JzLCAwIHdh
cm5pbmdzLCAxMzggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS83IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo2LzcgQ2hlY2tpbmcgY29tbWl0IDA4YzUwMzA5Mjc2MSAodGFyZ2V0L2FybTogQ29u
dmVydCBOZW9uIDMtcmVnLWRpZmYgc2F0dXJhdGluZyBkb3VibGluZyBtdWx0aXBsaWVzKQo3Lzcg
Q2hlY2tpbmcgY29tbWl0IGZiOWNkNTJiMjc5MSAodGFyZ2V0L2FybTogQ29udmVydCBOZW9uIDMt
cmVnLWRpZmYgcG9seW5vbWlhbCBWTVVMTCkKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3Rl
cnMKIzE1NzogRklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUuYzo1MjMwOgorICAgICAgICAgICAg
ICAgIC8qIFRocmVlIHJlZ2lzdGVycyBvZiBkaWZmZXJlbnQgbGVuZ3RoczogaGFuZGxlZCBieSBk
ZWNvZGV0cmVlICovCgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDEzMSBsaW5lcyBjaGVj
a2VkCgpQYXRjaCA3LzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQg
PT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MDkxNjAyMDkuMjk5NjAt
MS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

