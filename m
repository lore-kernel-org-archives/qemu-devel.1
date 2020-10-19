Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855EC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EBA208B3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EBA208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVQR-0004lG-8l
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVOu-0003Vq-LK; Mon, 19 Oct 2020 09:40:36 -0400
Resent-Date: Mon, 19 Oct 2020 09:40:36 -0400
Resent-Message-Id: <E1kUVOu-0003Vq-LK@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVOs-0006tV-86; Mon, 19 Oct 2020 09:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603114819; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k3l0B8gUZTq5wDW5Vbkj3qfrVcAXclEhML8IItEYpvAJw+Xfd/jcghIoQdktdzZnVx5JUcGntVwOopm9w2dFC0hM+up/cHqdt4k6fmes3nGMNlNKEak3CkpTRpQatWHRrXwVpaN/v9g8U7cSD9I3SSudPPE10cRubnC5DqMiBxk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603114819;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=tU6GZlUqHPrUdJ/56+YIh10XEUYIV1w90OmOJOK8Zcs=; 
 b=naKJ2mN7P9ax9FKBJ2pckzjOOECmxOG92iekWufZW5F2RyRdzExAWrEdSvIN0s6RFoXtwGwhfzDaopHiWqjpx0IJ++eVPlCH5UF9iyvKd3nPHPGNgnW3HSM6Cm+cA/601of62mYr6VJ6YBpU2FoF3Jvpb5aLgcoGepQ5YgpXMXg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603114815850379.7973253749889;
 Mon, 19 Oct 2020 06:40:15 -0700 (PDT)
Subject: Re: [PATCH] virtio-gpu: fix incorrect print type
Message-ID: <160311481433.18439.12060778603612145840@66eaa9a8a123>
In-Reply-To: <1603114292-10332-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Mon, 19 Oct 2020 06:40:15 -0700 (PDT)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAzMTE0MjkyLTEwMzMyLTEt
Z2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNjAzMTE0
MjkyLTEwMzMyLTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20KU3ViamVjdDog
W1BBVENIXSB2aXJ0aW8tZ3B1OiBmaXggaW5jb3JyZWN0IHByaW50IHR5cGUKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZGRmZDQ0
MyB2aXJ0aW8tZ3B1OiBmaXggaW5jb3JyZWN0IHByaW50IHR5cGUKCj09PSBPVVRQVVQgQkVHSU4g
PT09CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMTIyIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBkZGZkNDQzN2ZkNGQgKHZp
cnRpby1ncHU6IGZpeCBpbmNvcnJlY3QgcHJpbnQgdHlwZSkgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MTYwMzExNDI5Mi0xMDMzMi0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWkuY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

