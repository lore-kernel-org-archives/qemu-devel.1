Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75685C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD36A222E9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD36A222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVUx-0006kq-Pw
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVVU8-0005ne-Uc; Thu, 22 Oct 2020 03:58:08 -0400
Resent-Date: Thu, 22 Oct 2020 03:58:08 -0400
Resent-Message-Id: <E1kVVU8-0005ne-Uc@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVVU6-0004Wz-9e; Thu, 22 Oct 2020 03:58:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603353466; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TMJQS2b/H1/dUorQs0rypTWeQV0hqyNcH3hL9Qe6vwW5qRLdhu/eEKu2+O+rioNt5+g/fYA3BaYrkES1UzzyC2cScpI8E8dJfQF8LYNV8laoRAlAC3+xI2phayKn7gIRmKdqL0XtiKkxFBj0UtEvysEZhrmq7mOO5yPCu3JtigY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603353466;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Agw1BmAkyR9fOmBWzkX2bfJnMP1FtLVlbOgRnLjlSow=; 
 b=npTiaDj9USR2YofIKTWdwJm4Bo2W+9RB7+fc6p5UnPca2wvLgd9sv0sREAkZopvbcN+1LgAbyt/aAVJCXxCsryeCtxNlyksD/ou134WWiBM5hyQxsFOx7I/T0DNrJdD2xsnWa3quQaib6bIhVkekc+pCXnagUiDy2CCNnM0Ax4E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603353463609125.03576959874738;
 Thu, 22 Oct 2020 00:57:43 -0700 (PDT)
Subject: Re: [PATCH v5 0/6] RISC-V Pointer Masking implementation
Message-ID: <160335346176.17333.13931347745695572993@66eaa9a8a123>
In-Reply-To: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: baturo.alexey@gmail.com
Date: Thu, 22 Oct 2020 00:57:43 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 03:58:03
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAyMjA3NDMwOS4zMjEw
LTEtc3BhY2UubW9ua2V5LmRlbGl2ZXJzQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAxMDIy
MDc0MzA5LjMyMTAtMS1zcGFjZS5tb25rZXkuZGVsaXZlcnNAZ21haWwuY29tClN1YmplY3Q6IFtQ
QVRDSCB2NSAwLzZdIFJJU0MtViBQb2ludGVyIE1hc2tpbmcgaW1wbGVtZW50YXRpb24KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXct
cHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDEwMjExNjMxMzYu
MjczMjQtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAyMDEwMjExNjMxMzYu
MjczMjQtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNo
ZXcvMjAyMDEwMjEyMTI3MjEuNDQwMzczLTEtcGV0ZXJ4QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8y
MDIwMTAyMTIxMjcyMS40NDAzNzMtMS1wZXRlcnhAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAg
ICAgICBwYXRjaGV3LzIwMjAxMDIyMDc0MzA5LjMyMTAtMS1zcGFjZS5tb25rZXkuZGVsaXZlcnNA
Z21haWwuY29tIC0+IHBhdGNoZXcvMjAyMDEwMjIwNzQzMDkuMzIxMC0xLXNwYWNlLm1vbmtleS5k
ZWxpdmVyc0BnbWFpbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowNDdkODBi
IEFsbG93IGV4cGVyaW1lbnRhbCBKLWV4dCB0byBiZSB0dXJuZWQgb24KMmY3YTg5NSBJbXBsZW1l
bnQgYWRkcmVzcyBtYXNraW5nIGZ1bmN0aW9ucyByZXF1aXJlZCBmb3IgUklTQy1WIFBvaW50ZXIg
TWFza2luZyBleHRlbnNpb24KNjhkMzVjMiBTdXBwb3J0IHBvaW50ZXIgbWFza2luZyBmb3IgUklT
Qy1WIGZvciBpL2MvZi9kL2EgdHlwZXMgb2YgaW5zdHJ1Y3Rpb25zCjE5YjYxN2YgUHJpbnQgbmV3
IFBNIENTUnMgaW4gUUVNVSBsb2dzCjk3YmZlZjEgU3VwcG9ydCBDU1JzIHJlcXVpcmVkIGZvciBS
SVNDLVYgUE0gZXh0ZW5zaW9uIGV4Y2VwdCBmb3Igb25lcyBpbiBoeXBlcnZpc29yIG1vZGUKYTAy
ODEzYyBBZGQgSi1leHRlbnNpb24gaW50byBSSVNDLVYKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
NiBDaGVja2luZyBjb21taXQgYTAyODEzYzA1ZGFjIChBZGQgSi1leHRlbnNpb24gaW50byBSSVND
LVYpCkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMjEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS82IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgoyLzYgQ2hlY2tpbmcgY29tbWl0IDk3YmZlZjE4NDI5OSAoU3VwcG9ydCBD
U1JzIHJlcXVpcmVkIGZvciBSSVNDLVYgUE0gZXh0ZW5zaW9uIGV4Y2VwdCBmb3Igb25lcyBpbiBo
eXBlcnZpc29yIG1vZGUpCjMvNiBDaGVja2luZyBjb21taXQgMTliNjE3ZmMyZDQwIChQcmludCBu
ZXcgUE0gQ1NScyBpbiBRRU1VIGxvZ3MpCjQvNiBDaGVja2luZyBjb21taXQgNjhkMzVjMjRlMGQ0
IChTdXBwb3J0IHBvaW50ZXIgbWFza2luZyBmb3IgUklTQy1WIGZvciBpL2MvZi9kL2EgdHlwZXMg
b2YgaW5zdHJ1Y3Rpb25zKQo1LzYgQ2hlY2tpbmcgY29tbWl0IDJmN2E4OTU5NDliOCAoSW1wbGVt
ZW50IGFkZHJlc3MgbWFza2luZyBmdW5jdGlvbnMgcmVxdWlyZWQgZm9yIFJJU0MtViBQb2ludGVy
IE1hc2tpbmcgZXh0ZW5zaW9uKQo2LzYgQ2hlY2tpbmcgY29tbWl0IDA0N2Q4MGJhNjRhNCAoQWxs
b3cgZXhwZXJpbWVudGFsIEotZXh0IHRvIGJlIHR1cm5lZCBvbikKPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDEwMjIwNzQzMDkuMzIxMC0xLXNw
YWNlLm1vbmtleS5kZWxpdmVyc0BnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t

