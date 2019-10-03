Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A843C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C3420700
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C3420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0XT-0004oE-DO
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iG0W0-0004Bn-Pt
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iG0Vy-0001aE-SF
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:47:28 -0400
Resent-Date: Thu, 03 Oct 2019 08:47:28 -0400
Resent-Message-Id: <E1iG0Vy-0001aE-SF@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iG0Vy-0001Zz-N3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:47:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570106838; cv=none; d=zoho.com; s=zohoarc; 
 b=jatSnQ5eKJvEZaijAlgi1ZJs0GwtPWhGjwuwpjn37jzNTMO5HuCgMegxE2aMPJlL56iqTDNag5Q4qeXRGvFQ8CelXYzg3gCjgXokQKvzzoMmDFWtcP/RtqA7uXvp8ovXcBjmIUuFT4nfH4xelBi5+4b+drsRS0Mdv3yfAcOzNEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570106838;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=dv3Q7qWvFZfEhZMhS2wz3ELo51HLDqGvOdY1kpoN210=; 
 b=Gy15hqAZ34HMYwUKau/BtkB6rMXhz7+s3cegma9+5Sj6f9i2j8ero6FkSO8vAJ5V4GGNkdm1NRSvbzARsyFJed8zW0PiiMw8BqC9NZomUlLkYMWE8akAaJTQ6g2RaD8/fPbePQvvrHmDXeHvvBVq/3ZM/Smz5ziTfzkXmZLkWB4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570106837097902.530478922125;
 Thu, 3 Oct 2019 05:47:17 -0700 (PDT)
Subject: Re: [PATCH] migration: Support gtree migration
In-Reply-To: <20191003114144.30129-1-eric.auger@redhat.com>
Message-ID: <157010683582.27524.3420696216247339122@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Thu, 3 Oct 2019 05:47:17 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: eric.auger@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwMzExNDE0NC4zMDEy
OS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tl
ci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dA
ZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
bmV0L25ldC5vCiAgQ0MgICAgICBuZXQvcXVldWUubwovdG1wL3FlbXUtdGVzdC9zcmMvbWlncmF0
aW9uL3Ztc3RhdGUtdHlwZXMuYzogSW4gZnVuY3Rpb24gJ3B1dF9ndHJlZV9lbGVtJzoKL3RtcC9x
ZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi92bXN0YXRlLXR5cGVzLmM6NzE0OjI2OiBlcnJvcjogY2Fz
dCBmcm9tIHBvaW50ZXIgdG8gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdlcnJvcj1wb2lu
dGVyLXRvLWludC1jYXN0XQogICAgICAgICBxZW11X3B1dF9iZTY0KGYsICh1aW50NjRfdClrZXkp
OwogICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlv
bi92bXN0YXRlLXR5cGVzLmM6IEluIGZ1bmN0aW9uICdwdXRfZ3RyZWUnOgovdG1wL3FlbXUtdGVz
dC9zcmMvbWlncmF0aW9uL3Ztc3RhdGUtdHlwZXMuYzo3MzU6MTk6IGVycm9yOiBjYXN0IHRvIHBv
aW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2Vycm9yPWludC10by1wb2lu
dGVyLWNhc3RdCiAgICAgR1RyZWUgKnRyZWUgPSAoR1RyZWUgKikoKnB2YWwpOwogICAgICAgICAg
ICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvbWlncmF0aW9uL3Ztc3RhdGUtdHlwZXMuYzog
SW4gZnVuY3Rpb24gJ2dldF9ndHJlZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vdm1z
dGF0ZS10eXBlcy5jOjc4OToxNzogZXJyb3I6IGNhc3QgZnJvbSBwb2ludGVyIHRvIGludGVnZXIg
b2YgZGlmZmVyZW50IHNpemUgWy1XZXJyb3I9cG9pbnRlci10by1pbnQtY2FzdF0KICAgICAgICAg
KnB2YWwgPSAodWludDY0X3QpdHJlZTsKICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0
L3NyYy9taWdyYXRpb24vdm1zdGF0ZS10eXBlcy5jOjc5MjoxNjogZXJyb3I6IGNhc3QgdG8gcG9p
bnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy1XZXJyb3I9aW50LXRvLXBvaW50
ZXItY2FzdF0KICAgICAgICAgdHJlZSA9IChHVHJlZSAqKSgqcHZhbCk7CiAgICAgICAgICAgICAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vdm1zdGF0ZS10eXBlcy5jOjc5NzoxOTog
ZXJyb3I6IGNhc3QgdG8gcG9pbnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy1X
ZXJyb3I9aW50LXRvLXBvaW50ZXItY2FzdF0KICAgICAgICAgICAgIGtleSA9IChncG9pbnRlcilx
ZW11X2dldF9iZTY0KGYpOwogICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBi
ZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxl
cy5tYWs6Njk6IG1pZ3JhdGlvbi92bXN0YXRlLXR5cGVzLm9dIEVycm9yIDEKbWFrZTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxs
IGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8
bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzBlNzg0MDBl
ZjU4NDY4NmI1NDcxNzRhMWRlMjc2MWYnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1w
L2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hl
Oi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1k
OXd2bWQ2dS9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTAzLTA4LjM2LjE2LjE0ODQyOi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1p
bmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWMwZTc4NDAwZWY1ODQ2ODZiNTQ3MTc0YTFkZTI3
NjFmCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWQ5d3ZtZDZ1L3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDEwbTU5
LjgzNHMKdXNlciAgICAwbTguMDYycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMDMxMTQxNDQuMzAxMjktMS1lcmljLmF1Z2VyQHJl
ZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


