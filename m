Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0186EC47254
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC12F20735
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 01:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC12F20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW8wD-0003aN-GH
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 21:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW8uh-0002uz-9S
 for qemu-devel@nongnu.org; Tue, 05 May 2020 21:31:58 -0400
Resent-Date: Tue, 05 May 2020 21:31:55 -0400
Resent-Message-Id: <E1jW8uh-0002uz-9S@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW8ue-00064u-Nz
 for qemu-devel@nongnu.org; Tue, 05 May 2020 21:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588728702; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EqJlB44AUggtU6VFE9eHb3CjQNFeGRSaV+Tr11pRBckcF0iPldwdvhspufnfXVBDm1ym6qggjuOyLMY4jxxfFlLVVlEvDjnSS5ztc083IcCeHK+zH5/EV+EfFYGE5yCLxSISenfQrjvMu8Ndk0HoJqkHayPWungERw50jNRJQFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588728702;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dkXSvlWYGUSNZOC84O724KhClbd7wbBTFG1J/xx3pks=; 
 b=W+J98dQSPrlhBwLI58wFaVDysyBNHXhsBCUzx0h+t0tPkVp0RwSf+hT44n8ogra4d1Dk+37Gn+9Pe8Au5tteuHGQE2owa7RkPzpAE/3PlV2mSjPN9YZaPMb0uXH0Uk55WU1bcKi88zQEoZ5wdBTAFje8Jx5AsoC+ASoROpcAm7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588728699868552.7010181941824;
 Tue, 5 May 2020 18:31:39 -0700 (PDT)
