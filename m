Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D30C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9071204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 21:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9071204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joZL7-0001JK-7p
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 17:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joZKP-0000gU-7l; Thu, 25 Jun 2020 17:22:37 -0400
Resent-Date: Thu, 25 Jun 2020 17:22:37 -0400
Resent-Message-Id: <E1joZKP-0000gU-7l@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joZKM-0003Fm-KU; Thu, 25 Jun 2020 17:22:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593120146; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b0nnHNge/WQvmk8+9MeQ4NbgjuYu9/TTLaWdFGCb3GZ4bV+OTh0nPK5v5ZC/N9foTmM6s6YHtJFUKf/M3Tvif4IhWMzsrtW0QtjQaFg0iBzftFM1jZRnha5FiZKS2/MLW2tDvJ5QkpUW8cHlx53wR9qyV8uwHnf2YjV5I4tbPu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593120146;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6qoZIOOitOJl56z84ZVbSBxC3QoL3PX2x8VkX7NACj4=; 
 b=eODfYOouinePP2hxZ+wWVhCvUTuLBVDXpSsTBWaJpUM0YKeCoaUDQBJ//ER/7+XZYRettKT/EPGCsLwbwsa7WcdEwoAq3KLqqsGIcrLfexooXjGxZGxQW/+ry6Po9vBskzbBoNoryL3v9UsoxGrVHg+5A3LKNQtLGE18sWckvAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593120144657693.9685306877296;
 Thu, 25 Jun 2020 14:22:24 -0700 (PDT)
Message-ID: <159312014357.25974.16788442518938857222@d1fd068a5071>
Subject: Re: [PATCH v2] build: Haiku build fix
In-Reply-To: <CA+XhMqy_bAnWm3cByobn+4LkVoAEZk3DU2=kWBcdB4m1b2Cd0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: devnexen@gmail.com
Date: Thu, 25 Jun 2020 14:22:24 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 17:22:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9DQStYaE1xeV9iQW5XbTNjQnlv
Ym4rNExrVm9BRVprM0RVMj1rV0JjZEI0bTFiMkNkMGdAbWFpbC5nbWFpbC5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2Vl
IG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2Ml0g
YnVpbGQ6IEhhaWt1IGJ1aWxkIGZpeApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogQ0ErWGhNcXlf
YkFuV20zY0J5b2JuKzRMa1ZvQUVaazNEVTI9a1dCY2RCNG0xYjJDZDBnQG1haWwuZ21haWwuY29t
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFz
ZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1
Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgYmVhZmFiOC4uNjNkMjExOSAgbWFzdGVyICAg
ICAtPiBtYXN0ZXIKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy9DQStYaE1xeV9iQW5XbTNjQnlvYm4rNExrVm9B
RVprM0RVMj1rV0JjZEI0bTFiMkNkMGdAbWFpbC5nbWFpbC5jb20gLT4gcGF0Y2hldy9DQStYaE1x
eV9iQW5XbTNjQnlvYm4rNExrVm9BRVprM0RVMj1rV0JjZEI0bTFiMkNkMGdAbWFpbC5nbWFpbC5j
b20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2NWFjOTNhIGJ1aWxkOiBIYWlrdSBi
dWlsZCBmaXgKCj09PSBPVVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVj
aWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiM5ODogRklMRTogaW5jbHVkZS9xZW11L29z
ZGVwLmg6MzkxOgorI2lmIGRlZmluZWQoX19IQUlLVV9fKQoKRVJST1I6IHJldHVybiBvZiBhbiBl
cnJubyBzaG91bGQgdHlwaWNhbGx5IGJlIC12ZSAocmV0dXJuIC1FTk9TWVMpCiMxMjI6IEZJTEU6
IG9zLXBvc2l4LmM6MzUwOgorICAgIHJldHVybiBFTk9TWVM7CgpXQVJOSU5HOiBhcmNoaXRlY3R1
cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAojMTcyOiBGSUxFOiB1dGlsL29z
bGliLXBvc2l4LmM6NDE6CisjaWYgIWRlZmluZWQoX19IQUlLVV9fKQoKdG90YWw6IDEgZXJyb3Jz
LCAyIHdhcm5pbmdzLCAxNDkgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDY1YWM5M2E2YmZlMiAoYnVp
bGQ6IEhhaWt1IGJ1aWxkIGZpeCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvQ0ErWGhNcXlfYkFuV20z
Y0J5b2JuKzRMa1ZvQUVaazNEVTI9a1dCY2RCNG0xYjJDZDBnQG1haWwuZ21haWwuY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

