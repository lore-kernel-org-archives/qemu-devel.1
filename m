Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCD9C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1F0206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1F0206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADds-00037S-8k
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jADdK-0002bV-D4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jADdJ-0004rA-5k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:07:22 -0500
Resent-Date: Fri, 06 Mar 2020 09:07:22 -0500
Resent-Message-Id: <E1jADdJ-0004rA-5k@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jADdE-0003WA-VB; Fri, 06 Mar 2020 09:07:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583503620; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dJRw4kkpvmLWhamau8z8a1c6EoVRjRa/7VulFGq8/K+ZewkxzJ4sl/Eh46zYVwLVerThW9GQP37DykvrvTzRReLqSlqKV/Q+5w0LpZC6TxFCQOjj7nTXxSQv2Vb7SD0xd6UE2EA9ApdA+SFgsAG7Qjb1Ah0VjJZ5l4FMzewCwpg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583503620;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=YhQvVLZ/ncy0AtlaroCRLuMvoml1B7+MVwRzIQLQcVQ=; 
 b=d4nBjP6Zy1qBzxnKWU9YMqRROEoC3+fRzsPPsOrLJe3ZHCWhFVeZC2WRr8xt8hF/fv0rLaxrmfY5IIpjmiaPFqjMJhWBw09ATc0JFnHUF/sw1TRhIbl5RIDErNRRMbzQzVYlOjstdB0OV1wqCiGkptT57HwfW9R4REsB8k6AaO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583503617910857.7129877557559;
 Fri, 6 Mar 2020 06:06:57 -0800 (PST)
In-Reply-To: <20200306123307.1348-1-clg@kaod.org>
Subject: Re: [PATCH] spapr/xive: use SPAPR_IRQ_IPI to define IPI ranges
 exposed to the guest
Message-ID: <158350361658.14529.9299416440651318227@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: clg@kaod.org
Date: Fri, 6 Mar 2020 06:06:57 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwNjEyMzMwNy4xMzQ4
LTEtY2xnQGthb2Qub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLW1p
bmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBh
bmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3Ug
Y2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZl
ZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZpbGU6ICIvdG1wL3FlbXUtbnNp
c1xxZW11LWRvYy5odG1sIiAtPiBubyBmaWxlcyBmb3VuZC4KVXNhZ2U6IEZpbGUgWy9ub25mYXRh
bF0gWy9hXSAoWy9yXSBbL3ggZmlsZXNwZWMgWy4uLl1dIGZpbGVzcGVjIFsuLi5dIHwKICAgL29u
YW1lPW91dGZpbGUgb25lX2ZpbGVfb25seSkKRXJyb3IgaW4gc2NyaXB0ICIvdG1wL3FlbXUtdGVz
dC9zcmMvcWVtdS5uc2kiIG9uIGxpbmUgMTgwIC0tIGFib3J0aW5nIGNyZWF0aW9uIHByb2Nlc3MK
bWFrZTogKioqIFtNYWtlZmlsZToxMTYyOiBxZW11LXNldHVwLTQuMi41MC5leGVdIEVycm9yIDEK
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2Vy
L2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQot
LS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3Mu
Q2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1
bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZThkMmY1MmYzMDU1NDczYzlm
NzQzZmFkZGE1ZDU0MzcnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21w
PXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFf
Q09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9
JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScs
ICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAv
Y2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLThpdXdyNTNwL3Ny
Yy9kb2NrZXItc3JjLjIwMjAtMDMtMDYtMDkuMDMuMTAuMTk2NDg6L3Zhci90bXAvcWVtdTp6LHJv
JywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9ZThkMmY1MmYzMDU1NDczYzlmNzQzZmFkZGE1ZDU0MzcKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOGl1d3I1M3Avc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgM200Ny42ODVzCnVzZXIg
ICAgMG04LjcwOHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwMzA2MTIzMzA3LjEzNDgtMS1jbGdAa2FvZC5vcmcvdGVzdGluZy5kb2Nr
ZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

