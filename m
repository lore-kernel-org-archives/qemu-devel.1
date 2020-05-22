Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC1FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA65206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA65206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcDDS-0001iG-4h
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 15:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcDCs-00017w-4o; Fri, 22 May 2020 15:19:46 -0400
Resent-Date: Fri, 22 May 2020 15:19:46 -0400
Resent-Message-Id: <E1jcDCs-00017w-4o@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcDCq-0006tX-FV; Fri, 22 May 2020 15:19:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590175177; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IxnQgqbkOAaLdVCPyHSlQChCnQ8bskrcWoRAZyquk6ZbbPH4bqBFgcu9W+pN7HIMzTHnHiF2KTK+rJnFq1NckTL1JqImsNGXcwmmVSTHfjuBa41zAxD2cOBHv7qWcxwcJc6AksZG/6dOOWvP/Ly9jfTxFZPHDTLD9/5n/ZePqUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590175177;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GIVzNON5M/Qb3ytBT8WbHpJ2S+WmzreceQd0gNUWzSY=; 
 b=JBKNQu2RUMscgAbtPhtCl7v8unovfIAsNLiF3vEPBdj7IIWNO70sofFYvhd7ckyf6ZbUmiYoGm9JgyM7IAiiobHAM+Scx6Jy4WNWTQ3skvkLd7G2sOdyTqE8SIrTbJGBMT6toSI+k2/wxz0o1qaSRKR8Tjzmo9YKfjLycmA7zEI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159017517466624.333506421404195;
 Fri, 22 May 2020 12:19:34 -0700 (PDT)
