Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288A9C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF52D21569
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF52D21569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2ih-0000We-S3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ir2hH-0006eS-Q4
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ir2hG-0000gK-KW
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:36:11 -0500
Resent-Date: Mon, 13 Jan 2020 11:36:11 -0500
Resent-Message-Id: <E1ir2hG-0000gK-KW@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ir2hG-0000dn-C9
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:36:10 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157893336253336.17943852508347;
 Mon, 13 Jan 2020 08:36:02 -0800 (PST)
In-Reply-To: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
Message-ID: <157893336195.17824.996345720313580252@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Mon, 13 Jan 2020 08:36:02 -0800 (PST)
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, kraxel@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExMzE0NDg0OC4yMTY4
MDE4LTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1h
a2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVz
dC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi90
bXAvcWVtdS10ZXN0L3NyYy9xYXBpL3VpLmpzb246OTg6IGNvbW1hbmQgaGFzIHVua25vd24ga2V5
ICdjb3JvdXRpbmUnClZhbGlkIGtleXMgYXJlICdhbGxvdy1vb2InLCAnYWxsb3ctcHJlY29uZmln
JywgJ2JveGVkJywgJ2NvbW1hbmQnLCAnZGF0YScsICdmZWF0dXJlcycsICdnZW4nLCAnaWYnLCAn
cmV0dXJucycsICdzdWNjZXNzLXJlc3BvbnNlJy4KICBDQyAgICAgIC90bXAvcWVtdS10ZXN0L2J1
aWxkL3NsaXJwL3NyYy9uY3NpLm8KbWFrZTogKioqIFtNYWtlZmlsZTo2MTg6IHFhcGktZ2VuLXRp
bWVzdGFtcF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgogIENDICAgICAgL3RtcC9xZW11LXRlc3QvYnVpbGQvc2xpcnAvc3JjL3ZlcnNpb24ubwogIEND
ICAgICAgL3RtcC9xZW11LXRlc3QvYnVpbGQvc2xpcnAvc3JjL3RjcF9vdXRwdXQubwotLS0KICAg
IHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVk
UHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICct
LWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NWJkYjUxNDIxYmFmNDRkNGE0ZDBlZjRl
MGRjMDQ0NTgnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29u
ZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklH
VVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1l
JywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXk5NWVrYmphL3NyYy9kb2Nr
ZXItc3JjLjIwMjAtMDEtMTMtMTEuMzQuMDEuMjIwNzM6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQg
bm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9NWJkYjUxNDIxYmFmNDRkNGE0ZDBlZjRlMGRjMDQ0NTgKbWFrZVsxXTogKioq
IFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAteTk1ZWtiamEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4t
dGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm0xLjA0NXMKdXNlciAgICAwbTgu
MDExcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDAxMTMxNDQ4NDguMjE2ODAxOC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS90
ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


