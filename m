Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9667C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B84D22277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B84D22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFYe-0007zI-Td
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUFTf-00021V-3w
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:40:27 -0400
Resent-Date: Sun, 18 Oct 2020 16:40:27 -0400
Resent-Message-Id: <E1kUFTf-00021V-3w@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUFTc-0001s4-DO
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603053618; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GbpBVskOIUpqlIpaY8EE0p3XhHjCptY6d5UNtWyOVCTQIWmcsMsqjbmQdqTRvKdc5TzbZPfmKM/8KzroN9TNi8Dex0ge67NC9G93qxb5Iv7m6hWOctUkNtnDhy4pBD91Gc+NmY9DIRbUvk8KadZmpyVu78Cosl8UrxIgJB2YxHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603053618;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qgH6Tp86iRYzg5JSBW5G3t1W0kC/eEjH3zWXp3JSx0c=; 
 b=UD53zTpiqxZ0llG5TNE+SvxRma6RUmZAEjQalf/4EQYOqdrjn3ZW3L7TwWG940TG2QPXdjUNAmroMOElUWDs9iZj44o5+zzpW30onR7KDUHm8nKvxBAUaO4EpY0lnu9XYhWMpO/lozKGfa2QXOqnxTZi8jQ7r6+VCCn39ZIaEcc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603053616194671.2877399256463;
 Sun, 18 Oct 2020 13:40:16 -0700 (PDT)
Subject: Re: [PATCH] softfloat: Mark base int-to-float routines QEMU_FLATTEN
Message-ID: <160305361514.17996.4155079706197374604@66eaa9a8a123>
In-Reply-To: <20201018203334.1229243-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sun, 18 Oct 2020 13:40:16 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 16:40:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAxODIwMzMzNC4xMjI5
MjQzLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAxMDE4
MjAzMzM0LjEyMjkyNDMtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN1YmplY3Q6IFtQ
QVRDSF0gc29mdGZsb2F0OiBNYXJrIGJhc2UgaW50LXRvLWZsb2F0IHJvdXRpbmVzIFFFTVVfRkxB
VFRFTgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0Jwo0ZmZkNjE2IHNvZnRmbG9hdDogTWFyayBiYXNlIGludC10by1mbG9hdCByb3V0
aW5lcyBRRU1VX0ZMQVRURU4KCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBzcGFjZXMgcmVx
dWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hWKQojMjk6IEZJTEU6IGZwdS9zb2Z0ZmxvYXQu
YzoyNzc5OgoraW50NjRfdG9fZmxvYXQxNl9zY2FsYm4oaW50NjRfdCBhLCBpbnQgc2NhbGUsIGZs
b2F0X3N0YXR1cyAqc3RhdHVzKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0
aGF0ICcqJyAoY3R4Old4VikKIzM5OiBGSUxFOiBmcHUvc29mdGZsb2F0LmM6MjgxNjoKK2ludDY0
X3RvX2Zsb2F0MzJfc2NhbGJuKGludDY0X3QgYSwgaW50IHNjYWxlLCBmbG9hdF9zdGF0dXMgKnN0
YXR1cykKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpX
eFYpCiM0OTogRklMRTogZnB1L3NvZnRmbG9hdC5jOjI4NDg6CitpbnQ2NF90b19mbG9hdDY0X3Nj
YWxibihpbnQ2NF90IGEsIGludCBzY2FsZSwgZmxvYXRfc3RhdHVzICpzdGF0dXMpCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVS
Uk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hWKQojNTk6IEZJTEU6
IGZwdS9zb2Z0ZmxvYXQuYzoyODg1OgoraW50NjRfdG9fYmZsb2F0MTZfc2NhbGJuKGludDY0X3Qg
YSwgaW50IHNjYWxlLCBmbG9hdF9zdGF0dXMgKnN0YXR1cykKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMg
cmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hWKQojNjk6IEZJTEU6IGZwdS9zb2Z0Zmxv
YXQuYzoyOTQ4OgordWludDY0X3RvX2Zsb2F0MTZfc2NhbGJuKHVpbnQ2NF90IGEsIGludCBzY2Fs
ZSwgZmxvYXRfc3RhdHVzICpzdGF0dXMpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBh
cm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiM3OTogRklMRTogZnB1L3NvZnRmbG9hdC5jOjI5ODU6
Cit1aW50NjRfdG9fZmxvYXQzMl9zY2FsYm4odWludDY0X3QgYSwgaW50IHNjYWxlLCBmbG9hdF9z
dGF0dXMgKnN0YXR1cykKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0
ICcqJyAoY3R4Old4VikKIzg5OiBGSUxFOiBmcHUvc29mdGZsb2F0LmM6MzAxNzoKK3VpbnQ2NF90
b19mbG9hdDY0X3NjYWxibih1aW50NjRfdCBhLCBpbnQgc2NhbGUsIGZsb2F0X3N0YXR1cyAqc3Rh
dHVzKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6
V3hWKQojOTk6IEZJTEU6IGZwdS9zb2Z0ZmxvYXQuYzozMDU0OgordWludDY0X3RvX2JmbG9hdDE2
X3NjYWxibih1aW50NjRfdCBhLCBpbnQgc2NhbGUsIGZsb2F0X3N0YXR1cyAqc3RhdHVzKQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBeCgp0b3RhbDogOCBlcnJvcnMsIDAgd2FybmluZ3MsIDcyIGxpbmVzIGNoZWNrZWQKCkNvbW1p
dCA0ZmZkNjE2ZjRjNWQgKHNvZnRmbG9hdDogTWFyayBiYXNlIGludC10by1mbG9hdCByb3V0aW5l
cyBRRU1VX0ZMQVRURU4pIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAxMDE4MjAzMzM0LjEyMjky
NDMtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

