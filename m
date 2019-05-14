Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA9BC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B1C20850
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 17:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B1C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51645 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQbCT-0002Xc-3Y
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 13:26:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hQbBf-00025Z-Nn
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hQbBd-0004bF-6D
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:25:59 -0400
Resent-Date: Tue, 14 May 2019 13:25:59 -0400
Resent-Message-Id: <E1hQbBd-0004bF-6D@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hQbBc-0004CE-TT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 13:25:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1557854720; cv=none; d=zoho.com; s=zohoarc; 
	b=ZI2QsB1NbCXBBz0uHsr8FTkmBxP1ROGI+xEOEwknn0qSNr6Y0Hi6hNtXZdcRq5me+FjOzoMxF22Kcvj3ISnDAZ0uLK7bbcfKMuEW0yIVlQ7jA8iujgmYcdI3ykENay6mcNVnRLVAgrEY2RwhAWYOQb1Y4O0QkSP2rlDce/Kz9dk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1557854720;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=EalVtdtiaQmIx4l5JM0YcZ83/JwB671hGzt738B5GWA=; 
	b=jXQEYXr8CqcnqB7x1w/TtvaBo6iEH1H00DudQTiHscsO7RE/0wN2RKNPyQecsVATTxvCfgISdb04kqiUA8XmzZdDVEv3TG795MN4cIxWP4VUFGNlQhOiJ7fvuhRq+bEPDtqUkBkZRKtNjuVNAyzT0gJzxKXSt7K+tgTDTXQ/BuE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1557854711108371.9567291192452;
	Tue, 14 May 2019 10:25:11 -0700 (PDT)
Message-ID: <155785470986.250.14828843969119255459@ae4ddf60de60>
In-Reply-To: <20190514145346.20758-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: wens@kernel.org
Date: Tue, 14 May 2019 10:25:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] linux-user: Pass through nanosecond
 timestamp components for stat syscalls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, riku.voipio@iki.fi, qemu-devel@nongnu.org, wens@kernel.org,
	laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUxNDE0NTM0Ni4yMDc1
OC0xLXdlbnNAa2VybmVsLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNTE0MTQ1MzQ2LjIwNzU4LTEt
d2Vuc0BrZXJuZWwub3JnClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIGxpbnV4LXVzZXI6
IFBhc3MgdGhyb3VnaCBuYW5vc2Vjb25kIHRpbWVzdGFtcCBjb21wb25lbnRzIGZvciBzdGF0IHN5
c2NhbGxzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0JwplY2FlN2VlIGxpbnV4LXVzZXI6IFBhc3MgdGhyb3VnaCBuYW5v
c2Vjb25kIHRpbWVzdGFtcCBjb21wb25lbnRzIGZvciBzdGF0IHN5c2NhbGxzCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM5NDog
RklMRTogbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDoxMTk1OgorXklhYmlfdWxvbmcgIHRhcmdl
dF9zdF9hdGltZV9uc2VjOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzk3OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjExOTc6CiteSWFiaV91bG9u
ZyAgdGFyZ2V0X3N0X210aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMTAwOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjExOTk6Cite
SWFiaV91bG9uZyAgdGFyZ2V0X3N0X2N0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNo
b3VsZCBuZXZlciB1c2UgdGFicwojMTA5OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5o
OjEyMzE6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2F0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUg
aW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTEzOiBGSUxFOiBsaW51eC11c2VyL3N5c2Nh
bGxfZGVmcy5oOjEyMzQ6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X210aW1lX25zZWM7JAoKRVJS
T1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTE3OiBGSUxFOiBsaW51eC11
c2VyL3N5c2NhbGxfZGVmcy5oOjEyMzc6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2N0aW1lX25z
ZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTI2OiBGSUxF
OiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzMTY6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0
X2F0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
MTMwOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzMTk6CiteSWFiaV91bG9uZ15J
dGFyZ2V0X3N0X210aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1
c2UgdGFicwojMTM0OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzMjI6CiteSWFi
aV91bG9uZ15JdGFyZ2V0X3N0X2N0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3Vs
ZCBuZXZlciB1c2UgdGFicwojMTQzOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEz
Mzk6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2F0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQ2OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxf
ZGVmcy5oOjEzNDE6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X210aW1lX25zZWM7JAoKRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQ5OiBGSUxFOiBsaW51eC11c2Vy
L3N5c2NhbGxfZGVmcy5oOjEzNDM6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2N0aW1lX25zZWM7
JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTUzOiBGSUxFOiBs
aW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzNDY6CiteSWFiaV91bG9uZ15JX191bnVzZWQxWzJd
OyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE2MjogRklMRTog
bGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDoxMzc0OgorXkl1bnNpZ25lZCBpbnReSXRhcmdldF9z
dF9hdGltZV9uc2VjOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzE2NjogRklMRTogbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDoxMzc3OgorXkl1bnNpZ25lZCBp
bnReSXRhcmdldF9zdF9tdGltZV9uc2VjOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2
ZXIgdXNlIHRhYnMKIzE3MDogRklMRTogbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDoxMzgwOgor
Xkl1bnNpZ25lZCBpbnReSXRhcmdldF9zdF9jdGltZV9uc2VjOyQKCkVSUk9SOiBjb2RlIGluZGVu
dCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE3NDogRklMRTogbGludXgtdXNlci9zeXNjYWxsX2Rl
ZnMuaDoxMzgyOgorXkl1bnNpZ25lZCBpbnReSV9fdW51c2VkMTskCgpFUlJPUjogY29kZSBpbmRl
bnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxNzU6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbF9k
ZWZzLmg6MTM4MzoKK15JdW5zaWduZWQgaW50XklfX3VudXNlZDI7JAoKdG90YWw6IDE4IGVycm9y
cywgMCB3YXJuaW5ncywgMTIxIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBlY2FlN2VlMDBmNTUgKGxp
bnV4LXVzZXI6IFBhc3MgdGhyb3VnaCBuYW5vc2Vjb25kIHRpbWVzdGFtcCBjb21wb25lbnRzIGZv
ciBzdGF0IHN5c2NhbGxzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDUxNDE0NTM0Ni4yMDc1
OC0xLXdlbnNAa2VybmVsLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


