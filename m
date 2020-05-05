Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088BFC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D170F2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D170F2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVsmB-00037J-4v
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVsl2-0002d0-0R; Tue, 05 May 2020 04:16:52 -0400
Resent-Date: Tue, 05 May 2020 04:16:52 -0400
Resent-Message-Id: <E1jVsl2-0002d0-0R@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVsl0-0000OH-JM; Tue, 05 May 2020 04:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588666599; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=epX559PeFStN0XzPNDfLiwsjrz7IOTxRoSFsJ2pqtLSvjIn7MkD/8JUk+L5cakx7PVgTkC8vERB45urOdoVmQyn9Sc0DaRvIOZjDeXsEXYEjm+atJ5T6Ket2z+eqPl726RTIqpCsaUuuobpw7TaQq3Olpae0mB1k3PSRbo/TWbM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588666599;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7KCaIebFWcUBxKf3uM8yyxvdmI+MvLMUTq5ozIex6wM=; 
 b=IVY6Ixg8p4TeXq7KzgGfRXM16klAIAPramFCNHVC6pkXt8WJZWKu6DO6mChg1VaRtNDp0p5uO6bM4p6imfVCy1oZf6XIvi2udxVO2j7QmMffkZar60/gJIiPIBBbuR3J/L5vnpGBa9C1DYVaAQVrGQYlaHwaI3OvAurgPz1IQUA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588666596604400.2187264904601;
 Tue, 5 May 2020 01:16:36 -0700 (PDT)
Message-ID: <158866659523.24779.11655235333242182991@45ef0f9c86ae>
In-Reply-To: <20200504131959.9533-1-mlevitsk@redhat.com>
Subject: Re: [PATCH v2] Fix iotest 153
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Tue, 5 May 2020 01:16:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 04:16:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNDEzMTk1OS45NTMz
LTEtbWxldml0c2tAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MDQxMzE5NTkuOTUzMy0xLW1sZXZpdHNrQHJl
ZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYyXSBGaXggaW90ZXN0IDE1MwpUeXBlOiBzZXJpZXMK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiB1bmFibGUgdG8gd3JpdGUgbmV3
IGluZGV4IGZpbGUKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgInBh
dGNoZXctdGVzdGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNTIxLCBpbiB0ZXN0X29uZQogICAg
Z2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmLCBUcnVlKQog
IEZpbGUgInBhdGNoZXctdGVzdGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNTcsIGluIGdpdF9j
bG9uZV9yZXBvCiAgICBjd2Q9Y2xvbmUpCiAgRmlsZSAiL29wdC9yaC9yaC1weXRob24zNi9yb290
L3Vzci9saWI2NC9weXRob24zLjYvc3VicHJvY2Vzcy5weSIsIGxpbmUgMjkxLCBpbiBjaGVja19j
YWxsCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNz
LkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAnY2hlY2tvdXQnLCAncmVmcy90
YWdzL3BhdGNoZXcvMjAyMDA1MDQxMzE5NTkuOTUzMy0xLW1sZXZpdHNrQHJlZGhhdC5jb20nLCAn
LWInLCAndGVzdCddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxMjguCgoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDQx
MzE5NTkuOTUzMy0xLW1sZXZpdHNrQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

