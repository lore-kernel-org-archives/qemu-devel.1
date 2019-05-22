Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43559C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C4D20862
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C4D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTULn-0007oU-9t
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:44:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hTUL2-0007VJ-NW
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hTUL1-0005Lt-Ej
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:43:36 -0400
Resent-Date: Wed, 22 May 2019 12:43:36 -0400
Resent-Message-Id: <E1hTUL1-0005Lt-Ej@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hTUL1-0005G0-6q
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:43:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558540636; cv=none; d=zoho.com; s=zohoarc; 
	b=fy3YqKhlM7Vu2NzkNNkY8usjhLyyIksLJoJvUmPdAqxTTpJA546WDR/ma9y8RG4HjwZGNTaoI0bRV7b9HZDXrJuiHdpYRidBAFpbw6RrCBD0Px3vwHEMn0y/TzSi61VQqM0QdPfxisP5XFo93GodKP5x9KFg5IT+n+uhNUVruwg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558540636;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=kB79zWPs7sQMij3ORY90muyHQtzvaIVi15w25jXetK0=; 
	b=CxBC4uNxia7xPYhF8VY9rq7mJI/OmRUtT+vzQAdOS6osys2XtG697WJV2dbbLvw+38mDZaItdXd4ppRzzR4wBmBsKDca/k5Ykze2+VZxJDh1VwxUPHWDY/UiLUWf5MoOi4Kc162fgdTCJbFq9YfSbbPrFwmMj7QjL67/7NdUFUY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558540630970161.018057671782;
	Wed, 22 May 2019 08:57:10 -0700 (PDT)
In-Reply-To: <20190522153631.17152-1-wens@kernel.org>
Message-ID: <155854062960.24.17656832404160415256@549697c9ad12>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: wens@kernel.org
Date: Wed, 22 May 2019 08:57:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Pass through nanosecond
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, wens@kernel.org,
	laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyMjE1MzYzMS4xNzE1
Mi0xLXdlbnNAa2VybmVsLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA1MjIxNTM2MzEuMTcxNTItMS13ZW5zQGtlcm5lbC5v
cmcKVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjJdIGxpbnV4LXVz
ZXI6IFBhc3MgdGhyb3VnaCBuYW5vc2Vjb25kIHRpbWVzdGFtcCBjb21wb25lbnRzIGZvciBzdGF0
IHN5c2NhbGxzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYt
cGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRj
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRw
czovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAg
ICAgICAgcGF0Y2hldy8yMDE5MDUyMjE1MzYzMS4xNzE1Mi0xLXdlbnNAa2VybmVsLm9yZyAtPiBw
YXRjaGV3LzIwMTkwNTIyMTUzNjMxLjE3MTUyLTEtd2Vuc0BrZXJuZWwub3JnClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKMGFlMDNhZjNmOSBsaW51eC11c2VyOiBQYXNzIHRocm91Z2gg
bmFub3NlY29uZCB0aW1lc3RhbXAgY29tcG9uZW50cyBmb3Igc3RhdCBzeXNjYWxscwoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
MTA0OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjExOTc6CiteSWFiaV91bG9uZyAg
dGFyZ2V0X3N0X2F0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1
c2UgdGFicwojMTA3OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjExOTk6CiteSWFi
aV91bG9uZyAgdGFyZ2V0X3N0X210aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3Vs
ZCBuZXZlciB1c2UgdGFicwojMTEwOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEy
MDE6CiteSWFiaV91bG9uZyAgdGFyZ2V0X3N0X2N0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTE5OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxf
ZGVmcy5oOjEyMzM6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2F0aW1lX25zZWM7JAoKRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTIzOiBGSUxFOiBsaW51eC11c2Vy
L3N5c2NhbGxfZGVmcy5oOjEyMzY6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X210aW1lX25zZWM7
JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTI3OiBGSUxFOiBs
aW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEyMzk6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2N0
aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTM2
OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzMTg6CiteSWFiaV91bG9uZ15JdGFy
Z2V0X3N0X2F0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2Ug
dGFicwojMTQwOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzMjE6CiteSWFiaV91
bG9uZ15JdGFyZ2V0X3N0X210aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBu
ZXZlciB1c2UgdGFicwojMTQ0OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzMjQ6
CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2N0aW1lX25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50
IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTYwOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVm
cy5oOjEzNDI6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2F0aW1lX25zZWM7JAoKRVJST1I6IGNv
ZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTYzOiBGSUxFOiBsaW51eC11c2VyL3N5
c2NhbGxfZGVmcy5oOjEzNDQ6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X210aW1lX25zZWM7JAoK
RVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTY2OiBGSUxFOiBsaW51
eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzNDY6CiteSWFiaV91bG9uZ15JdGFyZ2V0X3N0X2N0aW1l
X25zZWM7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTcwOiBG
SUxFOiBsaW51eC11c2VyL3N5c2NhbGxfZGVmcy5oOjEzNDk6CiteSWFiaV91bG9uZ15JX191bnVz
ZWQxWzJdOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE3OTog
RklMRTogbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDoxMzc3OgorXkl1bnNpZ25lZCBpbnReSXRh
cmdldF9zdF9hdGltZV9uc2VjOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNl
IHRhYnMKIzE4MzogRklMRTogbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDoxMzgwOgorXkl1bnNp
Z25lZCBpbnReSXRhcmdldF9zdF9tdGltZV9uc2VjOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzE4NzogRklMRTogbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDox
MzgzOgorXkl1bnNpZ25lZCBpbnReSXRhcmdldF9zdF9jdGltZV9uc2VjOyQKCkVSUk9SOiBjb2Rl
IGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE5MTogRklMRTogbGludXgtdXNlci9zeXNj
YWxsX2RlZnMuaDoxMzg1OgorXkl1bnNpZ25lZCBpbnReSV9fdW51c2VkMTskCgpFUlJPUjogY29k
ZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxOTI6IEZJTEU6IGxpbnV4LXVzZXIvc3lz
Y2FsbF9kZWZzLmg6MTM4NjoKK15JdW5zaWduZWQgaW50XklfX3VudXNlZDI7JAoKdG90YWw6IDE4
IGVycm9ycywgMCB3YXJuaW5ncywgMjExIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAwYWUwM2FmM2Y5
N2YgKGxpbnV4LXVzZXI6IFBhc3MgdGhyb3VnaCBuYW5vc2Vjb25kIHRpbWVzdGFtcCBjb21wb25l
bnRzIGZvciBzdGF0IHN5c2NhbGxzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VU
UFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDUyMjE1MzYz
MS4xNzE1Mi0xLXdlbnNAa2VybmVsLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=


