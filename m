Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C3FC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D405020873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D405020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBkUM-0008D2-3R
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jBkRw-0006Ui-KN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jBkRv-0007xO-8k
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:21:56 -0400
Resent-Date: Tue, 10 Mar 2020 15:21:56 -0400
Resent-Message-Id: <E1jBkRv-0007xO-8k@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jBkRu-0007o5-Uw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:21:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583868092; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YUYPZ/Cl+6kwUiGAbkn86Ch9FqrnQ15v0Qioi2ItOQXZQPl0K59nlqUc66l/XMUzVY87EEK0wxcHDsgvOaSjumMqOAxv2tKd7Cso8KNUGwkoJf7svu2cRxAKLO3AQoWmk4AgQpWd/Cuvy6SKyqBqg3qpOcmrt5k7LfvN6OAvyHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583868092;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=risSDNj+Np2hu2zNAHkRzZFmmn9/At4U1Cg/GJiCJ4I=; 
 b=OrQxKnPaQlJmZkXB7vgsuWQvwZu8FhDVXg0dAy7NeN/9VjuJevz5xEqCxZK3wozthkkeZd9mBs2/U+UpdeSwppZwdHPYniMppKM0pdtTCPPvwod/dPg7LHjOjNli4PbfZ5/d+B9YoCYdmYOeLeR5ZVtosmbBnMHLgnwJWStKhG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583868088466354.25076408254745;
 Tue, 10 Mar 2020 12:21:28 -0700 (PDT)
In-Reply-To: <20200310175921.501191-1-pbonzini@redhat.com>
Subject: Re: [PATCH] oslib-posix: initialize mutex and condition variable
Message-ID: <158386808740.945.2586058271333507918@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 10 Mar 2020 12:21:28 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: borntraeger@de.ibm.com, qemu-devel@nongnu.org, bauerchen@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMDE3NTkyMS41MDEx
OTEtMS1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIG9zbGliLXBvc2l4OiBpbml0aWFsaXplIG11
dGV4IGFuZCBjb25kaXRpb24gdmFyaWFibGUKTWVzc2FnZS1pZDogMjAyMDAzMTAxNzU5MjEuNTAx
MTkxLTEtcGJvbnppbmlAcmVkaGF0LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZmY1NjljMCBvc2xp
Yi1wb3NpeDogaW5pdGlhbGl6ZSBtdXRleCBhbmQgY29uZGl0aW9uIHZhcmlhYmxlCgo9PT0gT1VU
UFVUIEJFR0lOID09PQpFUlJPUjogZG8gbm90IGluaXRpYWxpc2Ugc3RhdGljcyB0byAwIG9yIE5V
TEwKIzI0OiBGSUxFOiB1dGlsL29zbGliLXBvc2l4LmM6NDY5OgorICAgIHN0YXRpYyBnc2l6ZSBp
bml0aWFsaXplZCA9IDA7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE3IGxpbmVzIGNo
ZWNrZWQKCkNvbW1pdCBmZjU2OWMwMTBlMjEgKG9zbGliLXBvc2l4OiBpbml0aWFsaXplIG11dGV4
IGFuZCBjb25kaXRpb24gdmFyaWFibGUpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzEwMTc1
OTIxLjUwMTE5MS0xLXBib256aW5pQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

