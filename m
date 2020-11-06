Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AAEC388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:07:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0830D206CB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0830D206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayeg-0003Ox-Pg
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 05:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaye8-0002y1-FZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:07:04 -0500
Resent-Date: Fri, 06 Nov 2020 05:07:04 -0500
Resent-Message-Id: <E1kaye8-0002y1-FZ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaye5-0001EE-Q5
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:07:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604657204; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ftE5BO7yBpgSUfaYIhuJQ0S1VxVlABEwQPwh7MhTyTv0njaqDb2jY8uiuiFQQ4OnC0YCgbrZMwjJ5tw5n0M027SXYvBaffDY1wW6pTCYmrehoYkQaQ08ZeAvbaW+dbA+vCBbsHE7z4lfIoz/wIhPOj8LuOH6YmdY6W4eYtAKLwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604657204;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wljCnhvqqOkRZazF03Mq0G/z4JvrjyzCqHujhN4+lxw=; 
 b=Do9QcS7Qx5Ex4qcLITTQA2x+1xl6B3XmS6KpQFvQtq/91eQvgixcz1uAy6iUfN1dRys2+0qDJ++5BX+LmQDByNRB8hQ4GCIxAxoEuF/gq8sBlEKiA+IEX8ETDCqGeJCCxhouLdzdeBL9l1FOXQ0fBjT6TDLTpDmh5ZPJglyyTgY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604657202096823.1859860197169;
 Fri, 6 Nov 2020 02:06:42 -0800 (PST)
Subject: Re: [PATCH] migration/multifd: close TLS channel before socket
 finalize
Message-ID: <160465720036.7648.12454610421396987144@66eaa9a8a123>
In-Reply-To: <1604657935-56394-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhengchuan@huawei.com
Date: Fri, 6 Nov 2020 02:06:42 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 05:06:59
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
Cc: yubihong@huawei.com, berrange@redhat.com, zhang.zhanghailiang@huawei.com,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 dgilbert@redhat.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjA0NjU3OTM1LTU2Mzk0LTEt
Z2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVs
b3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTYwNDY1
NzkzNS01NjM5NC0xLWdpdC1zZW5kLWVtYWlsLXpoZW5nY2h1YW5AaHVhd2VpLmNvbQpTdWJqZWN0
OiBbUEFUQ0hdIG1pZ3JhdGlvbi9tdWx0aWZkOiBjbG9zZSBUTFMgY2hhbm5lbCBiZWZvcmUgc29j
a2V0IGZpbmFsaXplCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBy
ZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8v
Z2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRj
aGV3LzE2MDQ2NTc5MzUtNTYzOTQtMS1naXQtc2VuZC1lbWFpbC16aGVuZ2NodWFuQGh1YXdlaS5j
b20gLT4gcGF0Y2hldy8xNjA0NjU3OTM1LTU2Mzk0LTEtZ2l0LXNlbmQtZW1haWwtemhlbmdjaHVh
bkBodWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDY4NDkyOCBtaWdy
YXRpb24vbXVsdGlmZDogY2xvc2UgVExTIGNoYW5uZWwgYmVmb3JlIHNvY2tldCBmaW5hbGl6ZQoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IHN1c3BlY3QgY29kZSBpbmRlbnQgZm9yIGNvbmRp
dGlvbmFsIHN0YXRlbWVudHMgKDUsIDkpCiMyNTogRklMRTogbWlncmF0aW9uL211bHRpZmQuYzo1
Mjg6CisgICAgIGlmIChpb2MgJiYKWy4uLl0KKyAgICAgICAgIC8qCgp0b3RhbDogMSBlcnJvcnMs
IDAgd2FybmluZ3MsIDI2IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA0Njg0OTI4ODZmYWMgKG1pZ3Jh
dGlvbi9tdWx0aWZkOiBjbG9zZSBUTFMgY2hhbm5lbCBiZWZvcmUgc29ja2V0IGZpbmFsaXplKSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8xNjA0NjU3OTM1LTU2Mzk0LTEtZ2l0LXNlbmQtZW1haWwtemhl
bmdjaHVhbkBodWF3ZWkuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

