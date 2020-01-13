Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5255AC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CF0214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CF0214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2HX-0006Af-7P
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ir2Gr-0005eH-CL
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:08:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ir2Gp-0000pD-I2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:08:53 -0500
Resent-Date: Mon, 13 Jan 2020 11:08:53 -0500
Resent-Message-Id: <E1ir2Gp-0000pD-I2@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ir2Gp-0000YY-8i
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:08:51 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578931688170101.97653427304533;
 Mon, 13 Jan 2020 08:08:08 -0800 (PST)
In-Reply-To: <20200113144228.16660-1-minyard@acm.org>
Subject: Re: [PATCH] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <157893168692.17824.3814038838172025698@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: minyard@acm.org
Date: Mon, 13 Jan 2020 08:08:08 -0800 (PST)
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
Cc: peter.maydell@linaro.org, cminyard@mvista.com, mst@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExMzE0NDIyOC4xNjY2
MC0xLW1pbnlhcmRAYWNtLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVc2luZyBleHBlY3RlZCBmaWxlICd0
ZXN0cy9kYXRhL2FjcGkvcTM1L0RTRFQuYWNwaWhtYXQnCmFjcGktdGVzdDogV2FybmluZyEgRFNE
VCBiaW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsIFthbWw6L3RtcC9hbWwtUEpIR0UwXSwgRXhw
ZWN0ZWQgW2FtbDp0ZXN0cy9kYXRhL2FjcGkvcTM1L0RTRFQuYWNwaWhtYXRdLgp0byBzZWUgQVNM
IGRpZmYgYmV0d2VlbiBtaXNtYXRjaGVkIGZpbGVzIGluc3RhbGwgSUFTTCwgcmVidWlsZCBRRU1V
IGZyb20gc2NyYXRjaCBhbmQgcmUtcnVuIHRlc3RzIHdpdGggVj0xIGVudmlyb25tZW50IHZhcmlh
YmxlIHNldCoqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxl
cy10ZXN0LmM6NDc3OnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVz
X21hdGNoKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMv
cXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOjQ3Nzp0ZXN0X2FjcGlfYXNsOiBhc3NlcnRpb24gZmFp
bGVkOiAoYWxsX3RhYmxlc19tYXRjaCkKICBURVNUICAgIGlvdGVzdC1xY293MjogMDM3Cm1ha2U6
ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1
bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAzOApxZW11LXN5c3Rl
bS1hYXJjaDY0OiAtYWNjZWwga3ZtOiBpbnZhbGlkIGFjY2VsZXJhdG9yIGt2bQotLS0KICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxh
YmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9M2M4NGZmMTIzMWU1NDZlM2JmMjFkYTY2NzRl
ZjYyMjQnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmlu
ZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJF
X09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywg
J1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0xMWhqNl9pbC9zcmMvZG9ja2Vy
LXNyYy4yMDIwLTAxLTEzLTEwLjU4LjQ2LjIzNDk3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11
OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD0zYzg0ZmYxMjMxZTU0NmUzYmYyMWRhNjY3NGVmNjIyNAptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC0xMWhqNl9pbC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgOW0yMC43NjVzCnVzZXIgICAgMG04
Ljk4N3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMjAwMTEzMTQ0MjI4LjE2NjYwLTEtbWlueWFyZEBhY20ub3JnL3Rlc3RpbmcuZG9ja2Vy
LXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


