Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD0FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70F92074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70F92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiFf-0008Mc-Vd
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jii4R-0002Kx-Kr; Tue, 09 Jun 2020 13:29:55 -0400
Resent-Date: Tue, 09 Jun 2020 13:29:55 -0400
Resent-Message-Id: <E1jii4R-0002Kx-Kr@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jii4P-0003YB-DF; Tue, 09 Jun 2020 13:29:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591723785; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GdMdImmuxTgYZbLLConhJGfuZgJihdE1npxcbNBkgfpeX1W0ABaMyr9BcwAARYiaviy94urU+7pXqr+fsri4s/3Ix9iWw2hgY4kpF0w0Tme5t62ozNpaWQXaCcqC+AX9rhKXZC7DtTrJLQsYifKU2KDdSCBZ1y5p7Rm5Mo1acCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591723785;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Oc36TVcoTFAEcUvzHrqAqVxQt+Z+Mr/LOfRZjX5vIQc=; 
 b=Sd9kHRRuQIUg6+bhIEGGoAm4N/6l59/91pIOBo2m4xtIgIi5lKP5aFPZkh3D/vHVXqk+eSJWH3aVxly8dghus1IRuhMLVNBwLe0HvB2v8oXE/grtF3XVTkCeZ3pgx2YdXShQ8gbP1teoDAfJ5FhYt2i3aKUmQ6F5xQKGqun9kVA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591723782777769.50862008284;
 Tue, 9 Jun 2020 10:29:42 -0700 (PDT)
