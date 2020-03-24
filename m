Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CBC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E1020786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E1020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhJV-0007v7-DL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGhIn-0007SK-4a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGhIl-0008CF-EJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:00:56 -0400
Resent-Date: Tue, 24 Mar 2020 07:00:56 -0400
Resent-Message-Id: <E1jGhIl-0008CF-EJ@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGhIl-0008Bw-6b
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:00:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585047645; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gckEM/lMYFDQQwbI/P4AzBFqMR5Xm/UgLm/5qQaxquUpJbZpiydqZuPYjtmXTrKxKF7ZwYJdEkukTArlqaDF+foN7y1zgksvCPtKuztBeqZh9Xtwv63OEMNJ13M8RPzLttHH5/KaKLNSNiPLStn8UJA+JtIgLG0PCd4hM7jdDA0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585047645;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IV5Y+rZOoV1j2y3XsCdEbbnjbbev9qrUl8GGXjwTaYg=; 
 b=TNuWwLZSuvZES411dnocD4ATfXVSjFBs6WOx4SA6//23O9oGoVDNBdTc1Nk7IEFheXmmNLv1oBX4tVqmpB1AWLXvLUWcpM/twT5vtt6PluEKDa9wWnYcULChOV2LzNV/lWCqDS4EtPbvltEekJw4qSywxqqYBdO1E2UvIAXAbz0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585047634876870.4474655932986;
 Tue, 24 Mar 2020 04:00:34 -0700 (PDT)
In-Reply-To: <20200324100311.588288-1-laurent@vivier.eu>
Subject: Re: [PULL 0/5] Linux user for 5.0 patches
Message-ID: <158504763369.13426.12844033914999219295@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 24 Mar 2020 04:00:34 -0700 (PDT)
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNDEwMDMxMS41ODgy
ODgtMS1sYXVyZW50QHZpdmllci5ldS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMC81XSBMaW51eCB1c2VyIGZvciA1LjAgcGF0Y2hl
cwpNZXNzYWdlLWlkOiAyMDIwMDMyNDEwMDMxMS41ODgyODgtMS1sYXVyZW50QHZpdmllci5ldQpU
eXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjU4ZmEwNTkgbGludXgtdXNlcjogRmx1c2ggb3V0IGlt
cGxlbWVudGF0aW9uIG9mIGdldHRpbWVvZmRheQpmMjUzZTdhIGxpbnV4LXVzZXI6IEFkZCB4ODZf
NjQgdnN5c2NhbGwgcGFnZSB0byAvcHJvYy9zZWxmL21hcHMKYWQwNjMyNyBsaW51eC11c2VyL2kz
ODY6IEVtdWxhdGUgeDg2XzY0IHZzeXNjYWxscwoyZGNjYjQ0IGxpbnV4LXVzZXIvaTM4NjogU3Bs
aXQgb3V0IGdlbl9zaWduYWwKMWFiMDVjMSB0YXJnZXQvaTM4NjogUmVudW1iZXIgRVhDUF9TWVND
QUxMCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0IDFhYjA1YzEwZWQw
MiAodGFyZ2V0L2kzODY6IFJlbnVtYmVyIEVYQ1BfU1lTQ0FMTCkKMi81IENoZWNraW5nIGNvbW1p
dCAyZGNjYjQ0Mjc3NDAgKGxpbnV4LXVzZXIvaTM4NjogU3BsaXQgb3V0IGdlbl9zaWduYWwpCjMv
NSBDaGVja2luZyBjb21taXQgYWQwNjMyNzE2ZDA3IChsaW51eC11c2VyL2kzODY6IEVtdWxhdGUg
eDg2XzY0IHZzeXNjYWxscykKNC81IENoZWNraW5nIGNvbW1pdCBmMjUzZTdhNDdjZjQgKGxpbnV4
LXVzZXI6IEFkZCB4ODZfNjQgdnN5c2NhbGwgcGFnZSB0byAvcHJvYy9zZWxmL21hcHMpCkVSUk9S
OiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMzMjogRklMRTogbGludXgtdXNlci9zeXNjYWxsLmM6NzE1
MjoKKyAgICBkcHJpbnRmKGZkLCBUQVJHRVRfRk1UX2x4ICItIiBUQVJHRVRfRk1UX2x4ICQKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC81IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzUgQ2hlY2tpbmcgY29tbWl0IDU4ZmEwNTkyYWU3
NyAobGludXgtdXNlcjogRmx1c2ggb3V0IGltcGxlbWVudGF0aW9uIG9mIGdldHRpbWVvZmRheSkK
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAz
MjQxMDAzMTEuNTg4Mjg4LTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

