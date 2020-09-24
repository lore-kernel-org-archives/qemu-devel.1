Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E97AC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833B221481
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833B221481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLZyw-0001sw-NN
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 18:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLZy7-0001G1-1E; Thu, 24 Sep 2020 18:44:03 -0400
Resent-Date: Thu, 24 Sep 2020 18:44:03 -0400
Resent-Message-Id: <E1kLZy7-0001G1-1E@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLZy4-0004rZ-L0; Thu, 24 Sep 2020 18:44:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600987420; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VaAagVwY5LiwQWDjy0u18sKH/esTfLju1yER37uQtbMM3v2V/jMAXMzNe7YvNxmC/wwa/KqCX6N+CLpMjZ2B6Sya42iko966TyVZNtmre+z2BbB9C1ZM3SaTBc0patVZT/o4BUStFG6E/7EYlBOTTMbDjzeVOCACJZjFpkAtuBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600987420;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wobeHmw3x6cxpzN1M1riI0CdEgZWUkmbnakiZ2tfGXE=; 
 b=O5qNtCPoaApEYXsnlHQwacHz47vJOTuCl6nzUZARkooQ6i3s0OFTOB+ljlJjuj4DHkBnpJxwLqoQmWvZaaMSWa2GA56MOtz+eFKBvVVJTwgmBlFP9jYNQWeUgorwqxYgjqloEmbuay2lx2QfDVwuLNwE9hhqEu3aoUyASkA8/58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600987418691974.638661617943;
 Thu, 24 Sep 2020 15:43:38 -0700 (PDT)
