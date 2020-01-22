Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB048C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDFD21835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDFD21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9R3-0002JV-Sw
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iu9QW-0001tX-JA
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iu9QV-0004zG-B4
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:23:44 -0500
Resent-Date: Wed, 22 Jan 2020 01:23:44 -0500
Resent-Message-Id: <E1iu9QV-0004zG-B4@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iu9QV-0004yv-3d
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:23:43 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579674212461932.2442442368642;
 Tue, 21 Jan 2020 22:23:32 -0800 (PST)
In-Reply-To: <20200122055115.429945-1-mst@redhat.com>
Subject: Re: [PULL 00/17] virtio, pc: fixes, features
Message-ID: <157967421148.8714.13063905979235625106@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Tue, 21 Jan 2020 22:23:32 -0800 (PST)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyMjA1NTExNS40Mjk5
NDUtMS1tc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVc2luZyBleHBlY3RlZCBmaWxlICd0
ZXN0cy9kYXRhL2FjcGkvcTM1L0RTRFQuYWNwaWhtYXQnCmFjcGktdGVzdDogV2FybmluZyEgRFNE
VCBiaW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsIFthbWw6L3RtcC9hbWwtSldaVkUwXSwgRXhw
ZWN0ZWQgW2FtbDp0ZXN0cy9kYXRhL2FjcGkvcTM1L0RTRFQuYWNwaWhtYXRdLgp0byBzZWUgQVNM
IGRpZmYgYmV0d2VlbiBtaXNtYXRjaGVkIGZpbGVzIGluc3RhbGwgSUFTTCwgcmVidWlsZCBRRU1V
IGZyb20gc2NyYXRjaCBhbmQgcmUtcnVuIHRlc3RzIHdpdGggVj0xIGVudmlyb25tZW50IHZhcmlh
YmxlIHNldCoqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxl
cy10ZXN0LmM6NDkwOnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVz
X21hdGNoKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMv
cXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOjQ5MDp0ZXN0X2FjcGlfYXNsOiBhc3NlcnRpb24gZmFp
bGVkOiAoYWxsX3RhYmxlc19tYXRjaCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVy
cm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAg
IGlvdGVzdC1xY293MjogMDQ5CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA1MAotLS0KICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxh
YmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YmY5ZjNjMDNkN2ZkNGVlYWIyOTg1ZDEwYTk5
OGRjZTgnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmlu
ZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJF
X09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywg
J1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC03d3V0NG5yZS9zcmMvZG9ja2Vy
LXNyYy4yMDIwLTAxLTIyLTAxLjEwLjMyLjk5Nzk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6
Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5v
bi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0
YW5jZS51dWlkPWJmOWYzYzAzZDdmZDRlZWFiMjk4NWQxMGE5OThkY2U4Cm1ha2VbMV06ICoqKiBb
ZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLTd3dXQ0bnJlL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRl
c3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxMm01OS42MDhzCnVzZXIgICAgMG0x
MC45MzNzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDEyMjA1NTExNS40Mjk5NDUtMS1tc3RAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tl
ci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