Message-ID: <158872869853.24779.1541614485230624664@45ef0f9c86ae>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
Subject: Re: [PATCH v2 00/18] qom: Spring cleaning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 5 May 2020 18:31:39 -0700 (PDT)
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
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2ZDY1YmViIHFvbTogRHJvcCBAZXJycCBwYXJhbWV0ZXIg
b2Ygb2JqZWN0X3Byb3BlcnR5X2RlbCgpCjQ1OGNlZGIgc3BhcHJfcGNpOiBEcm9wIHNvbWUgZGVh
ZCBlcnJvciBoYW5kbGluZwo3ZmZiNTQ2IHFkZXY6IFVucmVhbGl6ZSBtdXN0IG5vdCBmYWlsCmJm
YWIzODcgRHJvcCBtb3JlIEBlcnJwIHBhcmFtZXRlcnMgYWZ0ZXIgcHJldmlvdXMgY29tbWl0CjA5
MzE0MGEgcW9tOiBEcm9wIHBhcmFtZXRlciBAZXJycCBvZiBvYmplY3RfcHJvcGVydHlfYWRkKCkg
JiBmcmllbmRzCjc4MDJiYmUgcWRldjogQ2xlYW4gdXAgcWRldl9jb25uZWN0X2dwaW9fb3V0X25h
bWVkKCkKNjc0ODM3YyBody9hcm0vYmNtMjgzNTogRHJvcCBmdXRpbGUgYXR0ZW1wdHMgYXQgUU9N
LWFkb3B0aW5nIG1lbW9yeQowYzUxMDUwIGUxMDAwOiBEb24ndCBydW4gZTEwMDBfaW5zdGFuY2Vf
aW5pdCgpIHR3aWNlCjBiMDhiMGYgaHcvaXNhL3N1cGVyaW86IE1ha2UgdGhlIGNvbXBvbmVudHMg
UU9NIGNoaWxkcmVuCmJhMjkyYzAgczM5MHgvY3B1bW9kZWw6IEZpeCBVSSB0byBDUFUgZmVhdHVy
ZXMgcGNjLWNtYWMte2FlcywgZWFlc30tMjU2CjA1OTY1MGYgdGVzdHMvY2hlY2stcW9tLXByb3Bs
aXN0OiBJbXByb3ZlIGl0ZXJhdG9yIGNvdmVyYWdlCjU0ZDcwZjIgcW9tOiBEcm9wIG9iamVjdF9w
cm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24oKSBwYXJhbWV0ZXIgQGVycnAKZTRjNDc3ZCBxb206IE1h
a2UgYWxsIHRoZSBvYmplY3RfcHJvcGVydHlfYWRkX0ZPTygpIHJldHVybiB0aGUgcHJvcGVydHkK
NDBkNDVlZiBxb206IERyb3AgY29udmVuaWVuY2UgbWV0aG9kIG9iamVjdF9wcm9wZXJ0eV9nZXRf
dWludDE2TGlzdCgpCjU0NDAyMGIgcW9tOiBTaW1wbGlmeSBvYmplY3RfcHJvcGVydHlfZ2V0X2Vu
dW0oKQpjM2I5YzU3IHFvbTogRHJvcCBvYmplY3RfcHJvcGVydHlfZGVsX2NoaWxkKCkncyB1bnVz
ZWQgcGFyYW1ldGVyIEBlcnJwCjJkMDZjZjkgcW9tOiBDbGVhbiB1cCBpbmNvbnNpc3RlbnQgdXNl
IG9mIGdjaGFyICogdnMuIGNoYXIgKgo0NTJiNzM1IHFvbTogQ2xlYXJlciByZWZlcmVuY2UgY291
bnRpbmcgaW4gb2JqZWN0X2luaXRpYWxpemVfY2hpbGR2KCkKCj09PSBPVVRQVVQgQkVHSU4gPT09
CjEvMTggQ2hlY2tpbmcgY29tbWl0IDQ1MmI3MzU2NDBiMyAocW9tOiBDbGVhcmVyIHJlZmVyZW5j
ZSBjb3VudGluZyBpbiBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZHYoKSkKMi8xOCBDaGVja2luZyBj
b21taXQgMmQwNmNmOWZiYjYzIChxb206IENsZWFuIHVwIGluY29uc2lzdGVudCB1c2Ugb2YgZ2No
YXIgKiB2cy4gY2hhciAqKQozLzE4IENoZWNraW5nIGNvbW1pdCBjM2I5YzU3MWFiYmIgKHFvbTog
RHJvcCBvYmplY3RfcHJvcGVydHlfZGVsX2NoaWxkKCkncyB1bnVzZWQgcGFyYW1ldGVyIEBlcnJw
KQo0LzE4IENoZWNraW5nIGNvbW1pdCA1NDQwMjBiNjY5MGQgKHFvbTogU2ltcGxpZnkgb2JqZWN0
X3Byb3BlcnR5X2dldF9lbnVtKCkpCjUvMTggQ2hlY2tpbmcgY29tbWl0IDQwZDQ1ZWZhNGExZiAo
cW9tOiBEcm9wIGNvbnZlbmllbmNlIG1ldGhvZCBvYmplY3RfcHJvcGVydHlfZ2V0X3VpbnQxNkxp
c3QoKSkKNi8xOCBDaGVja2luZyBjb21taXQgZTRjNDc3ZDA2NDc3IChxb206IE1ha2UgYWxsIHRo
ZSBvYmplY3RfcHJvcGVydHlfYWRkX0ZPTygpIHJldHVybiB0aGUgcHJvcGVydHkpCjcvMTggQ2hl
Y2tpbmcgY29tbWl0IDU0ZDcwZjJhMmFhMiAocW9tOiBEcm9wIG9iamVjdF9wcm9wZXJ0eV9zZXRf
ZGVzY3JpcHRpb24oKSBwYXJhbWV0ZXIgQGVycnApCjgvMTggQ2hlY2tpbmcgY29tbWl0IDA1OTY1
MGY2ZWI3MyAodGVzdHMvY2hlY2stcW9tLXByb3BsaXN0OiBJbXByb3ZlIGl0ZXJhdG9yIGNvdmVy
YWdlKQo5LzE4IENoZWNraW5nIGNvbW1pdCBiYTI5MmMwZDY1MGEgKHMzOTB4L2NwdW1vZGVsOiBG
aXggVUkgdG8gQ1BVIGZlYXR1cmVzIHBjYy1jbWFjLXthZXMsIGVhZXN9LTI1NikKRVJST1I6IGxp
bmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM1MzogRklMRTogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJl
c19kZWYuaW5jLmg6MzE0OgorREVGX0ZFQVQoUENDX0NNQUNfQUVTXzI1NiwgInBjYy1jbWFjLWFl
cy0yNTYiLCBQQ0MsIDIwLCAiUENDIENvbXB1dGUtTGFzdC1CbG9jay1DTUFDLVVzaW5nLUFFUy0y
NTYiKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNrZWQKClBhdGNo
IDkvMTggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjEwLzE4IENoZWNraW5nIGNvbW1pdCAw
YjA4YjBmZDk3MjUgKGh3L2lzYS9zdXBlcmlvOiBNYWtlIHRoZSBjb21wb25lbnRzIFFPTSBjaGls
ZHJlbikKMTEvMTggQ2hlY2tpbmcgY29tbWl0IDBjNTEwNTBjYTU2OCAoZTEwMDA6IERvbid0IHJ1
biBlMTAwMF9pbnN0YW5jZV9pbml0KCkgdHdpY2UpCjEyLzE4IENoZWNraW5nIGNvbW1pdCA2NzQ4
MzdjMDc0ZDggKGh3L2FybS9iY20yODM1OiBEcm9wIGZ1dGlsZSBhdHRlbXB0cyBhdCBRT00tYWRv
cHRpbmcgbWVtb3J5KQoxMy8xOCBDaGVja2luZyBjb21taXQgNzgwMmJiZWZkZmI5IChxZGV2OiBD
bGVhbiB1cCBxZGV2X2Nvbm5lY3RfZ3Bpb19vdXRfbmFtZWQoKSkKMTQvMTggQ2hlY2tpbmcgY29t
bWl0IDA5MzE0MGFhMjcyMyAocW9tOiBEcm9wIHBhcmFtZXRlciBAZXJycCBvZiBvYmplY3RfcHJv
cGVydHlfYWRkKCkgJiBmcmllbmRzKQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwoj
MjA5OiBGSUxFOiBiYWNrZW5kcy9ob3N0bWVtLWZpbGUuYzoxODc6CisgICAgICAgIGZpbGVfbWVt
b3J5X2JhY2tlbmRfZ2V0X2Rpc2NhcmRfZGF0YSwgZmlsZV9tZW1vcnlfYmFja2VuZF9zZXRfZGlz
Y2FyZF9kYXRhKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMDgwOiBGSUxF
OiBody9hcm0vcmFzcGkuYzoyODc6CisgICAgb2JqZWN0X3Byb3BlcnR5X2FkZF9jb25zdF9saW5r
KE9CSkVDVCgmcy0+c29jKSwgInJhbSIsIE9CSkVDVChtYWNoaW5lLT5yYW0pKTsKCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMzMDk1OiBGSUxFOiBody9wcGMvc3BhcHIuYzozMzQ2
OgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc3BhcHItPmtlcm5lbF9hZGRy
LCBPQkpfUFJPUF9GTEFHX1JFQURXUklURSk7Cgp0b3RhbDogMCBlcnJvcnMsIDMgd2FybmluZ3Ms
IDQ0NzEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTQvMTggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KMTUvMTggQ2hlY2tpbmcgY29tbWl0IGJmYWIzODdlYjFmZSAoRHJvcCBtb3JlIEBlcnJwIHBh
cmFtZXRlcnMgYWZ0ZXIgcHJldmlvdXMgY29tbWl0KQoxNi8xOCBDaGVja2luZyBjb21taXQgN2Zm
YjU0Njg2Zjc0IChxZGV2OiBVbnJlYWxpemUgbXVzdCBub3QgZmFpbCkKMTcvMTggQ2hlY2tpbmcg
Y29tbWl0IDQ1OGNlZGJlOWM2ZSAoc3BhcHJfcGNpOiBEcm9wIHNvbWUgZGVhZCBlcnJvciBoYW5k
bGluZykKMTgvMTggQ2hlY2tpbmcgY29tbWl0IDZkNjViZWIyMzUzNCAocW9tOiBEcm9wIEBlcnJw
IHBhcmFtZXRlciBvZiBvYmplY3RfcHJvcGVydHlfZGVsKCkpCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTA1MTUyOTI2LjE4ODc3LTEtYXJt
YnJ1QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

