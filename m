Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BCC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 06:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A6D20787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 06:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A6D20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUP1P-0004rU-3u
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 02:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUP0X-0003uY-8V
 for qemu-devel@nongnu.org; Fri, 01 May 2020 02:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUP0V-0006Pg-6z
 for qemu-devel@nongnu.org; Fri, 01 May 2020 02:18:44 -0400
Resent-Date: Fri, 01 May 2020 02:18:44 -0400
Resent-Message-Id: <E1jUP0V-0006Pg-6z@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUP0U-0006KL-Cr
 for qemu-devel@nongnu.org; Fri, 01 May 2020 02:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588313913; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ipWE4UFwB/6cnfcZbn3gXrU4DXcJ642PsZRDu3Z1GaWBpkQFtATu1WKABKCUyG/ykW3gdYzcnmfM8DJRP0bCQ7CukHjyuqAR5LE/dJ8yeFWNblZ1QDYVVgwt5DdpQKJoN6pAaso2xnGgoKSceTbv3EaCVPiNTLIlWDj4chqFskY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588313913;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=3VvRInZiDsVB9xccf5ByeC5Kd8dPoVT+2nGzwM3MKaQ=; 
 b=fpRHRoKKxMhbj3JPokR9dnv5EXIN0zbnMJ/Vdpu6vZxU2997ThL2ofUskS11PP4SNuHgLxANT3h/St3sZeLCcJInAvYnbqqTs94JLUpBIQjL+cqMAz0oM7IXBmBRYz7fCO8/SXpHcAhltEabfBBvEHwf7miRbWBPWBAZJe0Vn7I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588313912256211.82271618520565;
 Thu, 30 Apr 2020 23:18:32 -0700 (PDT)
