Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F39BC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41608206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41608206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAHC-0007BZ-Be
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipAGB-0005uL-1j
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipAG6-0001p0-7e
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:16:25 -0500
Resent-Date: Wed, 08 Jan 2020 07:16:23 -0500
Resent-Message-Id: <E1ipAG6-0001p0-7e@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipAG5-0001kO-RD; Wed, 08 Jan 2020 07:16:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578485772; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kmKGma6U1E0f9P9lreqGZegWBa5HwX5XZY9q4f20E4qfDsDyZ6MeRhKIq1AWJ/bBWAvCuL7I4RmWztmw2H9OH5vehEzn5twAS6izBZa6jIQ1mhLKnV8uqnL1GX8brAvnXUUk14qsGENIsehvkPpEBwE83mTla91mWuDP5k0nHRY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578485772;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NyQKkZx9en+Ka52cIC9Rz/z+soXP+Ffu10+K0r6pIV4=; 
 b=GWPrj8IeYfRlZm5z7nJpPWnJxpk+aiaNqhNzCngFvvqKkzl6AoiWTPLT3YHz5J2kB8iuJpg6fPRUWZEkeaXXXjQ1Bnd1WD7S+00nZmF2psqg5AJnHJPScDCf8oeLryIQw1LBsywxFEKv8QLNTtk67vtV/LGHdf6xcQlFKMGSutQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578485769150825.605564080826;
 Wed, 8 Jan 2020 04:16:09 -0800 (PST)
In-Reply-To: <20200108112220.499180-1-stefanha@redhat.com>
Subject: Re: [PATCH 0/4] luks: add qemu-img measure support
Message-ID: <157848576808.3775.16003679946263305504@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Wed, 8 Jan 2020 04:16:09 -0800 (PST)
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwODExMjIyMC40OTkx
ODAtMS1zdGVmYW5oYUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBp
by9jaGFubmVsLXdlYnNvY2subwogIENDICAgICAgaW8vY2hhbm5lbC11dGlsLm8KL3RtcC9xZW11
LXRlc3Qvc3JjL2Jsb2NrL2NyeXB0by5jOiBJbiBmdW5jdGlvbiAnYmxvY2tfY3J5cHRvX21lYXN1
cmUnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svY3J5cHRvLmM6NTczOjYwOiBlcnJvcjogcGFz
c2luZyBhcmd1bWVudCAzIG9mICdibG9ja19jcnlwdG9fY2FsY3VsYXRlX3BheWxvYWRfb2Zmc2V0
JyBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBv
aW50ZXItdHlwZXNdCiAgICAgaWYgKCFibG9ja19jcnlwdG9fY2FsY3VsYXRlX3BheWxvYWRfb2Zm
c2V0KG9wdHMsIE5VTEwsICZsdWtzX3BheWxvYWRfc2l6ZSwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9jcnlwdG8uYzoyMTE6NTI6IG5vdGU6IGV4cGVjdGVk
ICdzaXplX3QgKicge2FrYSAndW5zaWduZWQgaW50IConfSBidXQgYXJndW1lbnQgaXMgb2YgdHlw
ZSAndWludDY0X3QgKicge2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCAqJ30KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgKmxlbiwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fl5+fgpjYzE6IGFsbCB3
YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0
L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrL2NyeXB0by5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2MiwgaW4gPG1v
ZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTdjOTFjMTg4OGQ5
NjQ1ODc5ODBkOWUxNTZiYzExOTlhJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywg
J0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywg
J0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9j
Y2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1mazF0
M3IxeC9zcmMvZG9ja2VyLXNyYy4yMDIwLTAxLTA4LTA3LjEwLjIxLjUzMjk6L3Zhci90bXAvcWVt
dTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9N2M5MWMxODg4ZDk2NDU4Nzk4MGQ5ZTE1NmJjMTE5OWEK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZmsxdDNyMXgvc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNW00Ny44MDVz
CnVzZXIgICAgMG04LjUwMXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTA4MTEyMjIwLjQ5OTE4MC0xLXN0ZWZhbmhhQHJlZGhhdC5j
b20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


