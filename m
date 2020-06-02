Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4C5206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4C5206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCR6-00036d-02
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgCOk-0007NB-6z
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:30 -0400
Resent-Date: Tue, 02 Jun 2020 15:16:30 -0400
Resent-Message-Id: <E1jgCOk-0007NB-6z@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jgCOi-0002iE-9Q
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591125367; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PYEPvzM0wlGlvOAznqyIWyRU89tkmPnES5s/2fzQfzFXh9jmP7G1AFlJAuWn8m4NLPD+Dj3e5NA4hUHJ9Yq7Z7oIPk8mK+MGmBIDGVbKLhH+8wx+lNU+gwWKGqwh8QZLm+ee0s/cDWpDtkCWrtvT5HOaMe0NVBY4u1JLnn6kBK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591125367;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Mt9j7YABiJBCeG7ld4NCmZjS49Nz/Q+PdpLlbzvnBV4=; 
 b=MNeVo3VdfJbKfk7OH1J+fCJU01PQ1KRjDDiSBLsg2YbVzNW5h9rZYjkBsqfQEADu06r+64iDw3fsOR9SCjbuLHkb9Rwgi0Q2vT9CpkTMts6LB5R5Wd48sga+pjeVWJ/fwVCFFfQ9JieIXZXW+8RZujP84Ymj5DrsBoAukSoOsv8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591125365419117.51124897152658;
 Tue, 2 Jun 2020 12:16:05 -0700 (PDT)
