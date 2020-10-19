Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD56C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037DB2223C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037DB2223C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVM5-0000J3-Vy
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVLU-0007yV-01; Mon, 19 Oct 2020 09:37:04 -0400
Resent-Date: Mon, 19 Oct 2020 09:37:04 -0400
Resent-Message-Id: <E1kUVLU-0007yV-01@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVLR-0006OE-GV; Mon, 19 Oct 2020 09:37:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603114602; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GPPW4j+Czt61+26Unc37vc1KcnjSU5LDS6ASIwAzuDjsB26BVVybMHuBF72nROlFcpCH1JcVoUdOHXyCi4BD6CD1Udj2v29inerhQyngwSCXcPM/qLEZxH+hrxz8G7qVNjLRXedGEVi1a5VuFCtFxzryDgflWG2DFbnPGAOV+ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603114602;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=XcdVHjiVlMw1qw+qeHYTjXjCaP1skuvrjXxAHpNrXhM=; 
 b=LksVCEigzYT2/XHCtmQZVgcNzqkUwBje5suITQkjw3qraCT3uBjFbQdAejJqTdylutM0S2yL6PlSYBmu1UMDwATY4fABTo1wgABbJqk0Usv/mvJB2d/ff84aqXr9DCcp2piaS2wdljB5zxDFy1a3kI8zQS6+bExJya3shKhGcOw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603114601228938.9513839584705;
 Mon, 19 Oct 2020 06:36:41 -0700 (PDT)
Subject: Re: [PATCH] vhost-user-gpu: incorrect print type
Message-ID: <160311459950.18439.6027847287513614770@66eaa9a8a123>
In-Reply-To: <1603114196-22776-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Mon, 19 Oct 2020 06:36:41 -0700 (PDT)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAzMTE0MTk2LTIyNzc2LTEt
Z2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNjAzMTE0
MTk2LTIyNzc2LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20KU3ViamVjdDog
W1BBVENIXSB2aG9zdC11c2VyLWdwdTogaW5jb3JyZWN0IHByaW50IHR5cGUKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMTYwMzExNDE5Ni0yMjc3Ni0xLWdp
dC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWkuY29tIC0+IHBhdGNoZXcvMTYwMzExNDE5Ni0y
Mjc3Ni0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWkuY29tCiAtIFt0YWcgdXBkYXRl
XSAgICAgIHBhdGNoZXcvMjAyMDA5MjgxNjA0MDIuNzk2MS0xLXBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZyAtPiBwYXRjaGV3LzIwMjAwOTI4MTYwNDAyLjc5NjEtMS1wZXRlci5tYXlkZWxsQGxpbmFy
by5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5YjJkZmNiIHZob3N0LXVzZXIt
Z3B1OiBpbmNvcnJlY3QgcHJpbnQgdHlwZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1p
c3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAxMzAgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDliMmRmY2I5NzllNiAodmhvc3QtdXNlci1ncHU6
IGluY29ycmVjdCBwcmludCB0eXBlKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VU
UFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNjAzMTE0MTk2LTIy
Nzc2LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vdGVzdGluZy5jaGVja3Bh
dGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

