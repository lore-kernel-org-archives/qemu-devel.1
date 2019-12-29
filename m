Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3F9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 13:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297652071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 13:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ejP2K8MI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297652071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52227 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilYoy-000595-6I
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 08:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kvmluck@163.com>) id 1ilYnr-0004R9-0O
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 08:40:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kvmluck@163.com>) id 1ilYnn-0006HN-03
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 08:40:16 -0500
Received: from m13-37.163.com ([220.181.13.37]:27558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kvmluck@163.com>) id 1ilYnl-0005MA-Ny
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 08:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=aqyNT
 CLsWotDG722/uL/In/KHezf7X1vHiIzYlyMYKg=; b=ejP2K8MI4DRIRIi2NnGYV
 2QvMUgDqUh/PPSCY6TUCYfAY/q5ZiE/KX0s9Jy4XmYDc6wQDA7fGy9wKesVU3Ai0
 iM9tdVLWvgL3Fuzq0tsj9ayuFf4hhUX4jMuAcHEA0TubR0Hllc2KLKLFxgq4rzG9
 EilDlokjmuSE35vTxrkmIw=
Received: from kvmluck$163.com ( [218.241.252.184] ) by ajax-webmail-wmsvr37
 (Coremail) ; Sun, 29 Dec 2019 21:24:32 +0800 (CST)
X-Originating-IP: [218.241.252.184]
Date: Sun, 29 Dec 2019 21:24:32 +0800 (CST)
From: yue  <kvmluck@163.com>
To: qemu-devel <qemu-devel@nongnu.org>, stefanha@redhat.com,
 jasowang@redhat.com