Message-ID: <159112536372.18153.9299263552214324714@45ef0f9c86ae>
In-Reply-To: <20200602154624.4460-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/9] plugins/next (bug fixes, hwprofile, lockstep)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Tue, 2 Jun 2020 12:16:05 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:16:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMjE1NDYyNC40NDYw
LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDIxNTQ2MjQuNDQ2MC0xLWFsZXguYmVu
bmVlQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIICB2MSAwLzldIHBsdWdpbnMvbmV4dCAoYnVn
IGZpeGVzLCBod3Byb2ZpbGUsIGxvY2tzdGVwKQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8
IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0
aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjVl
M2M5ZjYgLnRyYXZpcy55bWw6IGFsbG93IGZhaWx1cmUgZm9yIHVucmVsaWFibGUgaG9zdHMKYTgy
OWExYyBwbHVnaW5zOiBuZXcgaHdwcm9maWxlIHBsdWdpbgpmYjM5ODg5IHBsdWdpbnM6IGFkZCBB
UEkgdG8gcmV0dXJuIGEgbmFtZSBmb3IgYSBJTyBkZXZpY2UKMmQ4YjU3YyBody92aXJ0aW8vcGNp
OiBpbmNsdWRlIHZkZXYgbmFtZSBpbiByZWdpc3RlcmVkIFBDSSBzZWN0aW9ucwpjMjc1YTc2IGNw
dXRsYjogZW5zdXJlIHdlIHJlLWZpbGwgdGhlIFRMQiBpZiBpdCBoYXMgcmVzZXQKMmNlNTEzNSB0
ZXN0cy9wbHVnaW46IGNvcnJlY3RseSBob25vdXIgaW9fY291bnQKZmJkZjY3MCBzY3JpcHRzL2Ns
ZWFuLWluY2x1ZGVzOiBNYXJrICdxZW11L3FlbXUtcGx1Z2luLmgnIGFzIHNwZWNpYWwgaGVhZGVy
CjQyYTU5Y2YgcWVtdS1wbHVnaW4uaDogYWRkIG1pc3NpbmcgaW5jbHVkZSA8c3RkZGVmLmg+IHRv
IGRlZmluZSBzaXplX3QKZTNkYzMxNiBwbHVnaW5zOiBuZXcgbG9ja3N0ZXAgcGx1Z2luIGZvciBk
ZWJ1Z2dpbmcgVENHIGNoYW5nZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOSBDaGVja2luZyBj
b21taXQgZTNkYzMxNjZlZDY5IChwbHVnaW5zOiBuZXcgbG9ja3N0ZXAgcGx1Z2luIGZvciBkZWJ1
Z2dpbmcgVENHIGNoYW5nZXMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUo
cyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzU1OiAKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMzU1IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDEvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoyLzkgQ2hlY2tpbmcgY29tbWl0IDQy
YTU5Y2YwNDA2OCAocWVtdS1wbHVnaW4uaDogYWRkIG1pc3NpbmcgaW5jbHVkZSA8c3RkZGVmLmg+
IHRvIGRlZmluZSBzaXplX3QpCjMvOSBDaGVja2luZyBjb21taXQgZmJkZjY3MDA3NjE0IChzY3Jp
cHRzL2NsZWFuLWluY2x1ZGVzOiBNYXJrICdxZW11L3FlbXUtcGx1Z2luLmgnIGFzIHNwZWNpYWwg
aGVhZGVyKQo0LzkgQ2hlY2tpbmcgY29tbWl0IDJjZTUxMzUzNWE0MSAodGVzdHMvcGx1Z2luOiBj
b3JyZWN0bHkgaG9ub3VyIGlvX2NvdW50KQo1LzkgQ2hlY2tpbmcgY29tbWl0IGMyNzVhNzZmZWEx
MyAoY3B1dGxiOiBlbnN1cmUgd2UgcmUtZmlsbCB0aGUgVExCIGlmIGl0IGhhcyByZXNldCkKNi85
IENoZWNraW5nIGNvbW1pdCAyZDhiNTdjZWQ3NGMgKGh3L3ZpcnRpby9wY2k6IGluY2x1ZGUgdmRl
diBuYW1lIGluIHJlZ2lzdGVyZWQgUENJIHNlY3Rpb25zKQpXQVJOSU5HOiBsaW5lIG92ZXIgODAg
Y2hhcmFjdGVycwojMjM6IEZJTEU6IGh3L3ZpcnRpby92aXJ0aW8tcGNpLmM6MTM5MzoKK3N0YXRp
YyB2b2lkIHZpcnRpb19wY2lfbW9kZXJuX3JlZ2lvbnNfaW5pdChWaXJ0SU9QQ0lQcm94eSAqcHJv
eHksIGNvbnN0IGNoYXIgKnZkZXZfbmFtZSkKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywg
NjMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjcv
OSBDaGVja2luZyBjb21taXQgZmIzOTg4OTMyYmJhIChwbHVnaW5zOiBhZGQgQVBJIHRvIHJldHVy
biBhIG5hbWUgZm9yIGEgSU8gZGV2aWNlKQpFUlJPUjogImZvbyAqIGJhciIgc2hvdWxkIGJlICJm
b28gKmJhciIKIzIzOiBGSUxFOiBpbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaDozNDE6CitjaGFy
ICogcWVtdV9wbHVnaW5faHdhZGRyX2RldmljZV9uYW1lKGNvbnN0IHN0cnVjdCBxZW11X3BsdWdp
bl9od2FkZHIgKmhhZGRyKTsKCkVSUk9SOiAiZm9vICogYmFyIiBzaG91bGQgYmUgImZvbyAqYmFy
IgojMzY6IEZJTEU6IHBsdWdpbnMvYXBpLmM6MzA2OgorY2hhciAqIHFlbXVfcGx1Z2luX2h3YWRk
cl9kZXZpY2VfbmFtZShjb25zdCBzdHJ1Y3QgcWVtdV9wbHVnaW5faHdhZGRyICpoYWRkcikKCldB
Uk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM0MjogRklMRTogcGx1Z2lucy9hcGkuYzoz
MTI6CisgICAgICAgICAgICByZXR1cm4gZ19zdHJkdXBfcHJpbnRmKCJhbm9uJTA4bHgiLCAweGZm
ZmZmZmZmICYgKHVpbnRwdHJfdCkgbXJzLT5tcik7Cgp0b3RhbDogMiBlcnJvcnMsIDEgd2Fybmlu
Z3MsIDM1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDcvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKOC85IENoZWNraW5nIGNvbW1pdCBhODI5YTFjYTRjMjAgKHBsdWdpbnM6IG5ldyBod3Byb2Zp
bGUgcGx1Z2luKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2Vz
IE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzMDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpF
UlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzE0MTogRklMRTogdGVzdHMvcGx1Z2luL2h3
cHJvZmlsZS5jOjEwNzoKKyAgICAgICAgICAgICAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKHJl
cG9ydCwgIiVzIEAgMHglIlBSSXg2NCJcbiIsIHJlYy0+bmFtZSwgcmVjLT5iYXNlKTsKCldBUk5J
Tkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxNDQ6IEZJTEU6IHRlc3RzL3BsdWdpbi9od3By
b2ZpbGUuYzoxMTA6CisgICAgICAgICAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYo
cmVwb3J0LCAiICBvZmY6JTA4IlBSSXg2NCwgbG9jLT5vZmZzZXQpOwoKRVJST1I6IHN1c3BlY3Qg
Y29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMgKDIwLCAyMykKIzE0OTogRklM
RTogdGVzdHMvcGx1Z2luL2h3cHJvZmlsZS5jOjExNToKKyAgICAgICAgICAgICAgICAgICAgaWYg
KHRyYWNrX3dyaXRlcygpKSB7CisgICAgICAgICAgICAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVu
ZF9wcmludGYocmVwb3J0LCAiLCAweCUwNHgsICUiUFJJZDY0LAoKRVJST1I6IHNwYWNlIHJlcXVp
cmVkIGFmdGVyIHRoYXQgJywnIChjdHg6VnhWKQojMTUzOiBGSUxFOiB0ZXN0cy9wbHVnaW4vaHdw
cm9maWxlLmM6MTE5OgorICAgICAgICAgICAgICAgICAgICBnX3N0cmluZ19hcHBlbmRfYyhyZXBv
cnQsJ1xuJyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
CkVSUk9SOiAiZm9vICogYmFyIiBzaG91bGQgYmUgImZvbyAqYmFyIgojMTc3OiBGSUxFOiB0ZXN0
cy9wbHVnaW4vaHdwcm9maWxlLmM6MTQzOgorc3RhdGljIERldmljZUNvdW50cyAqIG5ld19jb3Vu
dChjaGFyICpuYW1lLCB1aW50NjRfdCBiYXNlKQoKRVJST1I6ICJmb28gKiBiYXIiIHNob3VsZCBi
ZSAiZm9vICpiYXIiCiMxODk6IEZJTEU6IHRlc3RzL3BsdWdpbi9od3Byb2ZpbGUuYzoxNTU6Citz
dGF0aWMgSU9Mb2NhdGlvbkNvdW50cyAqIG5ld19sb2NhdGlvbih1aW50NjRfdCBvZmZzZXQpCgpF
UlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzIxOTogRklMRTogdGVzdHMvcGx1Z2luL2h3
cHJvZmlsZS5jOjE4NToKKyAgICAgICAgICAgIElPTG9jYXRpb25Db3VudHMgKmlvX2NvdW50ID0g
Z19oYXNoX3RhYmxlX2xvb2t1cChjb3VudHMtPmFjY2Vzc19wYXR0ZXJuLCAmb2ZmKTsKCnRvdGFs
OiA2IGVycm9ycywgMiB3YXJuaW5ncywgMjU1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKOS85IENoZWNraW5nIGNvbW1pdCA1ZTNjOWY2YjM3Yzkg
KC50cmF2aXMueW1sOiBhbGxvdyBmYWlsdXJlIGZvciB1bnJlbGlhYmxlIGhvc3RzKQo9PT0gT1VU
UFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYwMjE1NDYy
NC40NDYwLTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

