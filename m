Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDC3C433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A202067D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A202067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRxV-0003gb-2q
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvRwu-0002mp-7W
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:54:48 -0400
Resent-Date: Tue, 14 Jul 2020 16:54:48 -0400
Resent-Message-Id: <E1jvRwu-0002mp-7W@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvRwq-0003Ue-Dv
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:54:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594760072; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mGu95dcJ6DVJtfdZhNuP6JSDzqxBr7HV32Wmuqzk9OmDKPb/Ibpo21tc0swZA58ulPTsCZj3gJtweSbUxCKZchqNTG2UCntxJ3wQECfKJVL7BKGV+qqbcEUsQpGSRIrSAzeirnasdOd4XI3NOfBtrUwV/lrNWjReh+qL0kM9PBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594760072;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hpaGPo/DF3Jw9JT2efN6fyjMJdOmHBXjMm1HwX5ARnA=; 
 b=kzyrjSbjFS40uf8X0wjxJ2n88lZZDwC7ENaqKGJVtC4v34RvA6g7wNIjQJe0/UrICoWerpmFuTHrkOFJOHgmdIbIIM2m7W05aVF2Cg7fKYPqvp7QWFT/zMda07fa74Vtnp7SV0pJ88XO26UW5kbUnDyTmEgaAyEpbE3IS10GTA8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594760070798381.2792955351945;
 Tue, 14 Jul 2020 13:54:30 -0700 (PDT)
Subject: Re: [PATCH] linux-user: Add strace support for printing arguments for
 ioctls used for terminals and serial lines
Message-ID: <159476006968.11884.18325341812064512094@07a7f0d89f7d>
In-Reply-To: <20200714200439.11328-1-Filip.Bozuta@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Filip.Bozuta@syrmia.com
Date: Tue, 14 Jul 2020 13:54:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 16:54:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, Filip.Bozuta@syrmia.com,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDIwMDQzOS4xMTMy
OC0xLUZpbGlwLkJvenV0YUBzeXJtaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA3MTQyMDA0Mzku
MTEzMjgtMS1GaWxpcC5Cb3p1dGFAc3lybWlhLmNvbQpTdWJqZWN0OiBbUEFUQ0hdIGxpbnV4LXVz
ZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIGZvciBpb2N0bHMg
dXNlZCBmb3IgdGVybWluYWxzIGFuZCBzZXJpYWwgbGluZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogICBkMjYyOGIxLi44YmZhMjVhICBtYXN0ZXIgICAgIC0+IG1hc3RlcgpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmFlOWYxOWEgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBw
b3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgZm9yIGlvY3RscyB1c2VkIGZvciB0ZXJtaW5hbHMg
YW5kIHNlcmlhbCBsaW5lcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IHN0b3JhZ2UgY2xh
c3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM3NTogRklM
RTogbGludXgtdXNlci9zdHJhY2UuYzoxMTk2OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3Mg
dGVybWlvc19pZmxhZ3NbXSA9IHsKCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0
aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojOTM6IEZJTEU6IGxpbnV4LXVzZXIvc3Ry
YWNlLmM6MTIxNDoKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHRlcm1pb3Nfb2ZsYWdzW10g
PSB7CgpFUlJPUjogc3RvcmFnZSBjbGFzcyBzaG91bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0
aGUgZGVjbGFyYXRpb24KIzEwNTogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzoxMjI2OgorVU5V
U0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3MgdGVybWlvc19vZmxhZ3NfTkxETFlbXSA9IHsKCkVSUk9S
OiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJh
dGlvbgojMTExOiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjEyMzI6CitVTlVTRUQgc3RhdGlj
IHN0cnVjdCBmbGFncyB0ZXJtaW9zX29mbGFnc19DUkRMWVtdID0gewoKRVJST1I6IHN0b3JhZ2Ug
Y2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiMxMTk6
IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6MTI0MDoKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZs
YWdzIHRlcm1pb3Nfb2ZsYWdzX1RBQkRMWVtdID0gewoKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hv
dWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiMxMjc6IEZJTEU6IGxp
bnV4LXVzZXIvc3RyYWNlLmM6MTI0ODoKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHRlcm1p
b3Nfb2ZsYWdzX1ZURExZW10gPSB7CgpFUlJPUjogc3RvcmFnZSBjbGFzcyBzaG91bGQgYmUgYXQg
dGhlIGJlZ2lubmluZyBvZiB0aGUgZGVjbGFyYXRpb24KIzEzMzogRklMRTogbGludXgtdXNlci9z
dHJhY2UuYzoxMjU0OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3MgdGVybWlvc19vZmxhZ3Nf
RkZETFlbXSA9IHsKCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5u
aW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojMTM5OiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjEy
NjA6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyB0ZXJtaW9zX29mbGFnc19CU0RMWVtdID0g
ewoKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhl
IGRlY2xhcmF0aW9uCiMxNDU6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6MTI2NjoKK1VOVVNF
RCBzdGF0aWMgc3RydWN0IGZsYWdzIHRlcm1pb3NfY2ZsYWdzX0NCQVVEW10gPSB7CgpFUlJPUjog
c3RvcmFnZSBjbGFzcyBzaG91bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZGVjbGFyYXRp
b24KIzE2OTogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzoxMjkwOgorVU5VU0VEIHN0YXRpYyBz
dHJ1Y3QgZmxhZ3MgdGVybWlvc19jZmxhZ3NfQ1NJWkVbXSA9IHsKCkVSUk9SOiBzdG9yYWdlIGNs
YXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojMTc3OiBG
SUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjEyOTg6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFn
cyB0ZXJtaW9zX2NmbGFnc1tdID0gewoKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0
IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiMxODg6IEZJTEU6IGxpbnV4LXVzZXIv
c3RyYWNlLmM6MTMwOToKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIHRlcm1pb3NfbGZsYWdz
W10gPSB7Cgp0b3RhbDogMTIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNjAgbGluZXMgY2hlY2tlZAoK
Q29tbWl0IGFlOWYxOWExNjVhNiAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBw
cmludGluZyBhcmd1bWVudHMgZm9yIGlvY3RscyB1c2VkIGZvciB0ZXJtaW5hbHMgYW5kIHNlcmlh
bCBsaW5lcykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3MTQyMDA0MzkuMTEzMjgtMS1GaWxp
cC5Cb3p1dGFAc3lybWlhLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

