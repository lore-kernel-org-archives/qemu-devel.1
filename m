Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CF1C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AB020842
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AB020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33937 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19NH-00065q-KW
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j19MV-00055R-Ov
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j19MU-0006ye-61
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:44:31 -0500
Resent-Date: Mon, 10 Feb 2020 08:44:31 -0500
Resent-Message-Id: <E1j19MU-0006ye-61@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j19MT-0006xu-Ue; Mon, 10 Feb 2020 08:44:30 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581342243617677.5462869362311;
 Mon, 10 Feb 2020 05:44:03 -0800 (PST)
In-Reply-To: <20200210131523.27540-1-eric.auger@redhat.com>
Subject: Re: [RFC 0/2] vTPM for aarch64
Message-ID: <158134224175.6574.17653625255794632377@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Mon, 10 Feb 2020 05:44:03 -0800 (PST)
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 eric.auger.pro@gmail.com, lersek@redhat.com, ardb@kernel.org,
 stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMDEzMTUyMy4yNzU0
MC0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpxZW11LXN5c3RlbS14ODZf
NjQ6IE9wdGlvbiAnLWRldmljZSB0cG0tdGlzJyBjYW5ub3QgYmUgaGFuZGxlZCBieSB0aGlzIG1h
Y2hpbmUKQnJva2VuIHBpcGUKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0
LmM6MTQwOiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBl
bmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQpFUlJPUiAtIG1pc3NpbmcgdGVz
dCBwbGFuCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCgpMb29raW5nIGZvciBleHBlY3RlZCBmaWxl
ICd0ZXN0cy9kYXRhL2FjcGkvdmlydC9GQUNQLm51bWFtZW0nCi0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD1iMjkzOTM3NGY0MGE0NGExYTkxYmQwYjU5Nzg4ZTNlNCcsICct
dScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRj
aGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWJxbHQxejdwL3NyYy9kb2NrZXItc3JjLjIwMjAt
MDItMTAtMDguMzIuMzUuNTQ4NDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3Jywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
YjI5MzkzNzRmNDBhNDRhMWE5MWJkMGI1OTc4OGUzZTQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtYnFsdDF6N3Avc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0Bj
ZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDExbTI3LjQ0NnMKdXNlciAgICAwbTguODQ1cwoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAy
MTAxMzE1MjMuMjc1NDAtMS1lcmljLmF1Z2VyQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVp
Y2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

