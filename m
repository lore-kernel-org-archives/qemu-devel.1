Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E40EC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A476206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A476206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFZ7-0007bu-8G
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAFLT-0006Qx-F3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAFLS-0006Af-8l
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:47 -0400
Resent-Date: Tue, 17 Sep 2019 11:24:47 -0400
Resent-Message-Id: <E1iAFLS-0006Af-8l@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAFLS-0006AQ-1S
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:24:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568733876; cv=none; d=zoho.com; s=zohoarc; 
 b=bKzYgCrLYo94ZtSzJf/9RL81T1W9BlSxt+UjgOBnfvSPlbMvsBCbL3Ns7DtWxG58GTWj+ORDbhP6VNx9FPlOTU4Rig9DUJx3AdDepZDjlwFuejdkWoQHCfJTYGFhoNMMlfBm3yAQxNkcc7GK1X6acLglIm0HAHUBgnLRHKFFvDw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568733876;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=y40NwCzSWRv/swPqLUaZlOfwJibqxwh30i7dKfNPXEA=; 
 b=ibLoKU5i/E15paLait+zuP5eWX2pvZFUmF6X4IPsbC7+9Va8ZcFPkYPJanCXW0RQKtdVyxGwi6Cx0Ky1U2GiQx50CaegLs6A+KEJNszHYkw6bpWB9cx97JRCDH+xTKeDzHpEyw6mmjT5p/0uJMF7GRSsczg4rkxJXIwWB4y0iV4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568733875308864.2999568701655;
 Tue, 17 Sep 2019 08:24:35 -0700 (PDT)
In-Reply-To: <20190917130708.10281-1-imammedo@redhat.com>
Message-ID: <156873387351.17151.5157996315956457380@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Tue, 17 Sep 2019 08:24:35 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [edk2-devel] [PATCH 0/2] q35: mch: allow to lock
 down 128K RAM at default SMBASE address
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
Cc: yingwen.chen@intel.com, devel@edk2.groups.io, phillip.goerl@oracle.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, jiewen.yao@intel.com,
 jun.nakajima@intel.com, michael.d.kinney@intel.com, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, rfc@edk2.groups.io, lersek@redhat.com,
 joao.m.martins@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxNzEzMDcwOC4xMDI4
MS0xLWltYW1tZWRvQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0x
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgouL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkgLS1lbmdp
bmUgYXV0byBidWlsZCBxZW11OmZlZG9yYSB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZmVkb3Jh
LmRvY2tlciAgIC0tYWRkLWN1cnJlbnQtdXNlciAgCkltYWdlIGlzIHVwIHRvIGRhdGUuCiAgTEQg
ICAgICBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEubW8KY2M6IGZhdGFsIGVycm9yOiBubyBpbnB1
dCBmaWxlcwpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiogW2RvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYS5tb10gRXJyb3IgNAoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE3MTMwNzA4LjEwMjgxLTEtaW1hbW1lZG9AcmVk
aGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


