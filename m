Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49827C47247
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 00:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2211F206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 00:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2211F206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW8PP-0004T9-9D
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 20:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW8Oh-0003sP-1S
 for qemu-devel@nongnu.org; Tue, 05 May 2020 20:58:51 -0400
Resent-Date: Tue, 05 May 2020 20:58:51 -0400
Resent-Message-Id: <E1jW8Oh-0003sP-1S@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW8Of-0003kS-5m
 for qemu-devel@nongnu.org; Tue, 05 May 2020 20:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588726720; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L05yYWwpe9dwzLF1DY9WhGtx/lk5w072UI1U1a4YI7tF2pYCgcoI80NeF8vck2nqfG83Rs+DwKY8QDuYEMBpHn59jEU32pZ8K39AYaY8XH1Io9TROeLVEhf+8Ueg2nuHJqmJYNancyeb7rw6Cclik8ie/bXVLf9Yi5FPjFVt7YE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588726720;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=MVndXDrTpD4y7xMRJ2wgDegy9qBrp4BGo+WMJCBvmY0=; 
 b=JT9MgsqwwOVlus0D7QUWYCECqHtzn9pWzxQoYoWDeINmxnhYF4bFFnFGBQ++qJhLEmMTApIACVDap7/YNHsyti0x79fK1S8IKxQCifNpy8TPhvzBDnecGVNPSGcRtguOW+0PnRgWdRUOSdEEpMjgGs4KWkblFRV09g+cZWnLUmk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588726719107834.0507715071004;
 Tue, 5 May 2020 17:58:39 -0700 (PDT)