Message-ID: <159172378163.16186.844294258860761186@45ef0f9c86ae>
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
Subject: Re: [PATCH 0/7] target/arm: Convert Neon 3-reg-diff to decodetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Tue, 9 Jun 2020 10:29:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 13:01:26
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
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJv
amVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMTU5MTcyMDExOC03Mzc4LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5xZW11LmRldmVsQGdtYWlsLmNvbSAtPiBwYXRjaGV3
LzE1OTE3MjAxMTgtNzM3OC0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIucWVtdS5kZXZlbEBn
bWFpbC5jb20KICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDYwOTE2MzkzMi4xNTY2
MjA5LTEtYXJtYnJ1QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDYwOTE2MzkzMi4xNTY2MjA5
LTEtYXJtYnJ1QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoxMGQ2
YzI2IHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiAzLXJlZy1kaWZmIHBvbHlub21pYWwgVk1VTEwK
MzBiMDBjOSB0YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24gMy1yZWctZGlmZiBzYXR1cmF0aW5nIGRv
dWJsaW5nIG11bHRpcGxpZXMKMTg1ZWFmNyB0YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24gMy1yZWct
ZGlmZiBsb25nIG11bHRpcGxpZXMKNTdhM2EyZCB0YXJnZXQvYXJtOiBDb252ZXJ0IE5lb24gMy1y
ZWctZGlmZiBWQUJBTCwgVkFCREwgdG8gZGVjb2RldHJlZQo4ZTI1NjdhIHRhcmdldC9hcm06IENv
bnZlcnQgTmVvbiAzLXJlZy1kaWZmIG5hcnJvd2luZyBvcHMgdG8gZGVjb2RldHJlZQpiNDkwOGIz
IHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiAzLXJlZy1kaWZmIHByZXdpZGVuaW5nIG9wcyB0byBk
ZWNvZGV0cmVlCjc2NGRmOTMgdGFyZ2V0L2FybTogRml4IG1pc3NpbmcgdGVtcCBmcmVlcyBpbiBk
b192c2hsbF8yc2gKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNyBDaGVja2luZyBjb21taXQgNzY0
ZGY5M2JhYmY5ICh0YXJnZXQvYXJtOiBGaXggbWlzc2luZyB0ZW1wIGZyZWVzIGluIGRvX3ZzaGxs
XzJzaCkKMi83IENoZWNraW5nIGNvbW1pdCBiNDkwOGIzNGRjNzEgKHRhcmdldC9hcm06IENvbnZl
cnQgTmVvbiAzLXJlZy1kaWZmIHByZXdpZGVuaW5nIG9wcyB0byBkZWNvZGV0cmVlKQozLzcgQ2hl
Y2tpbmcgY29tbWl0IDhlMjU2N2E4Njk5OSAodGFyZ2V0L2FybTogQ29udmVydCBOZW9uIDMtcmVn
LWRpZmYgbmFycm93aW5nIG9wcyB0byBkZWNvZGV0cmVlKQo0LzcgQ2hlY2tpbmcgY29tbWl0IDU3
YTNhMmRjNzU3YSAodGFyZ2V0L2FybTogQ29udmVydCBOZW9uIDMtcmVnLWRpZmYgVkFCQUwsIFZB
QkRMIHRvIGRlY29kZXRyZWUpCjUvNyBDaGVja2luZyBjb21taXQgMTg1ZWFmN2ExZjBhICh0YXJn
ZXQvYXJtOiBDb252ZXJ0IE5lb24gMy1yZWctZGlmZiBsb25nIG11bHRpcGxpZXMpCkVSUk9SOiBz
cGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzkzOiBGSUxFOiB0YXJnZXQv
YXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjIyMDM6CisjZGVmaW5lIERPX1ZNTEFMKElOU04sTVVM
TCxBQ0MpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCiAgICAgICAg
ICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0
eDpWeFYpCiM5MzogRklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUtbmVvbi5pbmMuYzoyMjAzOgor
I2RlZmluZSBET19WTUxBTChJTlNOLE1VTEwsQUNDKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3Bh
Y2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCiMxMTE6IEZJTEU6IHRhcmdldC9h
cm0vdHJhbnNsYXRlLW5lb24uaW5jLmM6MjIyMToKK0RPX1ZNTEFMKFZNTEFMX1MsbXVsbF9zLGFk
ZCkKICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAn
LCcgKGN0eDpWeFYpCiMxMTE6IEZJTEU6IHRhcmdldC9hcm0vdHJhbnNsYXRlLW5lb24uaW5jLmM6
MjIyMToKK0RPX1ZNTEFMKFZNTEFMX1MsbXVsbF9zLGFkZCkKICAgICAgICAgICAgICAgICAgICAg
ICAgXgoKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojMTEy
OiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5zbGF0ZS1uZW9uLmluYy5jOjIyMjI6CitET19WTUxBTChW
TUxBTF9VLG11bGxfdSxhZGQpCiAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlIHJlcXVp
cmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojMTEyOiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5z
bGF0ZS1uZW9uLmluYy5jOjIyMjI6CitET19WTUxBTChWTUxBTF9VLG11bGxfdSxhZGQpCiAgICAg
ICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcs
JyAoY3R4OlZ4VikKIzExMzogRklMRTogdGFyZ2V0L2FybS90cmFuc2xhdGUtbmVvbi5pbmMuYzoy
MjIzOgorRE9fVk1MQUwoVk1MU0xfUyxtdWxsX3Msc3ViKQogICAgICAgICAgICAgICAgIF4KCkVS
Uk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzExMzogRklMRTog
dGFyZ2V0L2FybS90cmFuc2xhdGUtbmVvbi5pbmMuYzoyMjIzOgorRE9fVk1MQUwoVk1MU0xfUyxt
dWxsX3Msc3ViKQogICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcmVxdWly
ZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCiMxMTQ6IEZJTEU6IHRhcmdldC9hcm0vdHJhbnNs
YXRlLW5lb24uaW5jLmM6MjIyNDoKK0RPX1ZNTEFMKFZNTFNMX1UsbXVsbF91LHN1YikKICAgICAg
ICAgICAgICAgICBeCgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpW
eFYpCiMxMTQ6IEZJTEU6IHRhcmdldC9hcm0vdHJhbnNsYXRlLW5lb24uaW5jLmM6MjIyNDoKK0RP
X1ZNTEFMKFZNTFNMX1UsbXVsbF91LHN1YikKICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90
YWw6IDEwIGVycm9ycywgMCB3YXJuaW5ncywgMTM4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvNyBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi83IENoZWNraW5nIGNvbW1pdCAzMGIwMGM5NmZi
NDEgKHRhcmdldC9hcm06IENvbnZlcnQgTmVvbiAzLXJlZy1kaWZmIHNhdHVyYXRpbmcgZG91Ymxp
bmcgbXVsdGlwbGllcykKNy83IENoZWNraW5nIGNvbW1pdCAxMGQ2YzI2ZTI0ZmUgKHRhcmdldC9h
cm06IENvbnZlcnQgTmVvbiAzLXJlZy1kaWZmIHBvbHlub21pYWwgVk1VTEwpCldBUk5JTkc6IGxp
bmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxNTc6IEZJTEU6IHRhcmdldC9hcm0vdHJhbnNsYXRlLmM6
NTIzMDoKKyAgICAgICAgICAgICAgICAvKiBUaHJlZSByZWdpc3RlcnMgb2YgZGlmZmVyZW50IGxl
bmd0aHM6IGhhbmRsZWQgYnkgZGVjb2RldHJlZSAqLwoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5p
bmdzLCAxMzEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNy83IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwNjA5MTYwMjA5LjI5OTYwLTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