Subject: Re: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Message-ID: <160098741693.12744.661899168797123531@66eaa9a8a123>
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: its@irrelevant.dk
Date: Thu, 24 Sep 2020 15:43:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:30:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 k.jensen@samsung.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 its@irrelevant.dk, kbusch@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNDIwNDUxNi4xODgx
ODQzLTEtaXRzQGlycmVsZXZhbnQuZGsvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDkyNDIwNDUxNi4xODgx
ODQzLTEtaXRzQGlycmVsZXZhbnQuZGsKU3ViamVjdDogW1BBVENIIDAwLzE2XSBody9ibG9jay9u
dm1lOiB6b25lZCBuYW1lc3BhY2UgY29tbWFuZCBzZXQKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYTU5YjRiYiBody9ibG9jay9u
dm1lOiBzdXBwb3J0IHJlc2V0L2ZpbmlzaCByZWNvbW1lbmRlZCBsaW1pdHMKODNkNzhiZiBody9i
bG9jay9udm1lOiBzdXBwb3J0IHpvbmUgYWN0aXZlIGV4Y3Vyc2lvbnMKZWI5ODUyZSBody9ibG9j
ay9udm1lOiBhbGxvdyBvcGVuIHRvIGNsb3NlIHRyYW5zaXRpb25zIGJ5IGNvbnRyb2xsZXIKNDAx
ODIyOCBody9ibG9jay9udm1lOiB0cmFjayBhbmQgZW5mb3JjZSB6b25lIHJlc291cmNlcwozZjkz
NGU4IGh3L2Jsb2NrL252bWU6IGFkZCB0aGUgem9uZSBhcHBlbmQgY29tbWFuZAo2MzQzZDg5IGh3
L2Jsb2NrL252bWU6IGFkZCB0aGUgem9uZSBtYW5hZ2VtZW50IHNlbmQgY29tbWFuZAphNTI3ZWVm
IGh3L2Jsb2NrL252bWU6IGFkZCB0aGUgem9uZSBtYW5hZ2VtZW50IHJlY2VpdmUgY29tbWFuZApm
ZDAzMmY5IGh3L2Jsb2NrL252bWU6IGFkZCBiYXNpYyByZWFkL3dyaXRlIGZvciB6b25lZCBuYW1l
c3BhY2VzCmFlZjY1MTEgaHcvYmxvY2svbnZtZTogc3VwcG9ydCBuYW1lc3BhY2UgdHlwZXMKYWI0
YzExOSBody9ibG9jay9udm1lOiBhZGQgY29tbWFuZHMgc3VwcG9ydGVkIGFuZCBlZmZlY3RzIGxv
ZyBwYWdlCjNlYjU2YTAgaHcvYmxvY2svbnZtZTogYWRkIHN1cHBvcnQgZm9yIGR1bGJlIGFuZCBi
bG9jayB1dGlsaXphdGlvbiB0cmFja2luZwpiNTMyZmUwIGh3L2Jsb2NrL252bWU6IGNvbnNvbGlk
YXRlIHJlYWQsIHdyaXRlIGFuZCB3cml0ZSB6ZXJvZXMKZTk5MjA4MiBody9ibG9jay9udm1lOiBy
ZWplY3QgaW8gY29tbWFuZHMgaWYgb25seSBhZG1pbiBjb21tYW5kIHNldCBzZWxlY3RlZAo4YTE5
ZTA4IGh3L2Jsb2NrL252bWU6IG1ha2UgbGJhIGRhdGEgc2l6ZSBjb25maWd1cmFibGUKM2VkZmIx
MSBody9ibG9jay9udm1lOiBhZGQgdHJhY2UgZXZlbnQgZm9yIHJlcXVlc3RzIHdpdGggbm9uLXpl
cm8gc3RhdHVzIGNvZGUKOGRlMDAzMSBody9ibG9jay9udm1lOiBhZGQgbnNpZCB0byBnZXQvc2V0
ZmVhdCB0cmFjZSBldmVudHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hlY2tpbmcgY29t
bWl0IDhkZTAwMzE4MzE3ZCAoaHcvYmxvY2svbnZtZTogYWRkIG5zaWQgdG8gZ2V0L3NldGZlYXQg
dHJhY2UgZXZlbnRzKQoyLzE2IENoZWNraW5nIGNvbW1pdCAzZWRmYjExMTA3MTMgKGh3L2Jsb2Nr
L252bWU6IGFkZCB0cmFjZSBldmVudCBmb3IgcmVxdWVzdHMgd2l0aCBub24temVybyBzdGF0dXMg
Y29kZSkKMy8xNiBDaGVja2luZyBjb21taXQgOGExOWUwOGFmZWI3IChody9ibG9jay9udm1lOiBt
YWtlIGxiYSBkYXRhIHNpemUgY29uZmlndXJhYmxlKQo0LzE2IENoZWNraW5nIGNvbW1pdCBlOTky
MDgyYmI5YmYgKGh3L2Jsb2NrL252bWU6IHJlamVjdCBpbyBjb21tYW5kcyBpZiBvbmx5IGFkbWlu
IGNvbW1hbmQgc2V0IHNlbGVjdGVkKQo1LzE2IENoZWNraW5nIGNvbW1pdCBiNTMyZmUwN2ExNTcg
KGh3L2Jsb2NrL252bWU6IGNvbnNvbGlkYXRlIHJlYWQsIHdyaXRlIGFuZCB3cml0ZSB6ZXJvZXMp
CjYvMTYgQ2hlY2tpbmcgY29tbWl0IDNlYjU2YTA3NDhmYiAoaHcvYmxvY2svbnZtZTogYWRkIHN1
cHBvcnQgZm9yIGR1bGJlIGFuZCBibG9jayB1dGlsaXphdGlvbiB0cmFja2luZykKNy8xNiBDaGVj
a2luZyBjb21taXQgYWI0YzExOWQ5ZDY4IChody9ibG9jay9udm1lOiBhZGQgY29tbWFuZHMgc3Vw
cG9ydGVkIGFuZCBlZmZlY3RzIGxvZyBwYWdlKQpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2
YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM0NjogRklMRTogaHcvYmxv
Y2svbnZtZS5jOjEzMToKKyNkZWZpbmUgTlZNRV9FRkZFQ1RTX05WTV9JTklUSUFMSVpFUiAgICAg
ICAgICAgICAgICAgICBcCisgICAgW05WTUVfQ01EX0ZMVVNIXSAgICAgICAgICAgID0gTlZNRV9F
RkZFQ1RTX0NTVVBQIHwgXAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUVf
RUZGRUNUU19MQkNDLCAgIFwKKyAgICBbTlZNRV9DTURfV1JJVEVdICAgICAgICAgICAgPSBOVk1F
X0VGRkVDVFNfQ1NVUFAgfCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZN
RV9FRkZFQ1RTX0xCQ0MsICAgXAorICAgIFtOVk1FX0NNRF9SRUFEXSAgICAgICAgICAgICA9IE5W
TUVfRUZGRUNUU19DU1VQUCwgIFwKKyAgICBbTlZNRV9DTURfV1JJVEVfWkVST0VTXSAgICAgPSBO
Vk1FX0VGRkVDVFNfQ1NVUFAgfCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
TlZNRV9FRkZFQ1RTX0xCQ0MKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTQ5IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDcvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjgvMTYgQ2hl
Y2tpbmcgY29tbWl0IGFlZjY1MTFiZTgyYiAoaHcvYmxvY2svbnZtZTogc3VwcG9ydCBuYW1lc3Bh
Y2UgdHlwZXMpCjkvMTYgQ2hlY2tpbmcgY29tbWl0IGZkMDMyZjkxOGIzNyAoaHcvYmxvY2svbnZt
ZTogYWRkIGJhc2ljIHJlYWQvd3JpdGUgZm9yIHpvbmVkIG5hbWVzcGFjZXMpCjEwLzE2IENoZWNr
aW5nIGNvbW1pdCBhNTI3ZWVmOWI5ZmUgKGh3L2Jsb2NrL252bWU6IGFkZCB0aGUgem9uZSBtYW5h
Z2VtZW50IHJlY2VpdmUgY29tbWFuZCkKMTEvMTYgQ2hlY2tpbmcgY29tbWl0IDYzNDNkODliZjcz
NCAoaHcvYmxvY2svbnZtZTogYWRkIHRoZSB6b25lIG1hbmFnZW1lbnQgc2VuZCBjb21tYW5kKQpX
QVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGlu
ZQojNjY6IEZJTEU6IGh3L2Jsb2NrL252bWUuYzoxMTE4OgorICAgIHJldHVybiBfX252bWVfYWxs
b2NhdGUobnMsIHNsYmEsIG5sYiwgZmFsc2UgLyogZGVhbGxvY2F0ZSAqLyk7CgpXQVJOSU5HOiBC
bG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNzc6IEZJ
TEU6IGh3L2Jsb2NrL252bWUuYzoxMTI5OgorICAgIHJldHVybiBfX252bWVfYWxsb2NhdGUobnMs
IHNsYmEsIG5sYiwgdHJ1ZSAvKiBkZWFsbG9jYXRlICovKTsKCnRvdGFsOiAwIGVycm9ycywgMiB3
YXJuaW5ncywgNzA0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDExLzE2IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCjEyLzE2IENoZWNraW5nIGNvbW1pdCAzZjkzNGU4OTU2NGEgKGh3L2Jsb2NrL252
bWU6IGFkZCB0aGUgem9uZSBhcHBlbmQgY29tbWFuZCkKMTMvMTYgQ2hlY2tpbmcgY29tbWl0IDQw
MTgyMjg3ZDE1ZSAoaHcvYmxvY2svbnZtZTogdHJhY2sgYW5kIGVuZm9yY2Ugem9uZSByZXNvdXJj
ZXMpCjE0LzE2IENoZWNraW5nIGNvbW1pdCBlYjk4NTJlZTljMGYgKGh3L2Jsb2NrL252bWU6IGFs
bG93IG9wZW4gdG8gY2xvc2UgdHJhbnNpdGlvbnMgYnkgY29udHJvbGxlcikKMTUvMTYgQ2hlY2tp
bmcgY29tbWl0IDgzZDc4YmY1MzM5MiAoaHcvYmxvY2svbnZtZTogc3VwcG9ydCB6b25lIGFjdGl2
ZSBleGN1cnNpb25zKQoxNi8xNiBDaGVja2luZyBjb21taXQgYTU5YjRiYjJjODU1IChody9ibG9j
ay9udm1lOiBzdXBwb3J0IHJlc2V0L2ZpbmlzaCByZWNvbW1lbmRlZCBsaW1pdHMpCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTI0MjA0NTE2
LjE4ODE4NDMtMS1pdHNAaXJyZWxldmFudC5kay90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

