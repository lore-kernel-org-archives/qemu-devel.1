Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6330C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACF2221FC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 03:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACF2221FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUiKa-0007uJ-Tf
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 23:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUiJg-00077c-GY; Mon, 19 Oct 2020 23:28:09 -0400
Resent-Date: Mon, 19 Oct 2020 23:28:04 -0400
Resent-Message-Id: <E1kUiJg-00077c-GY@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUiJd-0002Kp-3A; Mon, 19 Oct 2020 23:28:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603164464; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MHeFRe11wwaYxSXjekwmuLa5APPexu3LoKcG7HaLbVgpNWzYHj4EsYZ8IfUU26IIhF0RyBxwn3N+p6o1OwqhPHR4zD0mZMY7QjCCb7BB+FamcoKqP085PHbBcNyLRtLa9YiBiJ93ZpFYjS7dDylfI+Z7JlgmlvulP+iHVu6TRMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603164464;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=m71fKW4pA8XVGxvAhTG3jvu1JGUw5HBPCi/NX7Vb8L0=; 
 b=J5JD7yjGnL2iUVeXAOaAtI33EowoJylrFaPMyBKms0M/H8vPwbF6te62AjLxKoallW1/dEigq7DYQbTlKrFmKTDpQF/B3bBrcbB79gro72Lt76uhSRlTWF3CNE/Hf+9aRkrEixC1j/E2TCT/a7ZCAf++T/8bmOKVF8b51xz+pSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603164463689563.7576093448332;
 Mon, 19 Oct 2020 20:27:43 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Fix some style problems in migration
Message-ID: <160316446187.18439.7746821496766547264@66eaa9a8a123>
In-Reply-To: <1603163448-27122-1-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yubihong@huawei.com
Date: Mon, 19 Oct 2020 20:27:43 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 23:27:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: yubihong@huawei.com, alex.chen@huawei.com, quintela@redhat.com,
 qemu-trivial@nongnu.org, armbru@redhat.com, dgilbert@redhat.com,
 qemu-devel@nongnu.org, zhengchuan@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAzMTYzNDQ4LTI3MTIyLTEt
Z2l0LXNlbmQtZW1haWwteXViaWhvbmdAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE2MDMxNjM0
NDgtMjcxMjItMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tClN1YmplY3Q6IFtQ
QVRDSCB2MyAwLzhdIEZpeCBzb21lIHN0eWxlIHByb2JsZW1zIGluIG1pZ3JhdGlvbgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8xNjAzMTYzNDQ4LTI3MTIy
LTEtZ2l0LXNlbmQtZW1haWwteXViaWhvbmdAaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzE2MDMxNjM0
NDgtMjcxMjItMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tCiAtIFt0YWcgdXBk
YXRlXSAgICAgIHBhdGNoZXcvY292ZXIuMTYwMjYzNDUyNC5naXQuYWxpc3RhaXIuZnJhbmNpc0B3
ZGMuY29tIC0+IHBhdGNoZXcvY292ZXIuMTYwMjYzNDUyNC5naXQuYWxpc3RhaXIuZnJhbmNpc0B3
ZGMuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYjMzZWRlYSBtaWdyYXRpb246
IERlbGV0ZSByZWR1bmRhbnQgc3BhY2VzCjI3NzU2M2QgbWlncmF0aW9uOiBPcGVuIGJyYWNlICd7
JyBmb2xsb3dpbmcgZnVuY3Rpb24gZGVjbGFyYXRpb25zIGdvIG9uIHRoZSBuZXh0IGxpbmUKN2Rk
MGFkMCBtaWdyYXRpb246IERvIG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgYW5kIGdsb2JhbHMgdG8g
MCBvciBOVUxMCjU1NDBmZDEgbWlncmF0aW9uOiBBZGQgYnJhY2VzIHt9IGZvciBpZiBzdGF0ZW1l
bnQKODljMWExMiBtaWdyYXRpb246IE9wZW4gYnJhY2UgJ3snIGZvbGxvd2luZyBzdHJ1Y3QgZ28g
b24gdGhlIHNhbWUgbGluZQoyM2U3ZjNmIG1pZ3JhdGlvbjogQWRkIHNwYWNlcyBhcm91bmQgb3Bl
cmF0b3IKY2M5ZWM5OSBtaWdyYXRpb246IERvbid0IHVzZSAnIycgZmxhZyBvZiBwcmludGYgZm9y
bWF0CjEyMmRjNjggbWlncmF0aW9uOiBEbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KMS84IENoZWNraW5nIGNvbW1pdCAxMjJkYzY4ZGEzZGYgKG1pZ3JhdGlv
bjogRG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMpCjIvOCBDaGVja2luZyBjb21taXQgY2M5ZWM5
OWM1YWMwIChtaWdyYXRpb246IERvbid0IHVzZSAnIycgZmxhZyBvZiBwcmludGYgZm9ybWF0KQoz
LzggQ2hlY2tpbmcgY29tbWl0IDIzZTdmM2ZiNTFjMiAobWlncmF0aW9uOiBBZGQgc3BhY2VzIGFy
b3VuZCBvcGVyYXRvcikKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0
eDpXeFYpCiM2MjogRklMRTogbWlncmF0aW9uL3NhdmV2bS5jOjUyNDoKKyAgICAuc3Vic2VjdGlv
bnMgPSAoY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICpbXSkgewogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCA1OSBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjQvOCBDaGVja2luZyBjb21taXQgODljMWExMjE1ZWYwIChtaWdyYXRpb246IE9wZW4gYnJhY2Ug
J3snIGZvbGxvd2luZyBzdHJ1Y3QgZ28gb24gdGhlIHNhbWUgbGluZSkKNS84IENoZWNraW5nIGNv
bW1pdCA1NTQwZmQxMjFmMTkgKG1pZ3JhdGlvbjogQWRkIGJyYWNlcyB7fSBmb3IgaWYgc3RhdGVt
ZW50KQo2LzggQ2hlY2tpbmcgY29tbWl0IDdkZDBhZDBjNWI4NiAobWlncmF0aW9uOiBEbyBub3Qg
aW5pdGlhbGlzZSBzdGF0aWNzIGFuZCBnbG9iYWxzIHRvIDAgb3IgTlVMTCkKNy84IENoZWNraW5n
IGNvbW1pdCAyNzc1NjNkMjdjMzMgKG1pZ3JhdGlvbjogT3BlbiBicmFjZSAneycgZm9sbG93aW5n
IGZ1bmN0aW9uIGRlY2xhcmF0aW9ucyBnbyBvbiB0aGUgbmV4dCBsaW5lKQo4LzggQ2hlY2tpbmcg
Y29tbWl0IGIzM2VkZWE1ODRiNCAobWlncmF0aW9uOiBEZWxldGUgcmVkdW5kYW50IHNwYWNlcykK
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTYwMzE2
MzQ0OC0yNzEyMi0xLWdpdC1zZW5kLWVtYWlsLXl1Ymlob25nQGh1YXdlaS5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

