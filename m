Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C5BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F67206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F67206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbAdf-0002Xe-1Z
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 18:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbAd9-00028I-KR
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:22:35 -0400
Resent-Date: Tue, 19 May 2020 18:22:35 -0400
Resent-Message-Id: <E1jbAd9-00028I-KR@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbAd7-0000E2-Vr
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:22:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589926946; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SYwMBOCFHNgDq11kr+hyq1OOyxqbxlEehXLXUkALzm8xGACkmmjvwJXMp7JQJB0lXEE82ed7e6D2tmg33O5InIH2EZwUx9GptVcQP1Zds4ajwtKhfwBfgXN9j7OpZFrqoxgViPw6gyy0ulDTx+CnjDM85DsQEARb1HNkT5WCEqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589926946;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1dFtOz+G200GQd7Pkha0FusdZeRtCDPUB1Oj3XEEo0c=; 
 b=e8YJ+dMI/ujbRvbJh63vjp+D9wxDqfSWP/eevaKQV611rsZzivhM1+/cnXjx1Pq/ejpg4z5Ycj2+Ew75ZDP68fwpf6c1CBxCDi7XjZl5Q1KFZ6NhwmG6nUCarIA3M20axgxr1x3VdaB/82nt0x0vdNLzXNi9FJ+nmMt8YM0HSGY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589926944879560.0843097176003;
 Tue, 19 May 2020 15:22:24 -0700 (PDT)
