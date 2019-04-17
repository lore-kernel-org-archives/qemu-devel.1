Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C07C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 18:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068CF20674
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 18:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068CF20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGpD1-0006zA-Tj
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 14:22:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGpC5-0006eQ-R4
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGpC4-0001mU-Lx
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:22:01 -0400
Resent-Date: Wed, 17 Apr 2019 14:22:01 -0400
Resent-Message-Id: <E1hGpC4-0001mU-Lx@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hGpC4-0001l7-2X
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:22:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555525294; cv=none; d=zoho.com; s=zohoarc; 
	b=dq1s+tkwPpD1NcS5tITiecFjMPgPOgu9ja409NPqWGhWRw6PLdEkFmbLxh5zOc+mOeWI/kthWrzb6pVWH+pcRv4ZqXeSGA4rO8+EGKJR75FV3HGEpOMMOV9Op1Y0GSKq6L2Atcq1hJv2FhoEFpccXXhN4DlOdFV3UMLt36SscF4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555525294;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=N3tVhxhSTXGZaKg+rAa02e6/3guHMbIstJt3QZ4XU2k=; 
	b=BRwRzTnThidWub2XByZ1zlCTf40mrV4gr1YBZZTK4ZEaKE3Ykjsbp07n27unTu7Z5b/f/imP6uuETK0kTvIyyIQL7jwjYEPUrWBAEzQ6PNp2oT4Cexk7iBaIOCY5oZwNJguJ5z+JyBfdJW1cG+CGBUIO0LC0lsKNmKc/BFkrQ7s=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555525293943775.5434954446962;
	Wed, 17 Apr 2019 11:21:33 -0700 (PDT)
Message-ID: <155552529277.17102.9216298997846682613@76452e4e88f2>
In-Reply-To: <87mukov6vk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Wed, 17 Apr 2019 11:21:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2 14.5/15] char-pty: Print "char device
 redirected" message to stdout
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417182133.-T8-pzvQAUvJHutTCYlezd-qaXBSNqp0rR08RLVDvGk@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS84N211a292NnZrLmZzZkBkdXNr
eS5wb25kLnN1Yi5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2FuIGJ1aWxk
IHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQg
YmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVw
cm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNv
ZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQVIgICAgICBs
aWJxZW11dXRpbC5hCiAgTElOSyAgICBlbGYyZG1wCiAgQVMgICAgICBvcHRpb25yb20vbXVsdGli
b290Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL2NoYXJkZXYvY2hhci1wdHkuYzoyMTQ6NTogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdxZW11X3ByaW50ZicgaXMgaW52YWxp
ZCBpbiBDOTkgWy1XZXJyb3IsLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgIHFl
bXVfcHJpbnRmKCJjaGFyIGRldmljZSByZWRpcmVjdGVkIHRvICVzIChsYWJlbCAlcylcbiIsCiAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9jaGFyZGV2L2NoYXItcHR5LmM6MjE0OjU6IGVycm9yOiB0
aGlzIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGlzIG5vdCBhIHByb3RvdHlwZSBbLVdlcnJvciwtV3N0
cmljdC1wcm90b3R5cGVzXQoyIGVycm9ycyBnZW5lcmF0ZWQuCiAgTElOSyAgICBpdnNobWVtLWNs
aWVudAogIExJTksgICAgaXZzaG1lbS1zZXJ2ZXIKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzg3bXVrb3Y2dmsuZnNmQGR1c2t5LnBvbmQuc3Vi
Lm9yZy90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


