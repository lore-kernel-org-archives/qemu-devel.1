Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B74C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA07D222BA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 13:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA07D222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVRk-0006pV-BH
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 09:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVQU-0005Hm-Ew; Mon, 19 Oct 2020 09:42:14 -0400
Resent-Date: Mon, 19 Oct 2020 09:42:14 -0400
Resent-Message-Id: <E1kUVQU-0005Hm-Ew@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUVQS-0007FF-6N; Mon, 19 Oct 2020 09:42:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603114882; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GGm6kWNAbau04tyJSJr5sr2IatLUhldURB5ux3vQLtJTOL4Mi+8UIJ5c+3MOV16oCCOv89iVUXczzyvST/6fwbSnH0z4B7Ur1cxTvhd+6AAVkQwXfxY38kGqLHxE/Zy5z1qVGbaoZX8LqBhNhCujotiu7CzcCFGmPLSsxB2iYeM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603114882;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=jJg/BWFJ8+fPr+bz8IGABqhwKuXi2v7mQIRFyIoDfiM=; 
 b=W0UWz9kG7m8CM2PO7rA8gJmp0trb2WPoELd7oZMZxKqpB3wbU9ocyhwHPYAX93WFx9+kDhxnSS/TTwmjylbiAEGP1GK/jdcwi5by1NVzlmnUdqZGCqxq+P7XmdtIShhrNMw3nvW68qhff2yOJZaZ2xA4dLIiz7unj8jvZSvE5p4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603114874670144.8958731198511;
 Mon, 19 Oct 2020 06:41:14 -0700 (PDT)
Subject: Re: [PATCH] vfio: fix incorrect print type
Message-ID: <160311487305.18439.2528176808895775156@66eaa9a8a123>
In-Reply-To: <1603114337-28056-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Mon, 19 Oct 2020 06:41:14 -0700 (PDT)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAzMTE0MzM3LTI4MDU2LTEt
Z2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNjAzMTE0
MzM3LTI4MDU2LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20KU3ViamVjdDog
W1BBVENIXSB2ZmlvOiBmaXggaW5jb3JyZWN0IHByaW50IHR5cGUKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
CiAgIGJhMmE5YTkuLjAwMGY1YjggIG1hc3RlciAgICAgLT4gbWFzdGVyCiAqIFtuZXcgdGFnXSAg
ICAgICAgIHBhdGNoZXcvMTYwMzExNDMzNy0yODA1Ni0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1
aUBodWF3ZWkuY29tIC0+IHBhdGNoZXcvMTYwMzExNDMzNy0yODA1Ni0xLWdpdC1zZW5kLWVtYWls
LWxpemhlbmd1aUBodWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYzg0
YTY5YyB2ZmlvOiBmaXggaW5jb3JyZWN0IHByaW50IHR5cGUKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgMTYgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGM4NGE2OWM2MjFiZCAodmZpbzog
Zml4IGluY29ycmVjdCBwcmludCB0eXBlKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNjAzMTE0MzM3
LTI4MDU2LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