Message-ID: <158992694389.19297.552338994928135181@45ef0f9c86ae>
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
Subject: Re: [PULL 00/10] softfloat misc cleanups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 19 May 2020 15:22:24 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 17:30:22
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxOTE2NDk1Ny4yNjky
MC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTE5MTY0OTU3LjI2OTIwLTEt
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpTdWJqZWN0OiBbUFVMTCAwMC8xMF0gc29mdGZs
b2F0IG1pc2MgY2xlYW51cHMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFn
IHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwNTE1MTcwODA0LjU3MDctMS1waGlsbWRAcmVkaGF0
LmNvbSAtPiBwYXRjaGV3LzIwMjAwNTE1MTcwODA0LjU3MDctMS1waGlsbWRAcmVkaGF0LmNvbQog
LSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwNTE2MDYzNzQ2LjE4Mjk2LTEtYW51cC5w
YXRlbEB3ZGMuY29tIC0+IHBhdGNoZXcvMjAyMDA1MTYwNjM3NDYuMTgyOTYtMS1hbnVwLnBhdGVs
QHdkYy5jb20KICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy9jb3Zlci4xNTg5OTIzNzg1Lmdp
dC5hbGlzdGFpci5mcmFuY2lzQHdkYy5jb20gLT4gcGF0Y2hldy9jb3Zlci4xNTg5OTIzNzg1Lmdp
dC5hbGlzdGFpci5mcmFuY2lzQHdkYy5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwpjNzRlNTFkIHNvZnRmbG9hdDogUmV0dXJuIGJvb2wgZnJvbSBhbGwgY2xhc3NpZmljYXRpb24g
cHJlZGljYXRlcwo3OTZkYTE0IHNvZnRmbG9hdDogSW5saW5lIGZsb2F0eDgwIGNvbXBhcmUgc3Bl
Y2lhbGl6YXRpb25zCmYzMTk3ZDMgc29mdGZsb2F0OiBJbmxpbmUgZmxvYXQxMjggY29tcGFyZSBz
cGVjaWFsaXphdGlvbnMKYzRlMDZhYiBzb2Z0ZmxvYXQ6IElubGluZSBmbG9hdDY0IGNvbXBhcmUg
c3BlY2lhbGl6YXRpb25zCjY1YWRjYWUgc29mdGZsb2F0OiBJbmxpbmUgZmxvYXQzMiBjb21wYXJl
IHNwZWNpYWxpemF0aW9ucwo0YWZiMDRlIHNvZnRmbG9hdDogTmFtZSBjb21wYXJlIHJlbGF0aW9u
IGVudW0KNTM4M2U1ZSBzb2Z0ZmxvYXQ6IE5hbWUgcm91bmRpbmcgbW9kZSBlbnVtCmFmOWU3ZmQg
c29mdGZsb2F0OiBDaGFuZ2UgdGluaW5lc3NfYmVmb3JlX3JvdW5kaW5nIHRvIGJvb2wKODc2ZGRm
OCBzb2Z0ZmxvYXQ6IFJlcGxhY2UgZmxhZyB3aXRoIGJvb2wKODAyZDdhNyBzb2Z0ZmxvYXQ6IFVz
ZSBwb3N0IHRlc3QgZm9yIGZsb2F0Tl9tdWwKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTAgQ2hl
Y2tpbmcgY29tbWl0IDgwMmQ3YTczYTE4YiAoc29mdGZsb2F0OiBVc2UgcG9zdCB0ZXN0IGZvciBm
bG9hdE5fbXVsKQoyLzEwIENoZWNraW5nIGNvbW1pdCA4NzZkZGY4ZjgzY2UgKHNvZnRmbG9hdDog
UmVwbGFjZSBmbGFnIHdpdGggYm9vbCkKMy8xMCBDaGVja2luZyBjb21taXQgYWY5ZTdmZGZkYWVk
IChzb2Z0ZmxvYXQ6IENoYW5nZSB0aW5pbmVzc19iZWZvcmVfcm91bmRpbmcgdG8gYm9vbCkKRVJS
T1I6IHNwYWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQgY2xvc2UgcGFyZW50aGVzaXMgJyknCiM2
ODogRklMRTogZnB1L3NvZnRmbG9hdC5jOjM4Nzc6CisgICAgICAgICAgICAgICAgICB8fCAoekV4
cCA8IDAgKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNDMgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggMy8xMCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNC8xMCBDaGVja2luZyBjb21t
aXQgNTM4M2U1ZWNmMWUzIChzb2Z0ZmxvYXQ6IE5hbWUgcm91bmRpbmcgbW9kZSBlbnVtKQo1LzEw
IENoZWNraW5nIGNvbW1pdCA0YWZiMDRlNDJjMjEgKHNvZnRmbG9hdDogTmFtZSBjb21wYXJlIHJl
bGF0aW9uIGVudW0pCjYvMTAgQ2hlY2tpbmcgY29tbWl0IDY1YWRjYWU2YTI5MCAoc29mdGZsb2F0
OiBJbmxpbmUgZmxvYXQzMiBjb21wYXJlIHNwZWNpYWxpemF0aW9ucykKNy8xMCBDaGVja2luZyBj
b21taXQgYzRlMDZhYmM0YzA5IChzb2Z0ZmxvYXQ6IElubGluZSBmbG9hdDY0IGNvbXBhcmUgc3Bl
Y2lhbGl6YXRpb25zKQo4LzEwIENoZWNraW5nIGNvbW1pdCBmMzE5N2QzYWQ4ODQgKHNvZnRmbG9h
dDogSW5saW5lIGZsb2F0MTI4IGNvbXBhcmUgc3BlY2lhbGl6YXRpb25zKQo5LzEwIENoZWNraW5n
IGNvbW1pdCA3OTZkYTE0OWI3MjEgKHNvZnRmbG9hdDogSW5saW5lIGZsb2F0eDgwIGNvbXBhcmUg
c3BlY2lhbGl6YXRpb25zKQoxMC8xMCBDaGVja2luZyBjb21taXQgYzc0ZTUxZDBlZDBkIChzb2Z0
ZmxvYXQ6IFJldHVybiBib29sIGZyb20gYWxsIGNsYXNzaWZpY2F0aW9uIHByZWRpY2F0ZXMpCj09
PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTE5
MTY0OTU3LjI2OTIwLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNr
cGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

