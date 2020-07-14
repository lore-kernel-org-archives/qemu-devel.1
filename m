Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8C8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D587A22201
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D587A22201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvI4x-0008Cy-62
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvI47-0007P2-QJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:21:35 -0400
Resent-Date: Tue, 14 Jul 2020 06:21:35 -0400
Resent-Message-Id: <E1jvI47-0007P2-QJ@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvI45-00087g-Im
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:21:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594722072; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EsjGAvsJeeKzeHigD7FiGcCo1zJeqa6ia8e8r6qeyNI9KdFsuXBZs6QTgMUgAVQ2rhAdA95QSLVc98sBtKW8ilpz+F5RmyGyg/+/TT2PqZqkAkj9oK+iDP+aKIT6RIwjczdXJXD0AdDkwl4hzMMwyLtvLFSeQgn16ztehR810Mk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594722072;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=nAmS76CI4fgTIfzNucx//KmGv3U85ZOdJ1LvZJetLlk=; 
 b=nqB2ds7RT1qzY+rio9BoZbidpMricSjYBzz2IThd7U634ZnpM64/bMF8imPqBj7Y5jglmSUQQogOFc3zgy3iCj/xOHCWwYQ+6kUxC/VuDbXat5cfEARII9wR2ACVodyTD6Zq3hIwX8EnlQ6E2RI4YhkugoqR+Omdv78IvBlfWmU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594722069797935.3771716012078;
 Tue, 14 Jul 2020 03:21:09 -0700 (PDT)
Subject: Re: [PATCH for-5.1] acpi-pm-tmr: allow 2-byte reads
Message-ID: <159472206861.2008.1347929967582108751@07a7f0d89f7d>
In-Reply-To: <20200714095518.16241-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mjt@tls.msk.ru
Date: Tue, 14 Jul 2020 03:21:09 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 06:21:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: git@the-jedi.co.uk, mjt@tls.msk.ru, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDA5NTUxOC4xNjI0
MS0xLW1qdEBtc2dpZC50bHMubXNrLnJ1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA3MTQwOTU1MTguMTYy
NDEtMS1tanRAbXNnaWQudGxzLm1zay5ydQpTdWJqZWN0OiBbUEFUQ0ggZm9yLTUuMV0gYWNwaS1w
bS10bXI6IGFsbG93IDItYnl0ZSByZWFkcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYjRmM2FkOCBhY3BpLXBtLXRt
cjogYWxsb3cgMi1ieXRlIHJlYWRzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogVGhlIGNv
cnJlY3QgZm9ybSBpcyAiU2lnbmVkLW9mZi1ieSIKIzEyOiAKICAgIFNpZ25lZC1PZmYtQnk6IE1p
Y2hhZWwgVG9rYXJldiA8bWp0QHRscy5tc2sucnU+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDEwIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBiNGYzYWQ4ZjEzZGYgKGFjcGktcG0tdG1yOiBh
bGxvdyAyLWJ5dGUgcmVhZHMpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzE0MDk1NTE4LjE2
MjQxLTEtbWp0QG1zZ2lkLnRscy5tc2sucnUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

