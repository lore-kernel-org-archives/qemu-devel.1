Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BEEC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 05:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26E7A2080D
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 05:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E7A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU1Or-0003ar-8u
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 01:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kU1NN-0002ga-8K; Sun, 18 Oct 2020 01:37:01 -0400
Resent-Date: Sun, 18 Oct 2020 01:37:01 -0400
Resent-Message-Id: <E1kU1NN-0002ga-8K@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kU1NK-0004K3-6q; Sun, 18 Oct 2020 01:37:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602999399; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gwLdZH+Q/QXn++sNqJK1eVsJmhEi9T1wsH9t1DrcpovJV/CHupIbvc4oNzZxrD1w8K+TSr+PgkxRxKTIxiql7JpAneaVhmIDhRE3HvVKE1I7Gp3NeECzw3QYetsGnEOt0bOjLtZQgOShgZJPbvgD8JqAxjNHgaKKWmcGggEEpL4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602999399;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9ziI3rf2DyjWXRuMH3UzL5+feA1YeB3r9NJD/W7SHlc=; 
 b=NSz6SfKjK+v0TvcDbR/n/UghlJUgZcoOoII+bMlq7A/+vI6RpSACjKgmKKye5ptZdTg5fnkp+ovkuGiWbUJmysvEgokFE/AwUMk01j+YRNV8jmnH6+FDcqdq88iVRwpLX/fMSNDXHvQksyKBydsAVTZufjB+r4Z6xkjhIdQhsvA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 160299939846965.24340167797902;
 Sat, 17 Oct 2020 22:36:38 -0700 (PDT)
Subject: Re: [PATCH] qemu-img: add support for offline rate limit in qemu-img
 commit
Message-ID: <160299939685.17996.17478045721149283378@66eaa9a8a123>
In-Reply-To: <1602999097-24744-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Sat, 17 Oct 2020 22:36:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 01:36:54
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAyOTk5MDk3LTI0NzQ0LTEt
Z2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNjAyOTk5
MDk3LTI0NzQ0LTEtZ2l0LXNlbmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20KU3ViamVjdDog
W1BBVENIXSBxZW11LWltZzogYWRkIHN1cHBvcnQgZm9yIG9mZmxpbmUgcmF0ZSBsaW1pdCBpbiBx
ZW11LWltZyBjb21taXQKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRh
dGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMTYwMjk5OTA5Ny0yNDc0NC0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1aUBodWF3ZWku
Y29tIC0+IHBhdGNoZXcvMTYwMjk5OTA5Ny0yNDc0NC0xLWdpdC1zZW5kLWVtYWlsLWxpemhlbmd1
aUBodWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZmZkYWM5MiBxZW11
LWltZzogYWRkIHN1cHBvcnQgZm9yIG9mZmxpbmUgcmF0ZSBsaW1pdCBpbiBxZW11LWltZyBjb21t
aXQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBjb25zaWRlciB1c2luZyBxZW11X3N0cnRv
dWxsIGluIHByZWZlcmVuY2UgdG8gc3RydG91bGwKIzU5OiBGSUxFOiBxZW11LWltZy5jOjEwMzI6
CisgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGxvbmcgc3ZhbCA9IHN0cnRvdWxsKG9wdGFyZywg
JmVuZCwgMTApOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA0OSBsaW5lcyBjaGVja2Vk
CgpDb21taXQgZmZkYWM5MmYwZjM5IChxZW11LWltZzogYWRkIHN1cHBvcnQgZm9yIG9mZmxpbmUg
cmF0ZSBsaW1pdCBpbiBxZW11LWltZyBjb21taXQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE2MDI5
OTkwOTctMjQ3NDQtMS1naXQtc2VuZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

