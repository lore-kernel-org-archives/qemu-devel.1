Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC3C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 23:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C692206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 23:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C692206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTZcZ-0002io-Ld
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 19:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTZbw-0002Fx-DU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 19:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTZao-0005Vl-PH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 19:25:55 -0400
Resent-Date: Tue, 28 Apr 2020 19:25:55 -0400
Resent-Message-Id: <E1jTZao-0005Vl-PH@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTZao-0005Qh-7y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 19:24:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588116271; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OPGQfcWckQQy7D/5gCfwJoh26jef68xVe1N/9ou7LKHDdcZoc+ibtvrGDa76n57gowdM3A2jP+3OZ7Jfgfq0AE5HANVdbOIsVt6G08+iaYfg7dea/hQ60DGzvMiT+6/5/m7uhpyspBwfmFPulmA4hF/6+QjLx6GXUKUevKd0Q4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588116271;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7v4SXQbJtqI3IPkXmA+nnvotJ3gPVB1XQK2K5Yy0hy4=; 
 b=kch3KH/TCPcsDH0Fv1A/RnctwgcTh2RzHOOLCSN+vUXeJpyqFcmVM5BGSKujwemBzBgbCWJCti64Lfwt2cqMORnpI3z+WmNiGEiGONxkkAVJMLt3YN34DDXBS2xOqfswphkiYEk9IoaIyrsAkGhJp+Op+2AjVXhn3cNY8JeW6AY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588116269891972.874255503441;
 Tue, 28 Apr 2020 16:24:29 -0700 (PDT)
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
Subject: Re: [PATCH 00/17] qom: Spring cleaning
Message-ID: <158811626862.2837.4221101658960408573@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 28 Apr 2020 16:24:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 19:24:42
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODE2MzQxOS40NDgz
LTEtYXJtYnJ1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwMC8xN10gcW9tOiBTcHJpbmcgY2xlYW5pbmcKTWVz
c2FnZS1pZDogMjAyMDA0MjgxNjM0MTkuNDQ4My0xLWFybWJydUByZWRoYXQuY29tClR5cGU6IHNl
cmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwoxZTdlNzllIHFvbTogRHJvcCBAZXJycCBwYXJhbWV0ZXIgb2Ygb2JqZWN0X3By
b3BlcnR5X2RlbCgpCjc4N2FiNjkgc3BhcHJfcGNpOiBEcm9wIHNvbWUgZGVhZCBlcnJvciBoYW5k
bGluZwo0YWUyMTA5IHFkZXY6IFVucmVhbGl6ZSBtdXN0IG5vdCBmYWlsCjMxZjA5MjEgRHJvcCBt
b3JlIEBlcnJwIHBhcmFtZXRlcnMgYWZ0ZXIgcHJldmlvdXMgY29tbWl0CjdhYjdhYTQgcW9tOiBE
cm9wIHBhcmFtZXRlciBAZXJycCBvZiBvYmplY3RfcHJvcGVydHlfYWRkKCkgJiBmcmllbmRzCjM0
MTNkOWIgcWRldjogQ2xlYW4gdXAgcWRldl9jb25uZWN0X2dwaW9fb3V0X25hbWVkKCkKYmJkZmQy
NCBody9hcm0vYmNtMjgzNTogRHJvcCBmdXRpbGUgYXR0ZW1wdHMgYXQgUU9NLWFkb3B0aW5nIG1l
bW9yeQo0YzAzYjkwIGUxMDAwOiBEb24ndCBydW4gZTEwMDBfaW5zdGFuY2VfaW5pdCgpIHR3aWNl
Cjc4YWI0Y2YgaHcvaXNhL3N1cGVyaW86IE1ha2UgdGhlIGNvbXBvbmVudHMgUU9NIGNoaWxkcmVu
CmRmOTg5MzEgczM5MHgvY3B1bW9kZWw6IEZpeCBVSSB0byBDUFUgZmVhdHVyZXMgcGNjLWNtYWMt
e2FlcywgZWFlc30tMjU2CjhmMjUyZDIgdGVzdHMvY2hlY2stcW9tLXByb3BsaXN0OiBJbXByb3Zl
IGl0ZXJhdG9yIGNvdmVyYWdlCmI0Zjc3ZGEgcW9tOiBEcm9wIG9iamVjdF9wcm9wZXJ0eV9zZXRf
ZGVzY3JpcHRpb24oKSBwYXJhbWV0ZXIgQGVycnAKOTkzMzc0ZSBxb206IE1ha2UgYWxsIHRoZSBv
YmplY3RfcHJvcGVydHlfYWRkX0ZPTygpIHJldHVybiB0aGUgcHJvcGVydHkKNGM2NjA2ZSBxb206
IENoYW5nZSBvYmplY3RfcHJvcGVydHlfZ2V0X3VpbnQxNkxpc3QoKSB0byBtYXRjaCBpdHMgZG9j
Cjc4ZWZhZDYgcW9tOiBEcm9wIG9iamVjdF9wcm9wZXJ0eV9kZWxfY2hpbGQoKSdzIHVudXNlZCBw
YXJhbWV0ZXIgQGVycnAKMTBjMjE1MSBxb206IENsZWFuIHVwIGluY29uc2lzdGVudCB1c2Ugb2Yg
Z2NoYXIgKiB2cy4gY2hhciAqCmE1ZDVlMzUgcW9tOiBDbGVhcmVyIHJlZmVyZW5jZSBjb3VudGlu
ZyBpbiBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZHYoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8x
NyBDaGVja2luZyBjb21taXQgYTVkNWUzNWY3NWIyIChxb206IENsZWFyZXIgcmVmZXJlbmNlIGNv
dW50aW5nIGluIG9iamVjdF9pbml0aWFsaXplX2NoaWxkdigpKQoyLzE3IENoZWNraW5nIGNvbW1p
dCAxMGMyMTUxZjU2MjEgKHFvbTogQ2xlYW4gdXAgaW5jb25zaXN0ZW50IHVzZSBvZiBnY2hhciAq
IHZzLiBjaGFyICopCjMvMTcgQ2hlY2tpbmcgY29tbWl0IDc4ZWZhZDY0YmQ5YSAocW9tOiBEcm9w
IG9iamVjdF9wcm9wZXJ0eV9kZWxfY2hpbGQoKSdzIHVudXNlZCBwYXJhbWV0ZXIgQGVycnApCjQv
MTcgQ2hlY2tpbmcgY29tbWl0IDRjNjYwNmU1NmQ3MCAocW9tOiBDaGFuZ2Ugb2JqZWN0X3Byb3Bl
cnR5X2dldF91aW50MTZMaXN0KCkgdG8gbWF0Y2ggaXRzIGRvYykKNS8xNyBDaGVja2luZyBjb21t
aXQgOTkzMzc0ZTFjYjUxIChxb206IE1ha2UgYWxsIHRoZSBvYmplY3RfcHJvcGVydHlfYWRkX0ZP
TygpIHJldHVybiB0aGUgcHJvcGVydHkpCjYvMTcgQ2hlY2tpbmcgY29tbWl0IGI0Zjc3ZGFhYjVm
OCAocW9tOiBEcm9wIG9iamVjdF9wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oKSBwYXJhbWV0ZXIg
QGVycnApCjcvMTcgQ2hlY2tpbmcgY29tbWl0IDhmMjUyZDIxMzFjNiAodGVzdHMvY2hlY2stcW9t
LXByb3BsaXN0OiBJbXByb3ZlIGl0ZXJhdG9yIGNvdmVyYWdlKQo4LzE3IENoZWNraW5nIGNvbW1p
dCBkZjk4OTMxNTQ1OTggKHMzOTB4L2NwdW1vZGVsOiBGaXggVUkgdG8gQ1BVIGZlYXR1cmVzIHBj
Yy1jbWFjLXthZXMsIGVhZXN9LTI1NikKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM1
NDogRklMRTogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJlc19kZWYuaW5jLmg6MzEzOgorREVGX0ZF
QVQoUENDX0NNQUNfQUVTXzI1NiwgInBjYy1jbWFjLWFlcy0yNTYiLCBQQ0MsIDIwLCAiUENDIENv
bXB1dGUtTGFzdC1CbG9jay1DTUFDLVVzaW5nLUFFUy0yNTYiKQoKdG90YWw6IDEgZXJyb3JzLCAw
IHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvMTcgaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KCjkvMTcgQ2hlY2tpbmcgY29tbWl0IDc4YWI0Y2Y5MWEzYiAoaHcvaXNhL3N1cGVy
aW86IE1ha2UgdGhlIGNvbXBvbmVudHMgUU9NIGNoaWxkcmVuKQoxMC8xNyBDaGVja2luZyBjb21t
aXQgNGMwM2I5MDk3MGQ4IChlMTAwMDogRG9uJ3QgcnVuIGUxMDAwX2luc3RhbmNlX2luaXQoKSB0
d2ljZSkKMTEvMTcgQ2hlY2tpbmcgY29tbWl0IGJiZGZkMjQ4NmY0NyAoaHcvYXJtL2JjbTI4MzU6
IERyb3AgZnV0aWxlIGF0dGVtcHRzIGF0IFFPTS1hZG9wdGluZyBtZW1vcnkpCjEyLzE3IENoZWNr
aW5nIGNvbW1pdCAzNDEzZDliN2Y0ZTcgKHFkZXY6IENsZWFuIHVwIHFkZXZfY29ubmVjdF9ncGlv
X291dF9uYW1lZCgpKQoxMy8xNyBDaGVja2luZyBjb21taXQgN2FiN2FhNDdhOTdkIChxb206IERy
b3AgcGFyYW1ldGVyIEBlcnJwIG9mIG9iamVjdF9wcm9wZXJ0eV9hZGQoKSAmIGZyaWVuZHMpCldB
Uk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMDc6IEZJTEU6IGJhY2tlbmRzL2hvc3Rt
ZW0tZmlsZS5jOjE4NzoKKyAgICAgICAgZmlsZV9tZW1vcnlfYmFja2VuZF9nZXRfZGlzY2FyZF9k
YXRhLCBmaWxlX21lbW9yeV9iYWNrZW5kX3NldF9kaXNjYXJkX2RhdGEpOwoKV0FSTklORzogbGlu
ZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzEwNzg6IEZJTEU6IGh3L2FybS9yYXNwaS5jOjI4NzoKKyAg
ICBvYmplY3RfcHJvcGVydHlfYWRkX2NvbnN0X2xpbmsoT0JKRUNUKCZzLT5zb2MpLCAicmFtIiwg
T0JKRUNUKG1hY2hpbmUtPnJhbSkpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMK
IzMwODQ6IEZJTEU6IGh3L3BwYy9zcGFwci5jOjMzNDY6CisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZzcGFwci0+a2VybmVsX2FkZHIsIE9CSl9QUk9QX0ZMQUdfUkVBRFdSSVRF
KTsKCnRvdGFsOiAwIGVycm9ycywgMyB3YXJuaW5ncywgNDQ1NyBsaW5lcyBjaGVja2VkCgpQYXRj
aCAxMy8xNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoxNC8xNyBDaGVja2luZyBjb21taXQg
MzFmMDkyMTRlNTI5IChEcm9wIG1vcmUgQGVycnAgcGFyYW1ldGVycyBhZnRlciBwcmV2aW91cyBj
b21taXQpCjE1LzE3IENoZWNraW5nIGNvbW1pdCA0YWUyMTA5MGFhYTYgKHFkZXY6IFVucmVhbGl6
ZSBtdXN0IG5vdCBmYWlsKQoxNi8xNyBDaGVja2luZyBjb21taXQgNzg3YWI2OTkxZjcxIChzcGFw
cl9wY2k6IERyb3Agc29tZSBkZWFkIGVycm9yIGhhbmRsaW5nKQoxNy8xNyBDaGVja2luZyBjb21t
aXQgMWU3ZTc5ZTE0ZTI3IChxb206IERyb3AgQGVycnAgcGFyYW1ldGVyIG9mIG9iamVjdF9wcm9w
ZXJ0eV9kZWwoKSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAyMDA0MjgxNjM0MTkuNDQ4My0xLWFybWJydUByZWRoYXQuY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

