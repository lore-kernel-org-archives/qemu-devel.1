Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D72C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800ED206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800ED206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW2O4-0004Pc-L8
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 14:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW2NL-0003yz-9N
 for qemu-devel@nongnu.org; Tue, 05 May 2020 14:33:03 -0400
Resent-Date: Tue, 05 May 2020 14:33:03 -0400
Resent-Message-Id: <E1jW2NL-0003yz-9N@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW2NJ-0003bk-BI
 for qemu-devel@nongnu.org; Tue, 05 May 2020 14:33:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588703574; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BClUlkx2aAUSjmhTHISdh+4+ZTxxuoZdMaAGCMEz7f04kYcso/51S+sf5Y9H32xZYn9kK7idddeILOI9NeNX7sIPrSdbkvN/OM8C6M7J+wD/Jn8WscnzpkwwsajeK+lsi9mEzHnmDk1retuIC7OzI3PtoyIXhlgC5+FucDekQY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588703574;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5ing0lhS+DpO4y4F82bacvCgdFEUYVD5JO8M/4UnTBo=; 
 b=gS2eGm8vxGbok7x8AYtIHNgRtKARgr1ccbQsKWNnJY2hed93LBsmDj0fF2B+ErwjVRsk8slRwknGGMqdqJLY18IYo+sUQInVQQ7FnFr7m4Hv+/4fsLcts+zZYQ3ZRGaHbqI95MkluWWDFUN1sLY/TN0eRmak6y6wy6oKxldD/dM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588703571889856.7667314361587;
 Tue, 5 May 2020 11:32:51 -0700 (PDT)
