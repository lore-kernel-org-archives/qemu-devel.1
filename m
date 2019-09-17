Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C7C4CECE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D7C214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIdp-00072H-CW
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAIZm-0003RV-9t
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAIZi-0006JF-Pa
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:51:44 -0400
Resent-Date: Tue, 17 Sep 2019 14:51:44 -0400
Resent-Message-Id: <E1iAIZi-0006JF-Pa@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAIZg-0006DH-0K
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:51:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568746291; cv=none; d=zoho.com; s=zohoarc; 
 b=YpRVYN5CRPZJOoOVxRXpFcmBvC/oWRcFQJvUuauQ6stCbCfgllGrDRJFavC3FzTCjucTDgrmBAbTF3E9IWYu2xKlnAuW8lJMEQG4M65sh9ntoH4L8YROn0Kk0XdsYZCkcqY1+pxFJBE6QtwH6bS8ESBr8V0+9w2BtA7h49zmgm0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568746291;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=VT0whrIhmvyKLd/Ogi0OHLnJ/xWhDCYFV0Uzk4JUx8A=; 
 b=oJHNbUmyTan2AawkchwxXX04yMHZax+ABAGlHK02VxUf8Sk5ZV8eFLJc5zDvrFXLvEkx3CviQIsaCKeYFWkl7Z8bcBMxUw39lz/84aoBGkdbjV6Q7REvciwi+Ye5V903xp8Ghy++2YiXUQNAjJjBB68FmFWTKYpYv+jeDC2oBuY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568746289928754.6840902789916;
 Tue, 17 Sep 2019 11:51:29 -0700 (PDT)