Message-ID: <158872671768.24779.1492525207400411274@45ef0f9c86ae>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
Subject: Re: [PATCH v2 00/18] qom: Spring cleaning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 5 May 2020 17:58:39 -0700 (PDT)
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
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjBiZmVkYTYgcW9tOiBEcm9wIEBlcnJwIHBhcmFtZXRlciBvZiBvYmpl
Y3RfcHJvcGVydHlfZGVsKCkKZmNlNTNhNiBzcGFwcl9wY2k6IERyb3Agc29tZSBkZWFkIGVycm9y
IGhhbmRsaW5nCmJmNGZhMWQgcWRldjogVW5yZWFsaXplIG11c3Qgbm90IGZhaWwKYzk4NGYzNSBE
cm9wIG1vcmUgQGVycnAgcGFyYW1ldGVycyBhZnRlciBwcmV2aW91cyBjb21taXQKMzIxNzE3NiBx
b206IERyb3AgcGFyYW1ldGVyIEBlcnJwIG9mIG9iamVjdF9wcm9wZXJ0eV9hZGQoKSAmIGZyaWVu
ZHMKZTQzZjdjZiBxZGV2OiBDbGVhbiB1cCBxZGV2X2Nvbm5lY3RfZ3Bpb19vdXRfbmFtZWQoKQoy
NWVkNmRhIGh3L2FybS9iY20yODM1OiBEcm9wIGZ1dGlsZSBhdHRlbXB0cyBhdCBRT00tYWRvcHRp
bmcgbWVtb3J5CjJiMDFmOTYgZTEwMDA6IERvbid0IHJ1biBlMTAwMF9pbnN0YW5jZV9pbml0KCkg
dHdpY2UKMDg1OWE0YSBody9pc2Evc3VwZXJpbzogTWFrZSB0aGUgY29tcG9uZW50cyBRT00gY2hp
bGRyZW4KMGFkOTM2OSBzMzkweC9jcHVtb2RlbDogRml4IFVJIHRvIENQVSBmZWF0dXJlcyBwY2Mt
Y21hYy17YWVzLCBlYWVzfS0yNTYKYTdiY2Q0YSB0ZXN0cy9jaGVjay1xb20tcHJvcGxpc3Q6IElt
cHJvdmUgaXRlcmF0b3IgY292ZXJhZ2UKYTg5YmYzOCBxb206IERyb3Agb2JqZWN0X3Byb3BlcnR5
X3NldF9kZXNjcmlwdGlvbigpIHBhcmFtZXRlciBAZXJycAoyYzk1MDdiIHFvbTogTWFrZSBhbGwg
dGhlIG9iamVjdF9wcm9wZXJ0eV9hZGRfRk9PKCkgcmV0dXJuIHRoZSBwcm9wZXJ0eQpjYWVlZDZm
IHFvbTogRHJvcCBjb252ZW5pZW5jZSBtZXRob2Qgb2JqZWN0X3Byb3BlcnR5X2dldF91aW50MTZM
aXN0KCkKNjcwYTViMSBxb206IFNpbXBsaWZ5IG9iamVjdF9wcm9wZXJ0eV9nZXRfZW51bSgpCjRl
MGVmMWUgcW9tOiBEcm9wIG9iamVjdF9wcm9wZXJ0eV9kZWxfY2hpbGQoKSdzIHVudXNlZCBwYXJh
bWV0ZXIgQGVycnAKMzMwNTc3MCBxb206IENsZWFuIHVwIGluY29uc2lzdGVudCB1c2Ugb2YgZ2No
YXIgKiB2cy4gY2hhciAqCjIzNzY5MGEgcW9tOiBDbGVhcmVyIHJlZmVyZW5jZSBjb3VudGluZyBp
biBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZHYoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xOCBD
aGVja2luZyBjb21taXQgMjM3NjkwYTBmZDExIChxb206IENsZWFyZXIgcmVmZXJlbmNlIGNvdW50
aW5nIGluIG9iamVjdF9pbml0aWFsaXplX2NoaWxkdigpKQoyLzE4IENoZWNraW5nIGNvbW1pdCAz
MzA1NzcwMWJlMmUgKHFvbTogQ2xlYW4gdXAgaW5jb25zaXN0ZW50IHVzZSBvZiBnY2hhciAqIHZz
LiBjaGFyICopCjMvMTggQ2hlY2tpbmcgY29tbWl0IDRlMGVmMWU0ZTMyZCAocW9tOiBEcm9wIG9i
amVjdF9wcm9wZXJ0eV9kZWxfY2hpbGQoKSdzIHVudXNlZCBwYXJhbWV0ZXIgQGVycnApCjQvMTgg
Q2hlY2tpbmcgY29tbWl0IDY3MGE1YjE3YTBmNSAocW9tOiBTaW1wbGlmeSBvYmplY3RfcHJvcGVy
dHlfZ2V0X2VudW0oKSkKNS8xOCBDaGVja2luZyBjb21taXQgY2FlZWQ2ZmRlNzljIChxb206IERy
b3AgY29udmVuaWVuY2UgbWV0aG9kIG9iamVjdF9wcm9wZXJ0eV9nZXRfdWludDE2TGlzdCgpKQo2
LzE4IENoZWNraW5nIGNvbW1pdCAyYzk1MDdiODczNWIgKHFvbTogTWFrZSBhbGwgdGhlIG9iamVj
dF9wcm9wZXJ0eV9hZGRfRk9PKCkgcmV0dXJuIHRoZSBwcm9wZXJ0eSkKNy8xOCBDaGVja2luZyBj
b21taXQgYTg5YmYzODE3OTk5IChxb206IERyb3Agb2JqZWN0X3Byb3BlcnR5X3NldF9kZXNjcmlw
dGlvbigpIHBhcmFtZXRlciBAZXJycCkKOC8xOCBDaGVja2luZyBjb21taXQgYTdiY2Q0YTY5ZDQy
ICh0ZXN0cy9jaGVjay1xb20tcHJvcGxpc3Q6IEltcHJvdmUgaXRlcmF0b3IgY292ZXJhZ2UpCjkv
MTggQ2hlY2tpbmcgY29tbWl0IDBhZDkzNjk1YzgxNiAoczM5MHgvY3B1bW9kZWw6IEZpeCBVSSB0
byBDUFUgZmVhdHVyZXMgcGNjLWNtYWMte2FlcywgZWFlc30tMjU2KQpFUlJPUjogbGluZSBvdmVy
IDkwIGNoYXJhY3RlcnMKIzUzOiBGSUxFOiB0YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzX2RlZi5p
bmMuaDozMTQ6CitERUZfRkVBVChQQ0NfQ01BQ19BRVNfMjU2LCAicGNjLWNtYWMtYWVzLTI1NiIs
IFBDQywgMjAsICJQQ0MgQ29tcHV0ZS1MYXN0LUJsb2NrLUNNQUMtVXNpbmctQUVTLTI1NiIpCgp0
b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDggbGluZXMgY2hlY2tlZAoKUGF0Y2ggOS8xOCBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMTAvMTggQ2hlY2tpbmcgY29tbWl0IDA4NTlhNGFl
ODRkYyAoaHcvaXNhL3N1cGVyaW86IE1ha2UgdGhlIGNvbXBvbmVudHMgUU9NIGNoaWxkcmVuKQox
MS8xOCBDaGVja2luZyBjb21taXQgMmIwMWY5NjMzODBiIChlMTAwMDogRG9uJ3QgcnVuIGUxMDAw
X2luc3RhbmNlX2luaXQoKSB0d2ljZSkKMTIvMTggQ2hlY2tpbmcgY29tbWl0IDI1ZWQ2ZGEyYzUx
MSAoaHcvYXJtL2JjbTI4MzU6IERyb3AgZnV0aWxlIGF0dGVtcHRzIGF0IFFPTS1hZG9wdGluZyBt
ZW1vcnkpCjEzLzE4IENoZWNraW5nIGNvbW1pdCBlNDNmN2NmMTg3N2QgKHFkZXY6IENsZWFuIHVw
IHFkZXZfY29ubmVjdF9ncGlvX291dF9uYW1lZCgpKQoxNC8xOCBDaGVja2luZyBjb21taXQgMzIx
NzE3NjkwZTQyIChxb206IERyb3AgcGFyYW1ldGVyIEBlcnJwIG9mIG9iamVjdF9wcm9wZXJ0eV9h
ZGQoKSAmIGZyaWVuZHMpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMDk6IEZJ
TEU6IGJhY2tlbmRzL2hvc3RtZW0tZmlsZS5jOjE4NzoKKyAgICAgICAgZmlsZV9tZW1vcnlfYmFj
a2VuZF9nZXRfZGlzY2FyZF9kYXRhLCBmaWxlX21lbW9yeV9iYWNrZW5kX3NldF9kaXNjYXJkX2Rh
dGEpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzEwODA6IEZJTEU6IGh3L2Fy
bS9yYXNwaS5jOjI4NzoKKyAgICBvYmplY3RfcHJvcGVydHlfYWRkX2NvbnN0X2xpbmsoT0JKRUNU
KCZzLT5zb2MpLCAicmFtIiwgT0JKRUNUKG1hY2hpbmUtPnJhbSkpOwoKV0FSTklORzogbGluZSBv
dmVyIDgwIGNoYXJhY3RlcnMKIzMwOTU6IEZJTEU6IGh3L3BwYy9zcGFwci5jOjMzNDY6CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzcGFwci0+a2VybmVsX2FkZHIsIE9CSl9Q
Uk9QX0ZMQUdfUkVBRFdSSVRFKTsKCnRvdGFsOiAwIGVycm9ycywgMyB3YXJuaW5ncywgNDQ3MSBs
aW5lcyBjaGVja2VkCgpQYXRjaCAxNC8xOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoxNS8x
OCBDaGVja2luZyBjb21taXQgYzk4NGYzNWNjZDMyIChEcm9wIG1vcmUgQGVycnAgcGFyYW1ldGVy
cyBhZnRlciBwcmV2aW91cyBjb21taXQpCjE2LzE4IENoZWNraW5nIGNvbW1pdCBiZjRmYTFkNDAx
MDggKHFkZXY6IFVucmVhbGl6ZSBtdXN0IG5vdCBmYWlsKQoxNy8xOCBDaGVja2luZyBjb21taXQg
ZmNlNTNhNmRlNDMwIChzcGFwcl9wY2k6IERyb3Agc29tZSBkZWFkIGVycm9yIGhhbmRsaW5nKQox
OC8xOCBDaGVja2luZyBjb21taXQgMGJmZWRhNjU5NGJlIChxb206IERyb3AgQGVycnAgcGFyYW1l
dGVyIG9mIG9iamVjdF9wcm9wZXJ0eV9kZWwoKSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDUxNTI5MjYuMTg4NzctMS1hcm1icnVAcmVk
aGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

