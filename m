Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951BDC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 07:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6875520644
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 07:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6875520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrzeK-0002pk-PD
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 03:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60724)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hrzds-0002OQ-BF
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hrzdr-000109-4h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:00:20 -0400
Resent-Date: Mon, 29 Jul 2019 03:00:20 -0400
Resent-Message-Id: <E1hrzdr-000109-4h@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hrzdq-0000uv-T1
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 03:00:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564383592; cv=none; d=zoho.com; s=zohoarc; 
 b=laum5hGKJkx9iZk825B51gvEU4d7cZmY3eCfIvqJGW4awsA1w0FhEdoT4WzZbhd59ESj/ImkfPYjFf6qj0k/jdpybYoL6fUnj5/K3USpiLxJTESZDO7vmIggnjBez7ZXMcD5YWrbsCnr/dE+bo0+wSPX9O42JHA3Ci/cpyuFOtI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564383592;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=0JhIkXhtX11gdEk9W8+ZQ4hOkdRmg5dBDhHaGuKl3KA=; 
 b=TK0rRQUECznSBVSCsLtn5jgwBWVC8SOEl9QFl9buNXRXj59R0QOwm+KpQWZaA1OfOwPeUW6c6GqrSbQmSiueB1TkQym/G4iHTj66IqsVU74aTaeBfHgZJiFcW3V/52pKi9ACJ2GZ1Vm1ZOE5ZTD5e3hYUpSUmipO7DmzUxE21G0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1564383591607830.977295622017;
 Sun, 28 Jul 2019 23:59:51 -0700 (PDT)
Message-ID: <156438358919.32054.9204074600884035058@c4a48874b076>
In-Reply-To: <156438176555.22071.10523120047318890136.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pavel.dovgaluk@gmail.com
Date: Sun, 28 Jul 2019 23:59:51 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay
 fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com,
 artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, dovgaluk@ispras.ru, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, pavel.dovgaluk@ispras.ru,
 thomas.dullien@googlemail.com, pbonzini@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY0MzgxNzY1NTUuMjIwNzEu
MTA1MjMxMjAwNDczMTg4OTAxMzYuc3RnaXRAcGFzaGEtUHJlY2lzaW9uLTM2MzAtVG93ZXIvCgoK
CkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdl
LWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEg
VEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCiAgQ0MgICAgICB1aS94X2tleW1hcC5vCiAgQ0MgICAgICB1aS9ndGsubwogIEND
ICAgICAgdWkvY3Vyc2VzLm8KL3RtcC9xZW11LXRlc3Qvc3JjL3JlcGxheS9yZXBsYXktZXZlbnRz
LmM6MTQxOjIzOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3JlcGxh
eV9nZXRfY3VycmVudF9pY291bnQnIGlzIGludmFsaWQgaW4gQzk5IFstV2Vycm9yLC1XaW1wbGlj
aXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgICAgdWludDY0X3QgaWQgPSByZXBsYXlfZ2V0
X2N1cnJlbnRfaWNvdW50KCk7CiAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0
L3NyYy9yZXBsYXkvcmVwbGF5LWV2ZW50cy5jOjE0MToyMzogbm90ZTogZGlkIHlvdSBtZWFuICdy
ZXBsYXlfZ2V0X2N1cnJlbnRfc3RlcCc/Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3N5c2Vt
dS9yZXBsYXkuaDo3ODoxMDogbm90ZTogJ3JlcGxheV9nZXRfY3VycmVudF9zdGVwJyBkZWNsYXJl
ZCBoZXJlCnVpbnQ2NF90IHJlcGxheV9nZXRfY3VycmVudF9zdGVwKHZvaWQpOwogICAgICAgICBe
Ci90bXAvcWVtdS10ZXN0L3NyYy9yZXBsYXkvcmVwbGF5LWV2ZW50cy5jOjE0MToyMzogZXJyb3I6
IHRoaXMgZnVuY3Rpb24gZGVjbGFyYXRpb24gaXMgbm90IGEgcHJvdG90eXBlIFstV2Vycm9yLC1X
c3RyaWN0LXByb3RvdHlwZXNdCiAgICAgICAgdWludDY0X3QgaWQgPSByZXBsYXlfZ2V0X2N1cnJl
bnRfaWNvdW50KCk7CiAgICAgICAgICAgICAgICAgICAgICBeCjIgZXJyb3JzIGdlbmVyYXRlZC4K
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1
NjQzODE3NjU1NS4yMjA3MS4xMDUyMzEyMDA0NzMxODg5MDEzNi5zdGdpdEBwYXNoYS1QcmVjaXNp
b24tMzYzMC1Ub3dlci90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