Message-ID: <158831391108.4471.12018880508086572519@45ef0f9c86ae>
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v4 00/18] target/arm: sve load/store improvements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Thu, 30 Apr 2020 23:18:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 02:18:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQzMDE2MjgxMy4xNzY3
MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNDMwMTYyODEzLjE3NjcxLTEt
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFUQ0ggdjQgMDAvMThdIHRh
cmdldC9hcm06IHN2ZSBsb2FkL3N0b3JlIGltcHJvdmVtZW50cwpUeXBlOiBzZXJpZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
ODJlZTI3MCB0YXJnZXQvYXJtOiBSZW1vdmUgc3ZlX21lbW9waWR4CmZhYjljNDAgdGFyZ2V0L2Fy
bTogUmV1c2Ugc3ZlX3Byb2JlX3BhZ2UgZm9yIGdhdGhlciBsb2FkcwpmNzBiYjc3IHRhcmdldC9h
cm06IFJldXNlIHN2ZV9wcm9iZV9wYWdlIGZvciBzY2F0dGVyIHN0b3Jlcwo0ZTU5NmRjIHRhcmdl
dC9hcm06IFJldXNlIHN2ZV9wcm9iZV9wYWdlIGZvciBnYXRoZXIgZmlyc3QtZmF1bHQgbG9hZHMK
NDY4YTY3ZiB0YXJnZXQvYXJtOiBVc2UgU1ZFQ29udExkU3QgZm9yIGNvbnRpZ3VvdXMgc3RvcmVz
CjlhMDQ3OGMgdGFyZ2V0L2FybTogVXBkYXRlIGNvbnRpZ3VvdXMgZmlyc3QtZmF1bHQgYW5kIG5v
LWZhdWx0IGxvYWRzCjkxOGY2ZjQgdGFyZ2V0L2FybTogVXNlIFNWRUNvbnRMZFN0IGZvciBtdWx0
aS1yZWdpc3RlciBjb250aWd1b3VzIGxvYWRzCmQ5NTExYjAgdGFyZ2V0L2FybTogSGFuZGxlIHdh
dGNocG9pbnRzIGluIHN2ZV9sZDFfcgpjNzlhZjk2IHRhcmdldC9hcm06IFVzZSBTVkVDb250TGRT
dCBpbiBzdmVfbGQxX3IKZTZjMTU0YSB0YXJnZXQvYXJtOiBBZGp1c3QgaW50ZXJmYWNlIG9mIHN2
ZV9sZDFfaG9zdF9mbgpiNDIxN2VjIHRhcmdldC9hcm06IEFkZCBzdmUgaW5mcmFzdHJ1Y3R1cmUg
Zm9yIHBhZ2UgbG9va3VwCjM0NjlkOTkgdGFyZ2V0L2FybTogRHJvcCBtYW51YWwgaGFuZGxpbmcg
b2Ygc2V0L2NsZWFyX2hlbHBlcl9yZXRhZGRyCjU5MTAzNDcgdGFyZ2V0L2FybTogVXNlIGNwdV8q
X2RhdGFfcmEgZm9yIHN2ZV9sZHN0X3RsYl9mbgphMGQ0NDIzIGFjY2VsL3RjZzogQWRkIGVuZGlh
bi1zcGVjaWZpYyBjcHVfe2xkLCBzdH0qIG9wZXJhdGlvbnMKMGI4NDI5NyBhY2NlbC90Y2c6IEFk
ZCBwcm9iZV9hY2Nlc3NfZmxhZ3MKYWM3YjNmYiBhY2NlbC90Y2c6IEFkZCBibG9jayBjb21tZW50
IGZvciBwcm9iZV9hY2Nlc3MKMDBhOWVjMCBleGVjOiBGaXggY3B1X3dhdGNocG9pbnRfYWRkcmVz
c19tYXRjaGVzIGFkZHJlc3MgbGVuZ3RoCjEwY2Q2NTAgZXhlYzogQWRkIGJsb2NrIGNvbW1lbnRz
IGZvciB3YXRjaHBvaW50IHJvdXRpbmVzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzE4IENoZWNr
aW5nIGNvbW1pdCAxMGNkNjUwN2U3NGEgKGV4ZWM6IEFkZCBibG9jayBjb21tZW50cyBmb3Igd2F0
Y2hwb2ludCByb3V0aW5lcykKMi8xOCBDaGVja2luZyBjb21taXQgMDBhOWVjMDAyNmM1IChleGVj
OiBGaXggY3B1X3dhdGNocG9pbnRfYWRkcmVzc19tYXRjaGVzIGFkZHJlc3MgbGVuZ3RoKQozLzE4
IENoZWNraW5nIGNvbW1pdCBhYzdiM2ZiZGViNjEgKGFjY2VsL3RjZzogQWRkIGJsb2NrIGNvbW1l
bnQgZm9yIHByb2JlX2FjY2VzcykKNC8xOCBDaGVja2luZyBjb21taXQgMGI4NDI5NzY1MzdiIChh
Y2NlbC90Y2c6IEFkZCBwcm9iZV9hY2Nlc3NfZmxhZ3MpCjUvMTggQ2hlY2tpbmcgY29tbWl0IGEw
ZDQ0MjNmNTRkMyAoYWNjZWwvdGNnOiBBZGQgZW5kaWFuLXNwZWNpZmljIGNwdV97bGQsIHN0fSog
b3BlcmF0aW9ucykKNi8xOCBDaGVja2luZyBjb21taXQgNTkxMDM0NzIyMjJmICh0YXJnZXQvYXJt
OiBVc2UgY3B1XypfZGF0YV9yYSBmb3Igc3ZlX2xkc3RfdGxiX2ZuKQpFUlJPUjogc3BhY2VzIHJl
cXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4OlZ4VikKIzYzOiBGSUxFOiB0YXJnZXQvYXJtL3N2
ZV9oZWxwZXIuYzo0MDI5OgorICAgIFRMQihlbnYsIGFkZHIsIChUWVBFTSkqKFRZUEVFICopKHZk
ICsgSChyZWdfb2ZmKSksIHJhKTsgICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpX
eFYpCiMxNTM6IEZJTEU6IHRhcmdldC9hcm0vc3ZlX2hlbHBlci5jOjQxNjI6CisgICAgICAgICAg
ICAgICAgICAgICAgc3ZlX2xkc3QxX3RsYl9mbiAqdGxiX2ZuKQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA0NTUg
bGluZXMgY2hlY2tlZAoKUGF0Y2ggNi8xOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNy8x
OCBDaGVja2luZyBjb21taXQgMzQ2OWQ5OWQwZDk0ICh0YXJnZXQvYXJtOiBEcm9wIG1hbnVhbCBo
YW5kbGluZyBvZiBzZXQvY2xlYXJfaGVscGVyX3JldGFkZHIpCjgvMTggQ2hlY2tpbmcgY29tbWl0
IGI0MjE3ZWM0Nzc5YSAodGFyZ2V0L2FybTogQWRkIHN2ZSBpbmZyYXN0cnVjdHVyZSBmb3IgcGFn
ZSBsb29rdXApCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBz
ZXBhcmF0ZSBsaW5lCiMzMjogRklMRTogdGFyZ2V0L2FybS9zdmVfaGVscGVyLmM6MTYzMzoKKy8q
IEJpZy1lbmRpYW4gaG9zdHMgbmVlZCB0byBmcm9iIHRoZSBieXRlIGluZGljZXMuICBJZiB0aGUg
Y29weQoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAyODEgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggOC8xOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo5LzE4IENoZWNraW5nIGNvbW1pdCBl
NmMxNTRhODJlODMgKHRhcmdldC9hcm06IEFkanVzdCBpbnRlcmZhY2Ugb2Ygc3ZlX2xkMV9ob3N0
X2ZuKQoxMC8xOCBDaGVja2luZyBjb21taXQgYzc5YWY5NjEzZWM1ICh0YXJnZXQvYXJtOiBVc2Ug
U1ZFQ29udExkU3QgaW4gc3ZlX2xkMV9yKQoxMS8xOCBDaGVja2luZyBjb21taXQgZDk1MTFiMDRh
YjZhICh0YXJnZXQvYXJtOiBIYW5kbGUgd2F0Y2hwb2ludHMgaW4gc3ZlX2xkMV9yKQoxMi8xOCBD
aGVja2luZyBjb21taXQgOTE4ZjZmNDc4YTZmICh0YXJnZXQvYXJtOiBVc2UgU1ZFQ29udExkU3Qg
Zm9yIG11bHRpLXJlZ2lzdGVyIGNvbnRpZ3VvdXMgbG9hZHMpCjEzLzE4IENoZWNraW5nIGNvbW1p
dCA5YTA0NzhjM2E1ZTYgKHRhcmdldC9hcm06IFVwZGF0ZSBjb250aWd1b3VzIGZpcnN0LWZhdWx0
IGFuZCBuby1mYXVsdCBsb2FkcykKMTQvMTggQ2hlY2tpbmcgY29tbWl0IDQ2OGE2N2YyYjBmZiAo
dGFyZ2V0L2FybTogVXNlIFNWRUNvbnRMZFN0IGZvciBjb250aWd1b3VzIHN0b3JlcykKMTUvMTgg
Q2hlY2tpbmcgY29tbWl0IDRlNTk2ZGMyYWUxYSAodGFyZ2V0L2FybTogUmV1c2Ugc3ZlX3Byb2Jl
X3BhZ2UgZm9yIGdhdGhlciBmaXJzdC1mYXVsdCBsb2FkcykKMTYvMTggQ2hlY2tpbmcgY29tbWl0
IGY3MGJiNzcxZmY2NiAodGFyZ2V0L2FybTogUmV1c2Ugc3ZlX3Byb2JlX3BhZ2UgZm9yIHNjYXR0
ZXIgc3RvcmVzKQoxNy8xOCBDaGVja2luZyBjb21taXQgZmFiOWM0MDRlNWQ4ICh0YXJnZXQvYXJt
OiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3IgZ2F0aGVyIGxvYWRzKQoxOC8xOCBDaGVja2luZyBj
b21taXQgODJlZTI3MDE4Y2Q3ICh0YXJnZXQvYXJtOiBSZW1vdmUgc3ZlX21lbW9waWR4KQo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQzMDE2
MjgxMy4xNzY3MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3Bh
dGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

