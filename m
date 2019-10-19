Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F40CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 09:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84145222BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 09:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84145222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLkdc-0007ny-NG
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 05:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iLkcl-0006uX-T9
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 05:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iLkck-0005TR-8y
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 05:02:11 -0400
Resent-Date: Sat, 19 Oct 2019 05:02:11 -0400
Resent-Message-Id: <E1iLkck-0005TR-8y@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iLkck-0005QY-1D; Sat, 19 Oct 2019 05:02:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571475701; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aN4+8qeXT97KPqUKLCaBQHtvOJNKNXWaHtHPEn3TD7/w/jgW3e0+JzRhjXSu34cvgVm+j8EUtJQ4ntmEMOR5ldg6AiwW/yBEK9E3bR+MEX5fmE7U5row9pU7u/0uHVFU73AILHAUzS3Mm5xz1tQIpVKbtXjNthasiALDCvpV6T0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571475701;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hRIcVZIEvWDn2fYENHObfrF0v5OD4n9uHLFvjrEYVTc=; 
 b=OtWlvNa+Ds9TQCClI7AGmH1SVsykD0ITgATZAV4HlaiegGRaymthNrSHxchQVBKo1wlQd4OxanzsOhIuUBw1qt8RNcSsw3Fuc6hTnpd02dEf0DWmapMJtA+WN4hYH3o4s8XGTMdqbavPkEHno+aAxBPSu1eitvrnZC/Gl4+V/MU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571475699351546.2778899745565;
 Sat, 19 Oct 2019 02:01:39 -0700 (PDT)
In-Reply-To: <20191018150630.31099-1-damien.hedde@greensocs.com>
Subject: Re: [PATCH v5 00/13] Multi-phase reset mechanism
Message-ID: <157147569728.24734.4597793654597373097@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: damien.hedde@greensocs.com
Date: Sat, 19 Oct 2019 02:01:39 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, edgari@xilinx.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxODE1MDYzMC4zMTA5
OS0xLWRhbWllbi5oZWRkZUBncmVlbnNvY3MuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVz
dGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIg
aW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2Ug
ZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1t
aW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICBody92aXJ0aW8vdHJhY2UubwogIENDICAgICAgaHcvd2F0Y2hkb2cvdHJhY2UubwoKV2Fy
bmluZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvZGV2ZWwvcmVz
ZXQucnN0OmRvY3VtZW50IGlzbid0IGluY2x1ZGVkIGluIGFueSB0b2N0cmVlCiAgQ0MgICAgICBo
dy94ZW4vdHJhY2UubwogIENDICAgICAgaHcvZ3Bpby90cmFjZS5vCi0tLQogIENDICAgICAgc3R1
YnMvYmRydi1uZXh0LW1vbml0b3Itb3duZWQubwogIENDICAgICAgc3R1YnMvYmxrLWNvbW1pdC1h
bGwubwogIENDICAgICAgc3R1YnMvYmxvY2tkZXYtY2xvc2UtYWxsLWJkcnYtc3RhdGVzLm8KbWFr
ZTogKioqIFtNYWtlZmlsZTo5OTQ6IGRvY3MvZGV2ZWwvaW5kZXguaHRtbF0gRXJyb3IgMgptYWtl
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgc3R1YnMvY2xv
Y2std2FycC5vClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWQwMjYxMzhlMTk2NTRlM2M4MGQxNjUwZDY4MzE2
YmQwJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hv
bWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaWY3dnJ2eGQvc3JjL2RvY2tlci1z
cmMuMjAxOS0xMC0xOS0wNC41OS41Mi4xMTExMTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpm
ZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFu
Y2UudXVpZD1kMDI2MTM4ZTE5NjU0ZTNjODBkMTY1MGQ2ODMxNmJkMAptYWtlWzFdOiAqKiogW2Rv
Y2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1pZjd2cnZ4ZC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0
LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAxbTQ0LjQyMnMKdXNlciAgICAwbTcuNjY0
cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTEwMTgxNTA2MzAuMzEwOTktMS1kYW1pZW4uaGVkZGVAZ3JlZW5zb2NzLmNvbS90ZXN0aW5n
LmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


