Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A1BC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496F422268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496F422268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVRO-0006ME-69
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVOG-0002oO-6R; Mon, 19 Oct 2020 09:39:56 -0400
Resent-Date: Mon, 19 Oct 2020 09:39:56 -0400
Resent-Message-Id: <E1kUVOG-0002oO-6R@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVOE-0006iR-DL; Mon, 19 Oct 2020 09:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603114780; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fQnpvH2VtWmgC01/4ewusmyAXV7TcRelfbXFX82rUrEy19vwCzKvXivPXm9TSJz/yhPS4FKXsVg2gV3JinQtECeMQMSKGYEE4JXzCs67DY2AI9hENDhpnfq2Lch4deSyQ6KUbxjYZFcOe81Py96Nstsrg9t78OzUi39MZ12ZIIM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603114780;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WHFWadXI/9r1/WMriOBY/4s/QmNvN/CWwGjUfHnCde4=; 
 b=Mlud4/lrpwvM95bCbpaI/tZMaGBpTCsxS3bMAYIqK8kJ3OQKXAX+36oDLNoW3lK/u9CNHhv1aPtRDUNHcdTw1cz4KLCEoeFcQk1GSwlZXLhdMrum67SBDEvq+mEFDOxDEOluzoKdsq3ZwxZsi59D2RzffKeCDRNWAisbgy5sias=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603114779192791.4191051684667;
 Mon, 19 Oct 2020 06:39:39 -0700 (PDT)
Subject: Re: [PATCH] virtio-iommu: fix incorrect print type
Message-ID: <160311477740.18439.1188807654389468914@66eaa9a8a123>
In-Reply-To: <1603114311-7392-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Mon, 19 Oct 2020 06:39:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 09:36:59
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
Cc: kwolf@redhat.com, xieyingtai@huawei.com, lizhengui@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAzMTE0MzExLTczOTItMS1n
aXQtc2VuZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE2MDMxMTQz
MTEtNzM5Mi0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWkuY29tClN1YmplY3Q6IFtQ
QVRDSF0gdmlydGlvLWlvbW11OiBmaXggaW5jb3JyZWN0IHByaW50IHR5cGUKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMTYwMzExNDI5Mi0xMDMzMi0xLWdp
dC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWkuY29tIC0+IHBhdGNoZXcvMTYwMzExNDI5Mi0x
MDMzMi0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWkuY29tCiAqIFtuZXcgdGFnXSAg
ICAgICAgIHBhdGNoZXcvMTYwMzExNDMxMS03MzkyLTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3Vp
QGh1YXdlaS5jb20gLT4gcGF0Y2hldy8xNjAzMTE0MzExLTczOTItMS1naXQtc2VuZC1lbWFpbC1s
aXpoZW5ndWlAaHVhd2VpLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM2MWE4
NDggdmlydGlvLWlvbW11OiBmaXggaW5jb3JyZWN0IHByaW50IHR5cGUKCj09PSBPVVRQVVQgQkVH
SU4gPT09CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVy
cm9ycywgMCB3YXJuaW5ncywgMjQgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGM2MWE4NDg3ZjQzNSAo
dmlydGlvLWlvbW11OiBmaXggaW5jb3JyZWN0IHByaW50IHR5cGUpIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzE2MDMxMTQzMTEtNzM5Mi0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWkuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

