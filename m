Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BBBC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7ED52080C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ED52080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV0G8-0006Nd-4M
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jV0Er-0005nn-J7
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jV0Bs-0006aS-OK
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:04:01 -0400
Resent-Date: Sat, 02 May 2020 18:04:01 -0400
Resent-Message-Id: <E1jV0Bs-0006aS-OK@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jV0Bs-0006VK-8F; Sat, 02 May 2020 18:00:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588456838; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iegmkhCCw6ptUmeVY7v21kz0cTaZ771WL0c2rvZBpgBAKbrZJE5hY2K+1xzgVk4h3j+d2gBSBQZ/uIQ5RVCJ7t8vThTk7fp14Z6YrdVLgW9baxJKMr5GJYpoIQuIWatSd6rrXQOP2fXMaLleKiicGQNnFiniUmfJoi7NxDcecgw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588456838;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/d6+kfWZo+t3c7NJP7Ou3bCkCZ0HN6PpDx59KSQSgQg=; 
 b=I8TOPk9VF4hhblCJxkSu9YFjyehL8xHyLca0vA0HRuOHelII224It53FI06H6ZOulmCxmIKSvSGYlyp7UDziUIryU5P0mWBAmrM/slRnAExFFkMpmktDidS07HhLL8JudFXaut0YS30Ozt4esvgoKFA5Xh23F908cOQAeXDW9jM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588456837687310.71423266450927;
 Sat, 2 May 2020 15:00:37 -0700 (PDT)
Message-ID: <158845683562.31413.4485572935626539977@45ef0f9c86ae>
In-Reply-To: <20200502203536.15011-1-eric.auger@redhat.com>
Subject: Re: [PATCH 0/2] vTPM/aarch64 ACPI support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Sat, 2 May 2020 15:00:37 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 18:00:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, gshan@redhat.com,
 shannon.zhaosl@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 imammedo@redhat.com, eric.auger.pro@gmail.com, lersek@redhat.com,
 ardb@kernel.org, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwMjIwMzUzNi4xNTAx
MS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tl
ci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dA
ZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
eDg2XzY0LXNvZnRtbXUvdGFyZ2V0L2kzODYvc21tX2hlbHBlci5vCiAgQ0MgICAgICBhYXJjaDY0
LXNvZnRtbXUvaHcvYXJtL29yYW5nZXBpLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FybS92aXJ0
LWFjcGktYnVpbGQuYzogSW4gZnVuY3Rpb24gJ2FjcGlfZHNkdF9hZGRfdHBtJzoKL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYzozOTM6NTM6IGVycm9yOiBpbmNvbXBh
dGlibGUgdHlwZSBmb3IgYXJndW1lbnQgMiBvZiAnYW1sX21lbW9yeTMyX2ZpeGVkJwogICAgICAg
ICAgICAgICAgYW1sX21lbW9yeTMyX2ZpeGVkKHRwbV9iYXNlLCBzYmRldl9tci0+c2l6ZSwgQU1M
X1JFQURfV1JJVEUpKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfn5+fn5+fn5efn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3Ny
Yy9ody9hcm0vdmlydC1hY3BpLWJ1aWxkLmM6Mzk6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L2h3L2FjcGkvYW1sLWJ1aWxkLmg6MzE3OjY6IG5vdGU6IGV4cGVjdGVkICd1aW50MzJfdCcge2Fr
YSAndW5zaWduZWQgaW50J30gYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUgJ0ludDEyOCcge2FrYSAn
c3RydWN0IEludDEyOCd9CiBBbWwgKmFtbF9tZW1vcnkzMl9maXhlZCh1aW50MzJfdCBhZGRyLCB1
aW50MzJfdCBzaXplLAogICAgICBefn5+fn5+fn5+fn5+fn5+fn4KbWFrZVsxXTogKioqIFsvdG1w
L3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9hcm0vdmlydC1hY3BpLWJ1aWxkLm9dIEVy
cm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAg
ICAgIHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L3N2bV9oZWxwZXIubwogIENDICAgICAgeDg2
XzY0LXNvZnRtbXUvdGFyZ2V0L2kzODYva3ZtLXN0dWIubwotLS0KICBDQyAgICAgIHg4Nl82NC1z
b2Z0bW11L3NvZnRtbXUvbWFpbi5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9nZGJzdHViLXht
bC5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS90cmFjZS9nZW5lcmF0ZWQtaGVscGVycy5vCm1h
a2U6ICoqKiBbTWFrZWZpbGU6NTI3OiBhYXJjaDY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgTElOSyAgICB4ODZfNjQtc29m
dG1tdS9xZW11LXN5c3RlbS14ODZfNjR3LmV4ZQogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvcWVt
dS1zeXN0ZW0teDg2XzY0LmV4ZQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9MGE2ZjM5N2ZkZTU1NDMzMjg2NWJmNGViZTE1NTgzZDInLCAnLXUnLCAnMTAwMScsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTRiazFsZmc0L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMDItMTcuNTQuMzUuMjQy
NDI6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MGE2ZjM5N2ZkZTU1NDMzMjg2
NWJmNGViZTE1NTgzZDIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNGJrMWxmZzQv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJl
YWwgICAgNm0wLjQ2MHMKdXNlciAgICAwbTguNzMzcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDIyMDM1MzYuMTUwMTEtMS1lcmlj
LmF1Z2VyQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

