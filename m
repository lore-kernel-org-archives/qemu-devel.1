Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9471C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915CD2182B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915CD2182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnipH-00063f-8J
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 08:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hnip5-0005ZL-OF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hnip4-0002mg-Jy
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:14:15 -0400
Resent-Date: Wed, 17 Jul 2019 08:14:15 -0400
Resent-Message-Id: <E1hnip4-0002mg-Jy@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hnip4-0002lv-CB; Wed, 17 Jul 2019 08:14:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563365639; cv=none; d=zoho.com; s=zohoarc; 
 b=DKfaJTnamFs8df/nRepIKWadKPveXJLu7ww4qBenby/rdPuo7bc1z/l3zOf+KNoT9X1WGUqLgoD4seNyNe0ww1ytrkXTvWq8Md6ln58YVRx2WuZxLfCVzHfBbHRI21XN8n7odZoPEKcHDK1zQeNc2S3wVoPpIFakkiCLC0Trrf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563365639;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=JxN+9o9krYoKlcoOfh71z/tuSHDydNcyWpGbSjmuizM=; 
 b=jHmz0Y+ItGCP1G9/PQ93iEfbmWBh5eg0NaKPS/BPOH8k5VnnxLtXcxrR91WPs8g8CeCb1X8IUtwexC8r6xsKuYH41ydQ3fiuwd2XWjCiU7R/MHM4SsRwBpSCXQMLD3GSuQEv0Lcan4mscV9kwZNUr/ZbBkELgXe4gt6m7N617OU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563365636807634.8850564525125;
 Wed, 17 Jul 2019 05:13:56 -0700 (PDT)
Message-ID: <156336563559.10055.9438399394251163790@c4a48874b076>
In-Reply-To: <20190716121352.302-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 17 Jul 2019 05:13:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [RFC PATCH for 4.1?] target/ppc: move opcode
 decode tables to PowerPCCPU
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
Cc: alex.bennee@linaro.org, 1836558@bugs.launchpad.net, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxNjEyMTM1Mi4zMDIt
MS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1h
a2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNzE2MTIxMzUyLjMwMi0x
LWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


