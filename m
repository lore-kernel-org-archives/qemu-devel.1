Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B62C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF8120709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF8120709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhy0-0006cg-2P
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZhx8-0005P6-CG; Fri, 15 May 2020 17:33:10 -0400
Resent-Date: Fri, 15 May 2020 17:33:10 -0400
Resent-Message-Id: <E1jZhx8-0005P6-CG@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZhx5-0001ru-0a; Fri, 15 May 2020 17:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589578378; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RZtiaQlYh0DEztQMue1HwCVEWsUqtcmP35HOORFU/yzFh32K06huHd48WW1ejvnS8chIsRhk7Fc0FOdZR59hs78iQm12URLmtmkVr+ypqfvhcdQD4V5lSov4s2Q6jvMWG8Wkt+jbUFRc5xCnhIoXb7XfuZIRl/5bAReiQWPif3g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589578378;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xb3zRlG+dmNH0712vSEhGXKorvIWlA3I3fW0z9HvmCw=; 
 b=XEX4CoVOCV2sOP8degVEPOSse66JcM6ZICW/xRW0ksDspwjV7/lXw6fKbFNX8piYKqjwwBBkXvwlTfh7hX7YvhAxW6MCK2kINd+HA9hSdejP9Gi3+v0dhZWjzDBbKESldhLSH9N3GCw4vo4Ad/wXXRcGR2orjtD6UWy8rfugllk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158957837716067.92009417797397;
 Fri, 15 May 2020 14:32:57 -0700 (PDT)
