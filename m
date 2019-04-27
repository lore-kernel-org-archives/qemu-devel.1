Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A86C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 15:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515D22087F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 15:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515D22087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKPdo-0006kf-9C
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 11:53:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKPd3-0006QS-3Z
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKPd1-0007dl-PJ
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:52:41 -0400
Resent-Date: Sat, 27 Apr 2019 11:52:41 -0400
Resent-Message-Id: <E1hKPd1-0007dl-PJ@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hKPd1-0007cx-Hi
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 11:52:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556380318; cv=none; d=zoho.com; s=zohoarc; 
	b=he28jwEHavw6Q4JtGp5ePxqG3igxrrMpEi/v929b45g95BDltCsDupKsTCf7bClPdPjCtR3LHa4BLOhpumq4BdORXVxGmrEJePHpRATbyqJGkRbCCKaJqVMAxyMYCH4CJrU3/1wNMZfU+mRVBm4zw1410sOzFswqgGaRb9LHWW8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556380318;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=wj9ZGJap9LZxZon6EP9bY2FsvIKEidEGmB2TA0nuK4o=; 
	b=O2j98pDN8S+DovUBxSK7GH7r5ZnYQwoO8I2buOGJ/gf+ogRwkjhMv+4CKLrHBuVbc1dmRT2/N7Lyyq/08OUZ5zKS5TVMyvhFscj3tPSdL8f5M3RwMPo8tqUXVDhGnLbn6o8NYcMywh55sSoeWntggsj2IJRCajLS1t8EOOXpEZc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556380318136544.6958971432315;
	Sat, 27 Apr 2019 08:51:58 -0700 (PDT)
In-Reply-To: <20190427153031.5119-1-samuel.thibault@ens-lyon.org>
Message-ID: <155638031671.10667.7688967011446219214@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: samuel.thibault@ens-lyon.org
Date: Sat, 27 Apr 2019 08:51:58 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] curses: Do not assume wchar_t contains
 unicode
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
Cc: fam@euphon.net, samuel.thibault@ens-lyon.org, kamil@netbsd.org,
	qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427155158.YDy2BENiTFSIggkxTI1mC6wf0fx2c_8uViGGA8q-wtI@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNzE1MzAzMS41MTE5
LTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9uLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMg
YW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91
IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJH
RVRfTElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBBUyAgICAgIG9wdGlvbnJvbS9saW51eGJvb3QubwogIEFTICAgICAgb3B0aW9ucm9t
L2t2bXZhcGljLm8KICBBUyAgICAgIG9wdGlvbnJvbS9wdmgubwovdG1wL3FlbXUtdGVzdC9zcmMv
dWkvY3Vyc2VzLmM6NDgyOjI1OiBlcnJvcjogdmFyaWFibGUgJ3VjaCcgaXMgdW5pbml0aWFsaXpl
ZCB3aGVuIHVzZWQgaGVyZSBbLVdlcnJvciwtV3VuaW5pdGlhbGl6ZWRdCiAgICAgICAgICAgICAg
ICAgICAgICAgIHVjaCwgc3RyZXJyb3IoZXJybm8pKTsKICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+Ci90bXAvcWVtdS10ZXN0L3NyYy91aS9jdXJzZXMuYzo0NzM6MTc6IG5vdGU6IGluaXRpYWxp
emUgdGhlIHZhcmlhYmxlICd1Y2gnIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5nCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQyNzE1MzAz
MS41MTE5LTEtc2FtdWVsLnRoaWJhdWx0QGVucy1seW9uLm9yZy90ZXN0aW5nLmFzYW4vP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