Subject: virtio-net  has a sudden high latency
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <45b54112.86f0.16f51d46a01.Coremail.kvmluck@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: JcGowAB3fxsQqQheS94_Ag--.55482W
X-CM-SenderInfo: xnypz3lfn6il2tof0z/1tbiKROaiVXlukwRzgACsy
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.13.37
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksIGFsbC7CoHZpcnRpby1uZXQgwqBoYXMgYSBzdWRkZW4gaGlnaCBsYXRlbmN5IHdoZW4gcmVj
ZWl2aW5nLiDCoGkgdGhpbmsgaXQgaXMgaXJxIHJlbGF0ZWQsIGJ1dCBpIGhhdmUgbm8gaWRlYSB0
byBmaXggaXQuCmNlbnRvc8KgMy4xMC4wLTY5My4yMS4xLmVsNy54ODZfNjQgO8KgcWVtdS1rdm0t
ZXYtMi42LjAtMjguZWw3XzMuOS4xLng4Nl82NCDCoDsgwqDCoApwaHlzaWNhbCBtYWNoaW5lIGhh
cyA0MCBjcHVzLCDCoCB0aGUgdHdvIHZtcyBhcmUgb24gdGhlIHNhbWUgbm9kZSwgwqBjcHUgbG9h
ZCBpcyB2ZXJ5IGxvdy4KCgoxKSBwaWMxOsKgwqBpbnNpZGXCoHZtMSgxOTIuMTY4LjkxLjQpwqAs
wqBwaW5nwqAxOTIuMTY4LjkxLjU7IMKgcGxlYXNlIG5vdGljZcKgaWNtcCBzZXHCoMKgMjAKWzE1
NzcyNTI0NTYuNjAwNDI2XSA2NCBieXRlcyBmcm9tIDE5Mi4xNjguOTEuNTogaWNtcF9zZXE9MTIg
dHRsPTY0IHRpbWU9MC42OTIgbXMKWzE1NzcyNTI0NTcuNjAwNTE0XSA2NCBieXRlcyBmcm9tIDE5
Mi4xNjguOTEuNTogaWNtcF9zZXE9MTMgdHRsPTY0IHRpbWU9MC40NjIgbXMKWzE1NzcyNTI0NTgu
NjAwNTkwXSA2NCBieXRlcyBmcm9tIDE5Mi4xNjguOTEuNTogaWNtcF9zZXE9MTQgdHRsPTY0IHRp
bWU9MC4zOTYgbXMKWzE1NzcyNTI0NTkuNjAwOTIyXSA2NCBieXRlcyBmcm9tIDE5Mi4xNjguOTEu
NTogaWNtcF9zZXE9MTUgdHRsPTY0IHRpbWU9MC44ODggbXMKWzE1NzcyNTI0NjAuNjAwNDQ1XSA2
NCBieXRlcyBmcm9tIDE5Mi4xNjguOTEuNTogaWNtcF9zZXE9MTYgdHRsPTY0IHRpbWU9MC4zNTUg
bXMKWzE1NzcyNTI0NjEuNjAxMzI4XSA2NCBieXRlcyBmcm9tIDE5Mi4xNjguOTEuNTogaWNtcF9z
ZXE9MTcgdHRsPTY0IHRpbWU9MC4zMTEgbXMKWzE1NzcyNTI0NjIuNjAwNDQ5XSA2NCBieXRlcyBm
cm9tIDE5Mi4xNjguOTEuNTogaWNtcF9zZXE9MTggdHRsPTY0IHRpbWU9MC40MjQgbXMKWzE1Nzcy
NTI0NjMuNjAxNzI1XSA2NCBieXRlcyBmcm9tIDE5Mi4xNjguOTEuNTogaWNtcF9zZXE9MTkgdHRs
PTY0IHRpbWU9MC4zMjIgbXMKWzE1NzcyNTI0NjQuNjA2NzUyXSA2NCBieXRlcyBmcm9tIDE5Mi4x
NjguOTEuNTogaWNtcF9zZXE9MjAgdHRsPTY0IHRpbWU9NS42NSBtcwpbMTU3NzI1MjQ2NS42MDM1
NjldIDY0IGJ5dGVzIGZyb20gMTkyLjE2OC45MS41OiBpY21wX3NlcT0yMSB0dGw9NjQgdGltZT0w
LjQzOCBtcwpbMTU3NzI1MjQ2Ni42MDM2NzldIDY0IGJ5dGVzIGZyb20gMTkyLjE2OC45MS41OiBp
Y21wX3NlcT0yMiB0dGw9NjQgdGltZT0wLjQ5NCBtcwpbMTU3NzI1MjQ2Ny42MDM1NDVdIDY0IGJ5
dGVzIGZyb20gMTkyLjE2OC45MS41OiBpY21wX3NlcT0yMyB0dGw9NjQgdGltZT0wLjQzMSBtcwoK
CnRjcGR1bXAgaW5zaWRlIHZtMSA7wqAKCjEzOjQxOjA0LjYwMTAxNiBJUCAxOTIuMTY4LjkxLjQg
PiAxOTIuMTY4LjkxLjU6IElDTVAgZWNobyByZXF1ZXN0LCBpZCAxODM3NSwgc2VxIDIwLCBsZW5n
dGggNjQKMTM6NDE6MDQuNjA2NjQ3IElQIDE5Mi4xNjguOTEuNSA+IDE5Mi4xNjguOTEuNDogSUNN
UCBlY2hvIHJlcGx5LCBpZCAxODM3NSwgc2VxIDIwLCBsZW5ndGggNjQKCjIpIGNhcHR1cmUgcGFj
a2V0IG9uIGl0cyBiYWNrZW5kIHRhcCBkZXZpY2Ugb24gaHlwZXJ2aXNvciA7IMKgwqDCoHRjcGR1
bXAgLW5uIC1pIHRhcDU4MDNjNTc1LTRhIGljbXAgYW5kIGhvc3QgMTkyLjE2OC45MS41IGFuZCBo
b3N0IDE5Mi4xNjguOTEuNAoKMTM6NDE6MDQuNjAxMTY2IElQIDE5Mi4xNjguOTEuNCA+IDE5Mi4x
NjguOTEuNTogSUNNUCBlY2hvIHJlcXVlc3QsIGlkIDE4Mzc1LCBzZXEgMjAsIGxlbmd0aCA2NAox
Mzo0MTowNC42MDEzNjIgSVAgMTkyLjE2OC45MS41ID4gMTkyLjE2OC45MS40OiBJQ01QIGVjaG8g
cmVwbHksIGlkIDE4Mzc1LCBzZXEgMjAsIGxlbmd0aCA2NAppdCBzaG93cyDCoHRhcCB0YWtlcyBu
byBtdWNoIHRpbWUgYmV0d2VlbiBzZW5kIGFuZCByZWNlaXZlLgoKMykKNjA2NjQ3IC3CoDYwMTM2
MiA9IDUuM21zICwgwqB0aGlzIGlzIGNvbnN1bWVkIGJ5IHZpcnRpby1uZXQuCnNpbWlsYXJseSwg
d2hlbiAxOTIuMTY4LjkxLjUgcmVjZWl2ZSBwYWNrZXRzIGZyb20gaXRzIGJhY2tlbmQsIGl0IGFs
c28gaGFzIHN1ZGRlbiBoaWdoIGxhdGVuY3kuCgoKZG8geW91IGFsbCBoYXZlIGFueSBpZGVhcz8K
Cgp0aGFua3MKCgoKCsKgCgoKwqA=

