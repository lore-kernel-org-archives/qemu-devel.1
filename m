Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29822C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F409D206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F409D206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82N7-0004L2-Ni
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i82LO-0002tv-JT
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i82LN-00006F-2J
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:34 -0400
Resent-Date: Wed, 11 Sep 2019 09:07:34 -0400
Resent-Message-Id: <E1i82LN-00006F-2J@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i82LM-00005V-R0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568207229; cv=none; d=zoho.com; s=zohoarc; 
 b=ZuKD6TArSXxTLoR3Dx9ftF9d9kZ//iE7eXPolM8grZuKni0gCSHAETx8a8fLV1hLcWn/KGnxzWaXh0wiyWq40UmMTQFMewR2JOCmfQXZBOqhqsWoV+MNbpXA8qljpjTuhahkScIcDxXDOJAZnw0p4PHgPKYzKr7P4aofzgjCd1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568207229;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=DOrUUlmPJ0I8lwm9ZG7nAT5Z9PndFeubSspQ7IbnNWk=; 
 b=HOs40hz5bIR3TMaaDvpMiDuum73x9TPjXotGhQ1QYFHG/8OHE5YBCOWQuDzRy3Ij8kQ4DNoEAkfHIQVWduOXoLwVJQuiQRPyVym1vpFAWhhqJjQYXluOUmFkpwrFK+0agJUjrj01MqChlAgl+s4COu3AGdXEhBvnuETJ+ZV3fvY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568207227336193.1637134517805;
 Wed, 11 Sep 2019 06:07:07 -0700 (PDT)
In-Reply-To: <20190911014353.5926-1-richard.henderson@linaro.org>
Message-ID: <156820722618.19232.2414632091908077912@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Wed, 11 Sep 2019 06:07:07 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH 0/3] cputlb: Adjust tlb bswap implementation
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, tony.nguyen@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMTAxNDM1My41OTI2
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpsaWJ1ZGV2ICAg
ICAgICAgICBubwpkZWZhdWx0IGRldmljZXMgICB5ZXMKCndhcm5pbmc6IFB5dGhvbiAyIHN1cHBv
cnQgaXMgZGVwcmVjYXRlZAp3YXJuaW5nOiBQeXRob24gMyB3aWxsIGJlIHJlcXVpcmVkIGZvciBi
dWlsZGluZyBmdXR1cmUgdmVyc2lvbnMgb2YgUUVNVQoKTk9URTogY3Jvc3MtY29tcGlsZXJzIGVu
YWJsZWQ6ICAnY2MnCiAgR0VOICAgICB4ODZfNjQtc29mdG1tdS9jb25maWctZGV2aWNlcy5tYWsu
dG1wCi0tLQpNZW1vcnkgY29udGVudCBpbmNvbnNpc3RlbmN5IGF0IDQwMWFhMDAwIGZpcnN0X2J5
dGUgPSBlNCBsYXN0X2J5dGUgPSBlNCBjdXJyZW50ID0gZTUgaGl0X2VkZ2UgPSAwCiAgVEVTVCAg
ICBjaGVjay1xdGVzdC14ODZfNjQ6IHRlc3RzL2FoY2ktdGVzdAphbmQgaW4gYW5vdGhlciAyNTE3
MyBwYWdlcyoqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9taWdyYXRpb24tdGVzdC5j
OjM0MjpjaGVja19ndWVzdHNfcmFtOiBhc3NlcnRpb24gZmFpbGVkOiAoYmFkID09IDApCkVSUk9S
IC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9taWdyYXRpb24tdGVz
dC5jOjM0MjpjaGVja19ndWVzdHNfcmFtOiBhc3NlcnRpb24gZmFpbGVkOiAoYmFkID09IDApCm1h
a2U6ICoqKiBbY2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1h
aW8tbXVsdGl0aHJlYWQKLS0tCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDI1MgpQYXNzZWQgYWxs
IDEwNiB0ZXN0cwoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvYm9vdC1zZWN0b3Iu
YzoxNjE6Ym9vdF9zZWN0b3JfdGVzdDogYXNzZXJ0aW9uIGZhaWxlZCAoc2lnbmF0dXJlID09IFNJ
R05BVFVSRSk6ICgweDAwMDAwMDAwID09IDB4MDAwMGRlYWQpCkVSUk9SIC0gQmFpbCBvdXQhIEVS
Uk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9ib290LXNlY3Rvci5jOjE2MTpib290X3NlY3Rv
cl90ZXN0OiBhc3NlcnRpb24gZmFpbGVkIChzaWduYXR1cmUgPT0gU0lHTkFUVVJFKTogKDB4MDAw
MDAwMDAgPT0gMHgwMDAwZGVhZCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9y
IDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9j
a2VyL2RvY2tlci5weSIsIGxpbmUgNjU5LCBpbiA8bW9kdWxlPgoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTEwMTQzNTMuNTkyNi0x
LXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9z
Ny8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


