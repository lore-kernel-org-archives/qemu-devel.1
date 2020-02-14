Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D5BC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D621222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D621222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hKz-00087j-B9
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j2hJS-0005i5-LZ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j2hJQ-000285-Pc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:11:46 -0500
Resent-Date: Fri, 14 Feb 2020 15:11:46 -0500
Resent-Message-Id: <E1j2hJQ-000285-Pc@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j2hJQ-00025e-JA
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:11:44 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581711100; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iH5bHLIWOSHPYojQP3gXOFPWyoqAKnDzD1Pgfj00M0CYycGuH5CdjQZNmcM/MztSka5z97U7+/7sJIC+4SkTXWXi44vNfxMDHMJ7D+bkgdQt3qV0zT0pp2CE4U+/U/4oWd44vJ+uWR8SR8a4M2JJkFM6K+w0OweZAMQ98qT36e0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581711100;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=0ssgUEWH+KJ7j2FqqYk/92KicNVsRn6CoA91KG7eXEA=; 
 b=fz/+T1FqHpls/ZcZycYlrd1wI3mHGLgCY7nYGdU8UwFLHRXM1oKFY2YqV2o8RIkmNyqbkOxbMrwqzPXQO3uNj2smB8IJpQzFVU9r4eyDiIH/0Mx3Mz2QDCIxBj5gQEeW/wx4CiFU9ibbspxEgK0SKiOkVy7MPAnMeCfnNtEtjDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581711097193274.1693096627207;
 Fri, 14 Feb 2020 12:11:37 -0800 (PST)
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
Subject: Re: [PATCH 00/19] target/arm: vfp feature and decodetree cleanup
Message-ID: <158171109601.6932.15086229183785710630@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 14 Feb 2020 12:11:37 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxNDE4MTU0Ny4yMTQw
OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwMC8xOV0gdGFyZ2V0L2FybTog
dmZwIGZlYXR1cmUgYW5kIGRlY29kZXRyZWUgY2xlYW51cApNZXNzYWdlLWlkOiAyMDIwMDIxNDE4
MTU0Ny4yMTQwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKVHlwZTogc2VyaWVzCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIw
MDIxNDE4MTU0Ny4yMTQwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0Y2hl
dy8yMDIwMDIxNDE4MTU0Ny4yMTQwOC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5NTc4M2IwIHRhcmdldC9hcm06IFNwbGl0IFZN
SU5NQVhOTSBkZWNvZGUKNzY3NTM4YiB0YXJnZXQvYXJtOiBTcGxpdCBWRk0gZGVjb2RlCmY0MmRm
NGQgdGFyZ2V0L2FybTogQWRkIGZvcm1hdHMgZm9yIHNvbWUgdmZwIDIgYW5kIDMtcmVnaXN0ZXIg
aW5zbnMKN2FiNjdiYiB0YXJnZXQvYXJtOiBSZW1vdmUgQVJNX0ZFQVRVUkVfVkZQKgoxNjY2YWQ5
IGxpbnV4LXVzZXIvYXJtOiBSZXBsYWNlIEFSTV9GRUFUVVJFX1ZGUCogdGVzdHMgZm9yIEhXQ0FQ
CjY1ZmY4MDkgdGFyZ2V0L2FybTogTW92ZSB0aGUgdmZwIGRlY29kZXRyZWUgY2FsbHMgbmV4dCB0
byB0aGUgYmFzZSBpc2EKODY5YTBjNiB0YXJnZXQvYXJtOiBNb3ZlIFZMTERNIGFuZCBWTFNUTSB0
byB2ZnAuZGVjb2RlCjVmNDQ5M2UgdGFyZ2V0L2FybTogUmVtb3ZlIEFSTV9GRUFUVVJFX1ZGUCBj
aGVjayBmcm9tIGRpc2FzX3ZmcF9pbnNuCjRkZTk2NzggdGFyZ2V0L2FybTogUmVwbGFjZSBBUk1f
RkVBVFVSRV9WRlA0IHdpdGggaXNhcl9mZWF0dXJlX2FhMzJfc2ltZGZtYWMKMThlM2E0NSB0YXJn
ZXQvYXJtOiBBZGQgbWlzc2luZyBjaGVja3MgZm9yIGZwc3BfdjIKNzMwODAwOSB0YXJnZXQvYXJt
OiBSZXBsYWNlIEFSTV9GRUFUVVJFX1ZGUDMgY2hlY2tzIHdpdGggZnB7c3AsIGRwfV92Mwo5YTE0
ODk4IHRhcmdldC9hcm06IFBlcmZvcm0gZnBkcF92MiBjaGVjayBmaXJzdApjZjBkNGRkIHRhcmdl
dC9hcm06IEFkZCBpc2FyX2ZlYXR1cmVfYWEzMl97ZnBzcF92MiwgZnBzcF92MywgZnBkcF92M30K
ZWUzNzgxZCB0YXJnZXQvYXJtOiBSZW5hbWUgaXNhcl9mZWF0dXJlX2FhMzJfZnBkcF92MgowNjIw
ZmYxIHRhcmdldC9hcm06IEFkZCBpc2FyX2ZlYXR1cmVfYWEzMl9zaW1kX3IxNgpjNGE0NjE1IHRh
cmdldC9hcm06IFNldCBNVkZSMC5GUFNQIGZvciBBUk12NSBjcHVzCjBhZDZkYTAgdGFyZ2V0L2Fy
bTogVXNlIGlzYXJfZmVhdHVyZV9hYTMyX3NpbWRfcjMyIG1vcmUgcGxhY2VzCmVhNTgwOTEgdGFy
Z2V0L2FybTogUmVuYW1lIGlzYXJfZmVhdHVyZV9hYTMyX3NpbWRfcjMyCmZkYWJmODkgdGFyZ2V0
L2FybTogRml4IGZpZWxkIGV4dHJhY3QgZnJvbSBNVkZSWzAtMl0KCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvMTkgQ2hlY2tpbmcgY29tbWl0IGZkYWJmODk2ZWRiOSAodGFyZ2V0L2FybTogRml4IGZp
ZWxkIGV4dHJhY3QgZnJvbSBNVkZSWzAtMl0pCjIvMTkgQ2hlY2tpbmcgY29tbWl0IGVhNTgwOTE3
M2ZkNyAodGFyZ2V0L2FybTogUmVuYW1lIGlzYXJfZmVhdHVyZV9hYTMyX3NpbWRfcjMyKQpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTQzOiBGSUxFOiB0YXJnZXQvYXJtL3RyYW5z
bGF0ZS12ZnAuaW5jLmM6MTgyNToKKyAgICBpZiAoIWRjX2lzYXJfZmVhdHVyZShhYTMyX3NpbWRf
cjMyLCBzKSAmJiAoKGEtPnZkIHwgYS0+dm4gfCBhLT52bSkgJiAweDEwKSkgewoKdG90YWw6IDAg
ZXJyb3JzLCAxIHdhcm5pbmdzLCAyMTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xOSBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgozLzE5IENoZWNraW5nIGNvbW1pdCAwYWQ2ZGEwMWJiMTcgKHRh
cmdldC9hcm06IFVzZSBpc2FyX2ZlYXR1cmVfYWEzMl9zaW1kX3IzMiBtb3JlIHBsYWNlcykKNC8x
OSBDaGVja2luZyBjb21taXQgYzRhNDYxNTYzMWQwICh0YXJnZXQvYXJtOiBTZXQgTVZGUjAuRlBT
UCBmb3IgQVJNdjUgY3B1cykKNS8xOSBDaGVja2luZyBjb21taXQgMDYyMGZmMWVlYWRmICh0YXJn
ZXQvYXJtOiBBZGQgaXNhcl9mZWF0dXJlX2FhMzJfc2ltZF9yMTYpCjYvMTkgQ2hlY2tpbmcgY29t
bWl0IGVlMzc4MWQ4N2QzNyAodGFyZ2V0L2FybTogUmVuYW1lIGlzYXJfZmVhdHVyZV9hYTMyX2Zw
ZHBfdjIpCjcvMTkgQ2hlY2tpbmcgY29tbWl0IGNmMGQ0ZGQ3MmJjMSAodGFyZ2V0L2FybTogQWRk
IGlzYXJfZmVhdHVyZV9hYTMyX3tmcHNwX3YyLCBmcHNwX3YzLCBmcGRwX3YzfSkKOC8xOSBDaGVj
a2luZyBjb21taXQgOWExNDg5OGFmY2UxICh0YXJnZXQvYXJtOiBQZXJmb3JtIGZwZHBfdjIgY2hl
Y2sgZmlyc3QpCjkvMTkgQ2hlY2tpbmcgY29tbWl0IDczMDgwMDkwNzhjNyAodGFyZ2V0L2FybTog
UmVwbGFjZSBBUk1fRkVBVFVSRV9WRlAzIGNoZWNrcyB3aXRoIGZwe3NwLCBkcH1fdjMpCjEwLzE5
IENoZWNraW5nIGNvbW1pdCAxOGUzYTQ1NGM4MmEgKHRhcmdldC9hcm06IEFkZCBtaXNzaW5nIGNo
ZWNrcyBmb3IgZnBzcF92MikKMTEvMTkgQ2hlY2tpbmcgY29tbWl0IDRkZTk2Nzg0MDc2OSAodGFy
Z2V0L2FybTogUmVwbGFjZSBBUk1fRkVBVFVSRV9WRlA0IHdpdGggaXNhcl9mZWF0dXJlX2FhMzJf
c2ltZGZtYWMpCjEyLzE5IENoZWNraW5nIGNvbW1pdCA1ZjQ0OTNlMDEwMzMgKHRhcmdldC9hcm06
IFJlbW92ZSBBUk1fRkVBVFVSRV9WRlAgY2hlY2sgZnJvbSBkaXNhc192ZnBfaW5zbikKMTMvMTkg
Q2hlY2tpbmcgY29tbWl0IDg2OWEwYzZlYTNjOSAodGFyZ2V0L2FybTogTW92ZSBWTExETSBhbmQg
VkxTVE0gdG8gdmZwLmRlY29kZSkKMTQvMTkgQ2hlY2tpbmcgY29tbWl0IDY1ZmY4MDk4NTNkYiAo
dGFyZ2V0L2FybTogTW92ZSB0aGUgdmZwIGRlY29kZXRyZWUgY2FsbHMgbmV4dCB0byB0aGUgYmFz
ZSBpc2EpCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMxMDY6IEZJTEU6IHRhcmdldC9hcm0v
dHJhbnNsYXRlLmM6MTA2NjM6CisgICAgICogTm90ZSBkaXNhc192ZnAgaXMgd3JpdHRlbiBmb3Ig
YTMyIHdpdGggY29uZCBmaWVsZCBpbiB0aGUgJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAxMjggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTQvMTkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCjE1LzE5IENoZWNraW5nIGNvbW1pdCAxNjY2YWQ5ZWQxZTIgKGxpbnV4LXVzZXIvYXJtOiBS
ZXBsYWNlIEFSTV9GRUFUVVJFX1ZGUCogdGVzdHMgZm9yIEhXQ0FQKQoxNi8xOSBDaGVja2luZyBj
b21taXQgN2FiNjdiYmU2MzQ1ICh0YXJnZXQvYXJtOiBSZW1vdmUgQVJNX0ZFQVRVUkVfVkZQKikK
MTcvMTkgQ2hlY2tpbmcgY29tbWl0IGY0MmRmNGQxZjFhYSAodGFyZ2V0L2FybTogQWRkIGZvcm1h
dHMgZm9yIHNvbWUgdmZwIDIgYW5kIDMtcmVnaXN0ZXIgaW5zbnMpCjE4LzE5IENoZWNraW5nIGNv
bW1pdCA3Njc1MzhiYTdhZTAgKHRhcmdldC9hcm06IFNwbGl0IFZGTSBkZWNvZGUpCjE5LzE5IENo
ZWNraW5nIGNvbW1pdCA5NTc4M2IwYjRmZDAgKHRhcmdldC9hcm06IFNwbGl0IFZNSU5NQVhOTSBk
ZWNvZGUpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwMjE0MTgxNTQ3LjIxNDA4LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

