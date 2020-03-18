Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218B4C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7F420724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 02:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7F420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEOt3-0005h8-3E
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 22:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jEOsU-0005HN-SG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jEOsT-0002Ov-5K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:56:18 -0400
Resent-Date: Tue, 17 Mar 2020 22:56:18 -0400
Resent-Message-Id: <E1jEOsT-0002Ov-5K@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jEOsS-0002AY-Rt
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 22:56:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584500170; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ERzGmtmc0yCScvHGjL+DY4EmpneWjvVJMdzu+s21jmeSeUM8XCbh6VsHtYyBtYJWFCEPwxonHcPMnxecxb04vtKXVUL56ufsbdYY2KsxxXW//LMBDR7xkH6/jG1DgmQcZKp4ZufUXKG8RzT848L26kr4Fl8pADLcnPKOlo1TaK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584500170;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HiX7C1UhOdsw407/LZIFKqcSvFqDpHOnzI5UpDu28UU=; 
 b=IZlC/EFcadNk2EzERdYoyiYaQWbV60rcmHpV7QYp0doLD3+CbntomiOAmEYd0+wupO8vxsXnXQszq1lKwt3VPRFYK7g2GK/2nqQmYELR9Acc/zVy88wQekVWvX7IvnfrpamUccQuGrxeljlm55T9AmVnd1DcgrtQ2DQeohytpbM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584500168264933.798156718711;
 Tue, 17 Mar 2020 19:56:08 -0700 (PDT)
In-Reply-To: <20200317195042.282977-1-peterx@redhat.com>
Subject: Re: [PATCH v3 0/5] vfio/pci: Fix up breakage against split irqchip
 and INTx
Message-ID: <158450016696.25478.2974604448409668033@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peterx@redhat.com
Date: Tue, 17 Mar 2020 19:56:08 -0700 (PDT)
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
Cc: cohuck@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxNzE5NTA0Mi4yODI5
NzctMS1wZXRlcnhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIExJTksgICAgeDg2
XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0dy5leGUKaHcvaW50Yy9pb2FwaWMubzogSW4g
ZnVuY3Rpb24gYGlvYXBpY19lb2lfYnJvYWRjYXN0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2lu
dGMvaW9hcGljLmM6MjU4OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBrdm1fcmVzYW1wbGVfZmRf
bm90aWZ5Jwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsx
XTogKioqIFtNYWtlZmlsZToyMDc6IHFlbXUtc3lzdGVtLXg4Nl82NHcuZXhlXSBFcnJvciAxCm1h
a2U6ICoqKiBbTWFrZWZpbGU6NTI3OiB4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBMSU5LICAgIGFhcmNoNjQtc29m
dG1tdS9xZW11LXN5c3RlbS1hYXJjaDY0dy5leGUKICBHRU4gICAgIGFhcmNoNjQtc29mdG1tdS9x
ZW11LXN5c3RlbS1hYXJjaDY0LmV4ZQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9NThlMTExZGU1ZDI3NDBiYWFlZDA5MmM5ZGEyYmJmNTInLCAnLXUnLCAnMTAwMycsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1l
JywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC14YndjMjMzcC9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTE3LTIyLjUxLjUw
LjUwMzU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NThlMTExZGU1ZDI3NDBi
YWFlZDA5MmM5ZGEyYmJmNTIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteGJ3YzIz
M3Avc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIK
CnJlYWwgICAgNG0xOC4wMDdzCnVzZXIgICAgMG04LjM5N3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzE3MTk1MDQyLjI4Mjk3Ny0x
LXBldGVyeEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

