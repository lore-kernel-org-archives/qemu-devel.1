Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D97AC76188
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9C820838
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9C820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp6pF-0003Sc-54
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 04:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hp6p4-0002zz-CU
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hp6p3-0002qD-BD
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:03:58 -0400
Resent-Date: Sun, 21 Jul 2019 04:03:58 -0400
Resent-Message-Id: <E1hp6p3-0002qD-BD@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hp6p3-0002p9-3g
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563693498; cv=none; d=zoho.com; s=zohoarc; 
 b=e8akJb8VMZEgslC9+3NbNt+VVWY5EkCEnICENcSTnuKs4jQ35uMnBkG/YDEhdJgxX9ya0AqbkkuU7mu3hd0XrbM/Lmi8Vtp0uJMQli+k8pWQTRq1TiLb72DD1+BEuFCpBOS6l723wm/Waw2LyXL9GZS+gDhIQpiw4xSTXVu4O/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563693498;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=8YSeK08bPyghh5te1NFW0/VBklNhutrdNt0ggtpLNwk=; 
 b=kVyJKQaVCh09NA+QwKsnAF0iCvzXSN3zP5BpBvuk+QduxrHWkH3Y/EFefM0uUouTzg+wnolWVPwykDiaxxp+oeb0g0JoGAKLwn2zNm9s8woF0J45kX3iQfvF0svDBFCQe1ndZRbDR754chwZbSCNU4pRRXKuNqP674nftqcoo9g=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563693497700506.3400296200757;
 Sun, 21 Jul 2019 00:18:17 -0700 (PDT)
Message-ID: <156369349620.23405.9935553428760867319@c4a48874b076>
In-Reply-To: <1563693178-23328-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Sun, 21 Jul 2019 00:18:17 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: fixed virtio_scsi_ctx_check
 failed when detaching scsi disk
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
Cc: kwolf@redhat.com, lizhengui@huawei.com, qemu-block@nongnu.org,
 eric.fangyi@huawei.com, qemu-devel@nongnu.org, jiangyiwen@huawei.com,
 wangjie88@huawei.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYzNjkzMTc4LTIzMzI4LTEt
Z2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDE1NjM2OTMxNzgtMjMzMjgtMS1n
aXQtc2VuZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSF0gdmlydGlvLXNjc2k6IGZpeGVkIHZpcnRpb19zY3NpX2N0eF9j
aGVjayBmYWlsZWQgd2hlbiBkZXRhY2hpbmcgc2NzaSBkaXNrCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8xNTYzNjkzMTc4LTIzMzI4
LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20gLT4gcGF0Y2hldy8xNTYzNjkz
MTc4LTIzMzI4LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20KU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0ZDEzMTg4NDI4IHZpcnRpby1zY3NpOiBmaXhlZCB2aXJ0
aW9fc2NzaV9jdHhfY2hlY2sgZmFpbGVkIHdoZW4gZGV0YWNoaW5nIHNjc2kgZGlzawoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KRVJST1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90
YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxOCBsaW5lcyBjaGVja2VkCgpDb21taXQgNGQxMzE4
ODQyODhlICh2aXJ0aW8tc2NzaTogZml4ZWQgdmlydGlvX3Njc2lfY3R4X2NoZWNrIGZhaWxlZCB3
aGVuIGRldGFjaGluZyBzY3NpIGRpc2spIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjM2OTMxNzgt
MjMzMjgtMS1naXQtc2VuZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbS90ZXN0aW5nLmNoZWNr
cGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