Message-ID: <158957837598.9380.8266522571100324097@45ef0f9c86ae>
In-Reply-To: <20200515142056.21346-1-peter.maydell@linaro.org>
Subject: Re: [PATCH 00/10] target/arm: Convert 2-reg-shift and 1-reg-imm Neon
 insns to decodetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Fri, 15 May 2020 14:32:57 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 16:30:15
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNTE0MjA1Ni4yMTM0
Ni0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MTUxNDIwNTYuMjEzNDYtMS1wZXRl
ci5tYXlkZWxsQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIIDAwLzEwXSB0YXJnZXQvYXJtOiBD
b252ZXJ0IDItcmVnLXNoaWZ0IGFuZCAxLXJlZy1pbW0gTmVvbiBpbnNucyB0byBkZWNvZGV0cmVl
ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNzRjOGVhMCB0YXJnZXQvYXJtOiBDb252ZXJ0IE5l
b24gb25lLXJlZ2lzdGVyLWFuZC1pbW1lZGlhdGUgaW5zbnMgdG8gZGVjb2RldHJlZQo3ZGMxNjkz
IHRhcmdldC9hcm06IENvbnZlcnQgVkNWVCBmaXhlZC1wb2ludCBvcHMgdG8gZGVjb2RldHJlZQpk
YzAyZDM3IHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiBWU0hMTCwgVk1PVkwgdG8gZGVjb2RldHJl
ZQo3Njc0YTVlIHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiBuYXJyb3dpbmcgc2hpZnRzIHdpdGgg
b3A9PTkgdG8gZGVjb2RldHJlZQo2ZWVkMWYwIHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiBuYXJy
b3dpbmcgc2hpZnRzIHdpdGggb3A9PTggdG8gZGVjb2RldHJlZQpiNjMzNjRhIHRhcmdldC9hcm06
IENvbnZlcnQgVlFTSExVLCBWUVNITCAyLXJlZy1zaGlmdCBpbnNucyB0byBkZWNvZGV0cmVlCjFl
NmZiNGEgdGFyZ2V0L2FybTogQ29udmVydCBOZW9uIFZTUkEsIFZTUkksIFZSU0hSLCBWUlNSQSAy
LXJlZy1zaGlmdCBpbnNucyB0byBkZWNvZGV0cmVlCjczNTUwMWUgdGFyZ2V0L2FybTogQ29udmVy
dCBOZW9uIFZTSFIgMi1yZWctc2hpZnQgaW5zbnMgdG8gZGVjb2RldHJlZQo5NTY5N2MxIHRhcmdl
dC9hcm06IENvbnZlcnQgTmVvbiBWU0hMIGFuZCBWU0xJIDItcmVnLXNoaWZ0IGluc24gdG8gZGVj
b2RldHJlZQplY2YyZDk1IHRhcmdldC9hcm06IFJlbW92ZSB1bnVzZWQgR0VOX05FT05fSU5URUdF
Ul9PUCBtYWNybwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMCBDaGVja2luZyBjb21taXQgZWNm
MmQ5NWRhMGMyICh0YXJnZXQvYXJtOiBSZW1vdmUgdW51c2VkIEdFTl9ORU9OX0lOVEVHRVJfT1Ag
bWFjcm8pCjIvMTAgQ2hlY2tpbmcgY29tbWl0IDk1Njk3YzFhMDNhMyAodGFyZ2V0L2FybTogQ29u
dmVydCBOZW9uIFZTSEwgYW5kIFZTTEkgMi1yZWctc2hpZnQgaW5zbiB0byBkZWNvZGV0cmVlKQpF
UlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4VikKIzU3OiBGSUxF
OiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjEzMTQ6CitzdGF0aWMgYm9vbCBkb192
ZWN0b3JfMnNoKERpc2FzQ29udGV4dCAqcywgYXJnXzJyZWdfc2hpZnQgKmEsIEdWZWNHZW4yaUZu
ICpmbikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4
VikKIzg3OiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjEzNDQ6CisgICAg
c3RhdGljIGJvb2wgdHJhbnNfIyNJTlNOIyNfMnNoKERpc2FzQ29udGV4dCAqcywgYXJnXzJyZWdf
c2hpZnQgKmEpICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAx
MDEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xMCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoK
My8xMCBDaGVja2luZyBjb21taXQgNzM1NTAxZWMzNDAyICh0YXJnZXQvYXJtOiBDb252ZXJ0IE5l
b24gVlNIUiAyLXJlZy1zaGlmdCBpbnNucyB0byBkZWNvZGV0cmVlKQpFUlJPUjogc3BhY2VzIHJl
cXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4VikKIzg0OiBGSUxFOiB0YXJnZXQvYXJtL3Ry
YW5zbGF0ZS1uZW9uLmluYy5jOjEzNzA6CitzdGF0aWMgYm9vbCB0cmFuc19WU0hSX1NfMnNoKERp
c2FzQ29udGV4dCAqcywgYXJnXzJyZWdfc2hpZnQgKmEpCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAxMTMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8xMCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKNC8xMCBDaGVja2luZyBjb21taXQgMWU2ZmI0YTkwMWJlICh0YXJnZXQv
YXJtOiBDb252ZXJ0IE5lb24gVlNSQSwgVlNSSSwgVlJTSFIsIFZSU1JBIDItcmVnLXNoaWZ0IGlu
c25zIHRvIGRlY29kZXRyZWUpCjUvMTAgQ2hlY2tpbmcgY29tbWl0IGI2MzM2NGFmYWM3YSAodGFy
Z2V0L2FybTogQ29udmVydCBWUVNITFUsIFZRU0hMIDItcmVnLXNoaWZ0IGluc25zIHRvIGRlY29k
ZXRyZWUpCjYvMTAgQ2hlY2tpbmcgY29tbWl0IDZlZWQxZjAxNGE3YyAodGFyZ2V0L2FybTogQ29u
dmVydCBOZW9uIG5hcnJvd2luZyBzaGlmdHMgd2l0aCBvcD09OCB0byBkZWNvZGV0cmVlKQpFUlJP
UjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzE3NTogRklMRTogdGFyZ2V0L2FybS90cmFu
c2xhdGUtbmVvbi5pbmMuYzoxNjExOgorICAgIC8vIHRvZG8gZXhwYW5kIG91dCB0aGUgc2hpZnQt
bmFycm93IGFuZCB0aGUgbmFycm93LW9wCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDIx
OSBsaW5lcyBjaGVja2VkCgpQYXRjaCA2LzEwIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo3
LzEwIENoZWNraW5nIGNvbW1pdCA3Njc0YTVlNDE4ZjkgKHRhcmdldC9hcm06IENvbnZlcnQgTmVv
biBuYXJyb3dpbmcgc2hpZnRzIHdpdGggb3A9PTkgdG8gZGVjb2RldHJlZSkKOC8xMCBDaGVja2lu
ZyBjb21taXQgZGMwMmQzNzNkMjMyICh0YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24gVlNITEwsIFZN
T1ZMIHRvIGRlY29kZXRyZWUpCjkvMTAgQ2hlY2tpbmcgY29tbWl0IDdkYzE2OTNhZDdhOCAodGFy
Z2V0L2FybTogQ29udmVydCBWQ1ZUIGZpeGVkLXBvaW50IG9wcyB0byBkZWNvZGV0cmVlKQoxMC8x
MCBDaGVja2luZyBjb21taXQgNzRjOGVhMDVlZTBmICh0YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24g
b25lLXJlZ2lzdGVyLWFuZC1pbW1lZGlhdGUgaW5zbnMgdG8gZGVjb2RldHJlZSkKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MTUxNDIwNTYu
MjEzNDYtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

