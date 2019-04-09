Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0B3C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0AD12084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0AD12084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDw5k-00041t-4l
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 15:07:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDw4V-0003PA-16
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDw4T-0004jh-3n
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:06:14 -0400
Resent-Date: Tue, 09 Apr 2019 15:06:14 -0400
Resent-Message-Id: <E1hDw4T-0004jh-3n@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDw4S-0004j9-Pa
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554836748; cv=none; d=zoho.com; s=zohoarc; 
	b=jxRVh0UALHRmoG25fPmMoPq3PDdTGpCROzdQKSvM2RVHCjL9Po1iZSEIYT+Nq08q6yiJJ1Fn4DLhs4CYqiKw5QQQkcJhM7Yj9L0GSpISY484DrFAd4X2PmEsNxgBPAox1XGfCru0BR10mLFjvIoRB60Aoe1D8ws5UUuF+r8OrgE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554836748;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=YyMEhuolgfW7ddwmb5R3idqeBq0kLf3b9sGRDSgwTkU=; 
	b=SqD1qMpqlK6eN91AmvM3iBwlZlqjhkk2gD5LojQX9ttTOz5VZ2iYZl+qlx2/ZoGOBr7LB6C4MVv77FIM8iOpp2gnQfydIa1x1kY4wN4gSnOe127r/qXTH0s5IPLi54cVZPaouHwawOnc52wYAa++5DgP0MqRTa3GSVgSc7wAHC8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554836738511912.8210663674805;
	Tue, 9 Apr 2019 12:05:38 -0700 (PDT)
Message-ID: <155483673694.12882.12776277604345697825@76452e4e88f2>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Tue, 9 Apr 2019 12:05:38 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v4 00/20] monitor: add asynchronous command
 type
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
Cc: fam@euphon.net, mdroth@linux.vnet.ibm.com, armbru@redhat.com,
	qemu-devel@nongnu.org, kraxel@redhat.com,
	marcandre.lureau@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409190538.fX9_UfmBEL6fD_bbMtc7cZOmLipdScBnw_zhsd-3MeA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwOTE2MTAwOS42MzIy
LTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBh
bmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3Ug
Y2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdF
VF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMTkwNDA5MTYxMDA5LjYzMjItMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vdGVz
dGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


