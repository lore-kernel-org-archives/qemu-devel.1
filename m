Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B18C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D491207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D491207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQFaL-0007bZ-3u
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQFZc-00072q-DE; Wed, 07 Oct 2020 15:58:04 -0400
Resent-Date: Wed, 07 Oct 2020 15:58:04 -0400
Resent-Message-Id: <E1kQFZc-00072q-DE@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQFZZ-0003e1-Vc; Wed, 07 Oct 2020 15:58:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602100669; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aUeMrfbAcDyOFlgXpzjOKEbRqCViCRDS2f+4+KzjYrX7/w5WdxUVwFwf3/sK4IjQkKILW1+iXIYH4AdV+XcfgIjIwahFSB1Zfxi/l7u6UpI55G26YR+JYMxgi+7Xg70Lo7OomRwvfqjjtOZ7xq3tm7VgrFXbjWRB+ZWmo09k564=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602100669;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4K6tlDaToXQlcMezbPyjT+4v9f5Uyk1Hbw1/OKiDI30=; 
 b=DYOmTMYufwxRf9lZiS6RftKGjYaNMi02cMrqJ7xD8GF5cij7cXqVqTB04qgxTFXdYwOqLxTm4n/RMMWdXvxyu7OXB9OnZtwd+aEZ1wDxVl5IWB1JbBscvgOtZ3ZhEQix4UMvCuc8yPt/YRjeFkrXIugvpYfLxn0OJ2v/svgIyxo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602100667290224.39806590085516;
 Wed, 7 Oct 2020 12:57:47 -0700 (PDT)
Subject: Re: [PATCH v9] scripts: Convert qemu-version.sh to qemu-version.py
Message-ID: <160210066573.3664.15411398182465607486@66eaa9a8a123>
In-Reply-To: <20201007195035.2006-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luoyonggang@gmail.com
Date: Wed, 7 Oct 2020 12:57:47 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:33:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, luoyonggang@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwNzE5NTAzNS4yMDA2
LTEtbHVveW9uZ2dhbmdAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMDcxOTUwMzUuMjAw
Ni0xLWx1b3lvbmdnYW5nQGdtYWlsLmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjldIHNjcmlwdHM6IENv
bnZlcnQgcWVtdS12ZXJzaW9uLnNoIHRvIHFlbXUtdmVyc2lvbi5weQoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwg
ZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRo
bSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3Fl
bXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTAwNzE5NTAzNS4yMDA2LTEtbHVv
eW9uZ2dhbmdAZ21haWwuY29tIC0+IHBhdGNoZXcvMjAyMDEwMDcxOTUwMzUuMjAwNi0xLWx1b3lv
bmdnYW5nQGdtYWlsLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmNlODY2NDYg
c2NyaXB0czogQ29udmVydCBxZW11LXZlcnNpb24uc2ggdG8gcWVtdS12ZXJzaW9uLnB5Cgo9PT0g
T1VUUFVUIEJFR0lOID09PQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMp
LCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzNDogCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzU5OiBGSUxFOiBzY3JpcHRzL3Fl
bXUtdmVyc2lvbi5weToyMToKKyAgICAgICAgbWF0Y2hfZXhwcmVzc2lvbiA9ICctLW1hdGNoPXZc
XConIGlmIHBsYXRmb3JtLnN5c3RlbSgpID09ICdXaW5kb3dzJyBlbHNlICctLW1hdGNoPXYqJwoK
V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzYwOiBGSUxFOiBzY3JpcHRzL3FlbXUt
dmVyc2lvbi5weToyMjoKKyAgICAgICAgcGMgPSBzdWJwcm9jZXNzLnJ1bihbJ2dpdCcsICdkZXNj
cmliZScsIG1hdGNoX2V4cHJlc3Npb24sICctLWRpcnR5JywgJy0tYWx3YXlzJ10sCgpFUlJPUjog
bGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzYxOiBGSUxFOiBzY3JpcHRzL3FlbXUtdmVyc2lvbi5w
eToyMzoKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGRvdXQ9c3VicHJvY2Vzcy5QSVBF
LCBzdGRlcnI9c3VicHJvY2Vzcy5ERVZOVUxMLCBlbmNvZGluZz0ndXRmOCcsIHNoZWxsPUZhbHNl
KQoKdG90YWw6IDIgZXJyb3JzLCAyIHdhcm5pbmdzLCA0MyBsaW5lcyBjaGVja2VkCgpDb21taXQg
Y2U4NjY0NmQyMjAzIChzY3JpcHRzOiBDb252ZXJ0IHFlbXUtdmVyc2lvbi5zaCB0byBxZW11LXZl
cnNpb24ucHkpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAxMDA3MTk1MDM1LjIwMDYtMS1sdW95
b25nZ2FuZ0BnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