Message-ID: <158870357054.24779.1839489973484972276@45ef0f9c86ae>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
Subject: Re: [PATCH v2 00/18] qom: Spring cleaning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 5 May 2020 11:32:51 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:41:33
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
Cc: pbonzini@redhat.com, philmd@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNTE1MjkyNi4xODg3
Ny0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUwNTE1MjkyNi4xODg3Ny0xLWFybWJydUByZWRo
YXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwMC8xOF0gcW9tOiBTcHJpbmcgY2xlYW5pbmcKVHlw
ZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYt
cGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRj
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3
LzIwMjAwNTA1MTc0NTIwLkNENjJBM0EwMjFEQG1veWEub2ZmaWNlLmhvc3RmaXNzaW9uLmNvbSAt
PiBwYXRjaGV3LzIwMjAwNTA1MTc0NTIwLkNENjJBM0EwMjFEQG1veWEub2ZmaWNlLmhvc3RmaXNz
aW9uLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjRjYmExYTAgcW9tOiBEcm9w
IEBlcnJwIHBhcmFtZXRlciBvZiBvYmplY3RfcHJvcGVydHlfZGVsKCkKZDhiNzI5NiBzcGFwcl9w
Y2k6IERyb3Agc29tZSBkZWFkIGVycm9yIGhhbmRsaW5nCmYzNzAwZDQgcWRldjogVW5yZWFsaXpl
IG11c3Qgbm90IGZhaWwKZjM5ZjY1MSBEcm9wIG1vcmUgQGVycnAgcGFyYW1ldGVycyBhZnRlciBw
cmV2aW91cyBjb21taXQKOTNkOGU5OSBxb206IERyb3AgcGFyYW1ldGVyIEBlcnJwIG9mIG9iamVj
dF9wcm9wZXJ0eV9hZGQoKSAmIGZyaWVuZHMKNmEzOTJiNCBxZGV2OiBDbGVhbiB1cCBxZGV2X2Nv
bm5lY3RfZ3Bpb19vdXRfbmFtZWQoKQo2ZjdmOGM0IGh3L2FybS9iY20yODM1OiBEcm9wIGZ1dGls
ZSBhdHRlbXB0cyBhdCBRT00tYWRvcHRpbmcgbWVtb3J5CmRhOTE2YTUgZTEwMDA6IERvbid0IHJ1
biBlMTAwMF9pbnN0YW5jZV9pbml0KCkgdHdpY2UKZjJjYzM1MiBody9pc2Evc3VwZXJpbzogTWFr
ZSB0aGUgY29tcG9uZW50cyBRT00gY2hpbGRyZW4KOThhYzI3ZCBzMzkweC9jcHVtb2RlbDogRml4
IFVJIHRvIENQVSBmZWF0dXJlcyBwY2MtY21hYy17YWVzLCBlYWVzfS0yNTYKYjg4ZTFlYSB0ZXN0
cy9jaGVjay1xb20tcHJvcGxpc3Q6IEltcHJvdmUgaXRlcmF0b3IgY292ZXJhZ2UKMDY1ZDJmNSBx
b206IERyb3Agb2JqZWN0X3Byb3BlcnR5X3NldF9kZXNjcmlwdGlvbigpIHBhcmFtZXRlciBAZXJy
cAplYjQ4ODYwIHFvbTogTWFrZSBhbGwgdGhlIG9iamVjdF9wcm9wZXJ0eV9hZGRfRk9PKCkgcmV0
dXJuIHRoZSBwcm9wZXJ0eQo5NjQ3ZDRhIHFvbTogRHJvcCBjb252ZW5pZW5jZSBtZXRob2Qgb2Jq
ZWN0X3Byb3BlcnR5X2dldF91aW50MTZMaXN0KCkKNGYyMWFlNSBxb206IFNpbXBsaWZ5IG9iamVj
dF9wcm9wZXJ0eV9nZXRfZW51bSgpCjhiZjcxNjcgcW9tOiBEcm9wIG9iamVjdF9wcm9wZXJ0eV9k
ZWxfY2hpbGQoKSdzIHVudXNlZCBwYXJhbWV0ZXIgQGVycnAKYzg2YzQ2OSBxb206IENsZWFuIHVw
IGluY29uc2lzdGVudCB1c2Ugb2YgZ2NoYXIgKiB2cy4gY2hhciAqCjI0YTY5MWQgcW9tOiBDbGVh
cmVyIHJlZmVyZW5jZSBjb3VudGluZyBpbiBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZHYoKQoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KMS8xOCBDaGVja2luZyBjb21taXQgMjRhNjkxZGVmMzUzIChxb206
IENsZWFyZXIgcmVmZXJlbmNlIGNvdW50aW5nIGluIG9iamVjdF9pbml0aWFsaXplX2NoaWxkdigp
KQoyLzE4IENoZWNraW5nIGNvbW1pdCBjODZjNDY5NmJmZjcgKHFvbTogQ2xlYW4gdXAgaW5jb25z
aXN0ZW50IHVzZSBvZiBnY2hhciAqIHZzLiBjaGFyICopCjMvMTggQ2hlY2tpbmcgY29tbWl0IDhi
ZjcxNjc5YmNlMSAocW9tOiBEcm9wIG9iamVjdF9wcm9wZXJ0eV9kZWxfY2hpbGQoKSdzIHVudXNl
ZCBwYXJhbWV0ZXIgQGVycnApCjQvMTggQ2hlY2tpbmcgY29tbWl0IDRmMjFhZTVhZTVlZCAocW9t
OiBTaW1wbGlmeSBvYmplY3RfcHJvcGVydHlfZ2V0X2VudW0oKSkKNS8xOCBDaGVja2luZyBjb21t
aXQgOTY0N2Q0YWUxNmI3IChxb206IERyb3AgY29udmVuaWVuY2UgbWV0aG9kIG9iamVjdF9wcm9w
ZXJ0eV9nZXRfdWludDE2TGlzdCgpKQo2LzE4IENoZWNraW5nIGNvbW1pdCBlYjQ4ODYwYTNjMjYg
KHFvbTogTWFrZSBhbGwgdGhlIG9iamVjdF9wcm9wZXJ0eV9hZGRfRk9PKCkgcmV0dXJuIHRoZSBw
cm9wZXJ0eSkKNy8xOCBDaGVja2luZyBjb21taXQgMDY1ZDJmNTVkMWQ0IChxb206IERyb3Agb2Jq
ZWN0X3Byb3BlcnR5X3NldF9kZXNjcmlwdGlvbigpIHBhcmFtZXRlciBAZXJycCkKOC8xOCBDaGVj
a2luZyBjb21taXQgYjg4ZTFlYTRiYzM5ICh0ZXN0cy9jaGVjay1xb20tcHJvcGxpc3Q6IEltcHJv
dmUgaXRlcmF0b3IgY292ZXJhZ2UpCjkvMTggQ2hlY2tpbmcgY29tbWl0IDk4YWMyN2Q0NzA4OCAo
czM5MHgvY3B1bW9kZWw6IEZpeCBVSSB0byBDUFUgZmVhdHVyZXMgcGNjLWNtYWMte2FlcywgZWFl
c30tMjU2KQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzUzOiBGSUxFOiB0YXJnZXQv
czM5MHgvY3B1X2ZlYXR1cmVzX2RlZi5pbmMuaDozMTQ6CitERUZfRkVBVChQQ0NfQ01BQ19BRVNf
MjU2LCAicGNjLWNtYWMtYWVzLTI1NiIsIFBDQywgMjAsICJQQ0MgQ29tcHV0ZS1MYXN0LUJsb2Nr
LUNNQUMtVXNpbmctQUVTLTI1NiIpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDggbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggOS8xOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMTAvMTgg
Q2hlY2tpbmcgY29tbWl0IGYyY2MzNTJhNjAxYiAoaHcvaXNhL3N1cGVyaW86IE1ha2UgdGhlIGNv
bXBvbmVudHMgUU9NIGNoaWxkcmVuKQoxMS8xOCBDaGVja2luZyBjb21taXQgZGE5MTZhNWMzOTBi
IChlMTAwMDogRG9uJ3QgcnVuIGUxMDAwX2luc3RhbmNlX2luaXQoKSB0d2ljZSkKMTIvMTggQ2hl
Y2tpbmcgY29tbWl0IDZmN2Y4YzQ0NmNhNiAoaHcvYXJtL2JjbTI4MzU6IERyb3AgZnV0aWxlIGF0
dGVtcHRzIGF0IFFPTS1hZG9wdGluZyBtZW1vcnkpCjEzLzE4IENoZWNraW5nIGNvbW1pdCA2YTM5
MmI0ZGY5NzAgKHFkZXY6IENsZWFuIHVwIHFkZXZfY29ubmVjdF9ncGlvX291dF9uYW1lZCgpKQox
NC8xOCBDaGVja2luZyBjb21taXQgOTNkOGU5OTA1YzM4IChxb206IERyb3AgcGFyYW1ldGVyIEBl
cnJwIG9mIG9iamVjdF9wcm9wZXJ0eV9hZGQoKSAmIGZyaWVuZHMpCldBUk5JTkc6IGxpbmUgb3Zl
ciA4MCBjaGFyYWN0ZXJzCiMyMDk6IEZJTEU6IGJhY2tlbmRzL2hvc3RtZW0tZmlsZS5jOjE4NzoK
KyAgICAgICAgZmlsZV9tZW1vcnlfYmFja2VuZF9nZXRfZGlzY2FyZF9kYXRhLCBmaWxlX21lbW9y
eV9iYWNrZW5kX3NldF9kaXNjYXJkX2RhdGEpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJh
Y3RlcnMKIzEwODA6IEZJTEU6IGh3L2FybS9yYXNwaS5jOjI4NzoKKyAgICBvYmplY3RfcHJvcGVy
dHlfYWRkX2NvbnN0X2xpbmsoT0JKRUNUKCZzLT5zb2MpLCAicmFtIiwgT0JKRUNUKG1hY2hpbmUt
PnJhbSkpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzMwOTU6IEZJTEU6IGh3
L3BwYy9zcGFwci5jOjMzNDY6CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZz
cGFwci0+a2VybmVsX2FkZHIsIE9CSl9QUk9QX0ZMQUdfUkVBRFdSSVRFKTsKCnRvdGFsOiAwIGVy
cm9ycywgMyB3YXJuaW5ncywgNDQ3MSBsaW5lcyBjaGVja2VkCgpQYXRjaCAxNC8xOCBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoxNS8xOCBDaGVja2luZyBjb21taXQgZjM5ZjY1MTNiN2EyIChE
cm9wIG1vcmUgQGVycnAgcGFyYW1ldGVycyBhZnRlciBwcmV2aW91cyBjb21taXQpCjE2LzE4IENo
ZWNraW5nIGNvbW1pdCBmMzcwMGQ0NGVhYjEgKHFkZXY6IFVucmVhbGl6ZSBtdXN0IG5vdCBmYWls
KQoxNy8xOCBDaGVja2luZyBjb21taXQgZDhiNzI5NmNmOTM0IChzcGFwcl9wY2k6IERyb3Agc29t
ZSBkZWFkIGVycm9yIGhhbmRsaW5nKQoxOC8xOCBDaGVja2luZyBjb21taXQgNGNiYTFhMGRlOTlh
IChxb206IERyb3AgQGVycnAgcGFyYW1ldGVyIG9mIG9iamVjdF9wcm9wZXJ0eV9kZWwoKSkKPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDUx
NTI5MjYuMTg4NzctMS1hcm1icnVAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