In-Reply-To: <20190917122644.15736-1-johannes@sipsolutions.net>
Message-ID: <156874628889.17151.11608401473041040949@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: johannes@sipsolutions.net
Date: Tue, 17 Sep 2019 11:51:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [RFC] contrib: add vhost-user-sim
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
Cc: qemu-devel@nongnu.org, johannes.berg@intel.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNzEyMjY0NC4xNTcz
Ni0xLWpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUkZDXSBjb250cmliOiBh
ZGQgdmhvc3QtdXNlci1zaW0KTWVzc2FnZS1pZDogMjAxOTA5MTcxMjI2NDQuMTU3MzYtMS1qb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxOTA5MTcxMjI2NDQuMTU3MzYtMS1q
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0IC0+IHBhdGNoZXcvMjAxOTA5MTcxMjI2NDQuMTU3MzYt
MS1qb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKZTg5NzQ5NiBjb250cmliOiBhZGQgdmhvc3QtdXNlci1zaW0KCj09PSBPVVRQVVQgQkVHSU4g
PT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRB
SU5FUlMgbmVlZCB1cGRhdGluZz8KIzczOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyNTQ6IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1z
aW0vY2FsLmM6MTcwOgorICAgICAgICBpZiAocnVubmluZ19lbnRyeSAmJiBlbnRyeSAhPSBydW5u
aW5nX2VudHJ5ICYmIHJ1bm5pbmdfZW50cnktPnVwZGF0ZV91bnRpbCkgewoKRVJST1I6IGxpbmUg
b3ZlciA5MCBjaGFyYWN0ZXJzCiMyNTc6IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1zaW0vY2Fs
LmM6MTczOgorICAgICAgICAgICAgRFBSSU5UKCJ1cGRhdGUgJXMgdG8gYmUgZnJlZSB1bnRpbCAl
bGxkIChkdWUgdG8gYWRkIHVubGVzcyBvZiAlcylcbiIsIHJ1bm5pbmdfZW50cnktPm5hbWUsIG5l
eHR0aW1lLCBlbnRyeS0+bmFtZSk7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzI2
MDogRklMRTogY29udHJpYi92aG9zdC11c2VyLXNpbS9jYWwuYzoxNzY6CisgICAgICAgICAgICBE
UFJJTlQoIm5vIHVwZGF0ZSBmb3IgcnVubmluZyBlbnRyeSAlc1xuIiwgcnVubmluZ19lbnRyeSA/
IHJ1bm5pbmdfZW50cnktPm5hbWUgOiAiPG5vbmU+Iik7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNo
YXJhY3RlcnMKIzI3ODogRklMRTogY29udHJpYi92aG9zdC11c2VyLXNpbS9jYWwuYzoxOTQ6Cisg
ICAgICAgIERQUklOVCgidXBkYXRlICVzIHRvIGJlIGZyZWUgdW50aWwgJWxsZCAoZHVlIHRvIGFk
ZCBvZiAlcylcbiIsIHJ1bm5pbmdfZW50cnktPm5hbWUsIG5leHR0aW1lLCBlbnRyeS0+bmFtZSk7
CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzI4MTogRklMRTogY29udHJpYi92aG9z
dC11c2VyLXNpbS9jYWwuYzoxOTc6CisgICAgICAgIERQUklOVCgibm8gdXBkYXRlIGZvciBydW5u
aW5nIGVudHJ5ICVzXG4iLCBydW5uaW5nX2VudHJ5ID8gcnVubmluZ19lbnRyeS0+bmFtZSA6ICI8
bm9uZT4iKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM1MjU6IEZJTEU6IGNv
bnRyaWIvdmhvc3QtdXNlci1zaW0vbWFpbi5jOjk2OgorICAgICAgICAgICAgcHJpbnRmKCJVc2Fn
ZTogJXMgLXMgdGltZS1kZXZpY2Utc29ja2V0IFstbiBuZXQtZGV2aWNlLXNvY2tldF0gfCBbIC1o
IF1cbiIsCgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRo
aXMgc3RhdGVtZW50CiM1NDc6IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1zaW0vbWFpbi5jOjEx
ODoKKyAgICBpZiAobmV0X3NvY2tldCkKWy4uLl0KCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFj
dGVycwojNzQxOiBGSUxFOiBjb250cmliL3Zob3N0LXVzZXItc2ltL25ldC5jOjE1NjoKKyAgICBm
cHJpbnRmKHN0ZGVyciwgImluc2VydCBJUlEgZnJvbSAlcyBhdCAlbGxkXG4iLCBuZGV2LT5lbnRy
eS5uYW1lLCBjYWxlbmRhcl9nZXRfdGltZSgpKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFy
YWN0ZXJzCiM5NTE6IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1zaW0vc2ltdGltZS5jOjExNDoK
KyAgICAgICAgICAgIERQUklOVCgiICVkIHwgY2FsZW5kYXIgZW50cnkgYWRkZWQgZm9yICVsbGRc
biIsIGNvbm4tPmlkeCwgbXNnLT50aW1lKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzCiM5NTQ6IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1zaW0vc2ltdGltZS5jOjExNzoKKyAg
ICAgICAgICAgIERQUklOVCgiICVkIHwgY2FsZW5kYXIgZW50cnkgdGltZSB1cGRhdGVkIGZvciAl
bGxkXG4iLCBjb25uLT5pZHgsIG1zZy0+dGltZSk7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJh
Y3RlcnMKIzk4MDogRklMRTogY29udHJpYi92aG9zdC11c2VyLXNpbS9zaW10aW1lLmM6MTQzOgor
ICAgIGdfYXNzZXJ0KGZ1bGxfd3JpdGUoZ19pb19jaGFubmVsX3VuaXhfZ2V0X2ZkKGNvbm4tPmNo
YW4pLCAmcmVzcCwgc2l6ZW9mKHJlc3ApKSA9PSBzaXplb2YocmVzcCkpOwoKRVJST1I6IGxpbmUg
b3ZlciA5MCBjaGFyYWN0ZXJzCiM5ODE6IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1zaW0vc2lt
dGltZS5jOjE0NDoKKyAgICBEUFJJTlQoIiAlZCB8IHNlbnQgQUNLIGZvciBtZXNzYWdlICVzICgl
bGxkLCB0aW1lICVsbGQpXG4iLCBjb25uLT5pZHgsIHNpbXRpbWVfb3Bfc3RyKG1zZy0+b3ApLCBt
c2ctPm9wLCBtc2ctPnRpbWUpOwoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM5OTE6
IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1zaW0vc2ltdGltZS5jOjE1NDoKKyAgICBnX2Fzc2Vy
dChmdWxsX3dyaXRlKGdfaW9fY2hhbm5lbF91bml4X2dldF9mZChjb25uLT5jaGFuKSwgbXNnLCBz
aXplb2YoKm1zZykpID09IHNpemVvZigqbXNnKSk7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJh
Y3RlcnMKIzk5MzogRklMRTogY29udHJpYi92aG9zdC11c2VyLXNpbS9zaW10aW1lLmM6MTU2Ogor
ICAgICAgICBnX2Fzc2VydChmdWxsX3JlYWQoZ19pb19jaGFubmVsX3VuaXhfZ2V0X2ZkKGNvbm4t
PmNoYW4pLCBtc2csIHNpemVvZigqbXNnKSkgPT0gc2l6ZW9mKCptc2cpKTsKCkVSUk9SOiBicmFj
ZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzk5Njog
RklMRTogY29udHJpYi92aG9zdC11c2VyLXNpbS9zaW10aW1lLmM6MTU5OgorICAgICAgICBpZiAo
bXNnLT5vcCA9PSBVTV9USU1FVFJBVkVMX0FDSykKWy4uLl0KCkVSUk9SOiBsaW5lIG92ZXIgOTAg
Y2hhcmFjdGVycwojMTA0MzogRklMRTogY29udHJpYi92aG9zdC11c2VyLXNpbS9zaW10aW1lLmM6
MjA2OgorICAgICAgICBwcmludGYoImNsaWVudCBkaXNjb25uZWN0ZWQsIG1hZGUgJWxsZCByZXF1
ZXN0cyBhbmQgd2FpdGVkICVsbGQgdGltZXMsIHNlbnQgJWxsZCB1cGRhdGVzXG4iLAoKRVJST1I6
IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMxMDQ4OiBGSUxFOiBjb250cmliL3Zob3N0LXVz
ZXItc2ltL3NpbXRpbWUuYzoyMTE6CisgICAgICAgIC8vIGxlYWsgZm9yIG5vdyAuLi4gc291cmNl
IGlzIHN0aWxsIGF0dGFjaGVkCgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzEw
NDk6IEZJTEU6IGNvbnRyaWIvdmhvc3QtdXNlci1zaW0vc2ltdGltZS5jOjIxMjoKKyAgICAgICAg
Ly9nX2ZyZWUoY29ubik7Cgp0b3RhbDogMTQgZXJyb3JzLCA1IHdhcm5pbmdzLCAxMTI3IGxpbmVz
IGNoZWNrZWQKCkNvbW1pdCBlODk3NDk2OTJjYmEgKGNvbnRyaWI6IGFkZCB2aG9zdC11c2VyLXNp
bSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTcxMjI2NDQuMTU3MzYtMS1qb2hhbm5lc0Bz
aXBzb2x1dGlvbnMubmV0L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