Message-ID: <159017517351.1576.17509292162955098142@45ef0f9c86ae>
In-Reply-To: <20200522145520.6778-1-peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/9] target/arm: Convert 2-reg-shift and 1-reg-imm Neon
 insns to decodetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Fri, 22 May 2020 12:19:34 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 15:19:41
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMjE0NTUyMC42Nzc4
LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUyMjE0NTUyMC42Nzc4LTEtcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnClN1YmplY3Q6IFtQQVRDSCB2MiAwLzldIHRhcmdldC9hcm06IENv
bnZlcnQgMi1yZWctc2hpZnQgYW5kIDEtcmVnLWltbSBOZW9uIGluc25zIHRvIGRlY29kZXRyZWUK
VHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBy
ZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiYmZkYjZkIHRhcmdldC9hcm06IENvbnZlcnQgTmVv
biBvbmUtcmVnaXN0ZXItYW5kLWltbWVkaWF0ZSBpbnNucyB0byBkZWNvZGV0cmVlCmUxMmFiNGYg
dGFyZ2V0L2FybTogQ29udmVydCBWQ1ZUIGZpeGVkLXBvaW50IG9wcyB0byBkZWNvZGV0cmVlCmUz
MmZmZDAgdGFyZ2V0L2FybTogQ29udmVydCBOZW9uIFZTSExMLCBWTU9WTCB0byBkZWNvZGV0cmVl
CjA5ZjkyOTQgdGFyZ2V0L2FybTogQ29udmVydCBOZW9uIG5hcnJvd2luZyBzaGlmdHMgd2l0aCBv
cD09OSB0byBkZWNvZGV0cmVlCjcyMzU5ODEgdGFyZ2V0L2FybTogQ29udmVydCBOZW9uIG5hcnJv
d2luZyBzaGlmdHMgd2l0aCBvcD09OCB0byBkZWNvZGV0cmVlCjFkZjU3ZDUgdGFyZ2V0L2FybTog
Q29udmVydCBWUVNITFUsIFZRU0hMIDItcmVnLXNoaWZ0IGluc25zIHRvIGRlY29kZXRyZWUKYzJi
NjI3NyB0YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24gVlNSQSwgVlNSSSwgVlJTSFIsIFZSU1JBIDIt
cmVnLXNoaWZ0IGluc25zIHRvIGRlY29kZXRyZWUKZjQ4YjU5YyB0YXJnZXQvYXJtOiBDb252ZXJ0
IE5lb24gVlNIUiAyLXJlZy1zaGlmdCBpbnNucyB0byBkZWNvZGV0cmVlCjJhMmQ3NGMgdGFyZ2V0
L2FybTogQ29udmVydCBOZW9uIFZTSEwgYW5kIFZTTEkgMi1yZWctc2hpZnQgaW5zbiB0byBkZWNv
ZGV0cmVlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzkgQ2hlY2tpbmcgY29tbWl0IDJhMmQ3NGM4
OWJiNSAodGFyZ2V0L2FybTogQ29udmVydCBOZW9uIFZTSEwgYW5kIFZTTEkgMi1yZWctc2hpZnQg
aW5zbiB0byBkZWNvZGV0cmVlKQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcq
JyAoY3R4Old4VikKIzU1OiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjEz
MTQ6CitzdGF0aWMgYm9vbCBkb192ZWN0b3JfMnNoKERpc2FzQ29udGV4dCAqcywgYXJnXzJyZWdf
c2hpZnQgKmEsIEdWZWNHZW4yaUZuICpmbikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFy
b3VuZCB0aGF0ICcqJyAoY3R4Old4VikKIzg1OiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1u
ZW9uLmluYy5jOjEzNDQ6CisgICAgc3RhdGljIGJvb2wgdHJhbnNfIyNJTlNOIyNfMnNoKERpc2Fz
Q29udGV4dCAqcywgYXJnXzJyZWdfc2hpZnQgKmEpICBcCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDIg
ZXJyb3JzLCAwIHdhcm5pbmdzLCA5OSBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzkgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCjIvOSBDaGVja2luZyBjb21taXQgZjQ4YjU5YzYyYjhhICh0YXJn
ZXQvYXJtOiBDb252ZXJ0IE5lb24gVlNIUiAyLXJlZy1zaGlmdCBpbnNucyB0byBkZWNvZGV0cmVl
KQpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4VikKIzkzOiBG
SUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjEzNzA6CitzdGF0aWMgYm9vbCB0
cmFuc19WU0hSX1NfMnNoKERpc2FzQ29udGV4dCAqcywgYXJnXzJyZWdfc2hpZnQgKmEpCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMjAgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
Mi85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzkgQ2hlY2tpbmcgY29tbWl0IGMyYjYy
NzdhNGU5YyAodGFyZ2V0L2FybTogQ29udmVydCBOZW9uIFZTUkEsIFZTUkksIFZSU0hSLCBWUlNS
QSAyLXJlZy1zaGlmdCBpbnNucyB0byBkZWNvZGV0cmVlKQo0LzkgQ2hlY2tpbmcgY29tbWl0IDFk
ZjU3ZDU4ZTU1MSAodGFyZ2V0L2FybTogQ29udmVydCBWUVNITFUsIFZRU0hMIDItcmVnLXNoaWZ0
IGluc25zIHRvIGRlY29kZXRyZWUpCjUvOSBDaGVja2luZyBjb21taXQgNzIzNTk4MWZiZTQzICh0
YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24gbmFycm93aW5nIHNoaWZ0cyB3aXRoIG9wPT04IHRvIGRl
Y29kZXRyZWUpCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojMTcwOiBGSUxFOiB0
YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjE2MTE6CisgICAgLy8gdG9kbyBleHBhbmQg
b3V0IHRoZSBzaGlmdC1uYXJyb3cgYW5kIHRoZSBuYXJyb3ctb3AKCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgMjE0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvOSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKNi85IENoZWNraW5nIGNvbW1pdCAwOWY5Mjk0ZmU4NmEgKHRhcmdldC9hcm06
IENvbnZlcnQgTmVvbiBuYXJyb3dpbmcgc2hpZnRzIHdpdGggb3A9PTkgdG8gZGVjb2RldHJlZSkK
Ny85IENoZWNraW5nIGNvbW1pdCBlMzJmZmQwZmZiMzUgKHRhcmdldC9hcm06IENvbnZlcnQgTmVv
biBWU0hMTCwgVk1PVkwgdG8gZGVjb2RldHJlZSkKOC85IENoZWNraW5nIGNvbW1pdCBlMTJhYjRm
OWJmZjYgKHRhcmdldC9hcm06IENvbnZlcnQgVkNWVCBmaXhlZC1wb2ludCBvcHMgdG8gZGVjb2Rl
dHJlZSkKOS85IENoZWNraW5nIGNvbW1pdCBiYmZkYjZkY2M2ZDggKHRhcmdldC9hcm06IENvbnZl
cnQgTmVvbiBvbmUtcmVnaXN0ZXItYW5kLWltbWVkaWF0ZSBpbnNucyB0byBkZWNvZGV0cmVlKQo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUy
MjE0NTUyMC42Nzc4LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

