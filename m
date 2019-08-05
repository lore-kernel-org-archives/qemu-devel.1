Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55701C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1282A20880
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="nyx0gsfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1282A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huYcE-00075Z-4w
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 04:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hope2hope@163.com>) id 1huYbi-00067K-IR
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hope2hope@163.com>) id 1huYbh-00065E-8y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:44:42 -0400
Received: from m13-149.163.com ([220.181.13.149]:19142)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <hope2hope@163.com>)
 id 1huYbd-0005wW-8u; Mon, 05 Aug 2019 04:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Ck7VA
 1+y1268bSjolO9FR5VtSqugsCRXOdz13zt2Dg4=; b=nyx0gsfeO0KbfGvA+dSSd
 NHGhAE8o4ev/V5xhfpIikdTUaarUjrLqidXdD92cKtN4/oYp7vDVINWkjIszZauw
 hhE49kLsOy7YAKoAPtkvxSEKCi1AH9FX1dj1gZjK1ZaY5y6gt9Q3LoNF9s/bGSdX
 mLuZS3e5Bh1Yk0NnEtM0kY=
Received: from hope2hope$163.com ( [36.152.9.226] ) by ajax-webmail-wmsvr149
 (Coremail) ; Mon, 5 Aug 2019 16:44:24 +0800 (CST)
X-Originating-IP: [36.152.9.226]
Date: Mon, 5 Aug 2019 16:44:24 +0800 (CST)
From: ddm  <hope2hope@163.com>
To: "Li Qiang" <liq3ea@gmail.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 163com
In-Reply-To: <CAKXe6S+Eu29SrVrGcCO-wrtQqmMa6Q-MXnsFV03ddx1LrXBYKA@mail.gmail.com>
References: <7f455f0d.730d.16c5fdc21af.Coremail.hope2hope@163.com>
 <CAKXe6SKMS__GaxTL4rkTBFpCpRkRS_bHoJx8=6w6WktFr5K9XQ@mail.gmail.com>
 <70dbf96f.87bc.16c60385de4.Coremail.hope2hope@163.com>
 <CAKXe6S+Eu29SrVrGcCO-wrtQqmMa6Q-MXnsFV03ddx1LrXBYKA@mail.gmail.com>
X-CM-CTRLDATA: UBiVQ2Zvb3Rlcl9odG09NTQzNjo1Ng==
MIME-Version: 1.0
Message-ID: <161dfd83.d05d.16c60f3776b.Coremail.hope2hope@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lcGowABHx6tp7EddQVnWAQ--.2091W
X-CM-SenderInfo: pkrsvjpkrsvqqrwthudrp/1tbiPQQIK1SIct1uzwACsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.13.149
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] How to configure QEMU to support APIC
 virtualization
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T2ssIEZpbmFsbHkgZG9uJ3QgaGF2ZSB0byB0YW5nbGUgaXQgIF4uXgpUaGFuayB5b3UgdmVyeSBt
dWNoIQoKCgpBdCAyMDE5LTA4LTA1IDEzOjU0OjM2LCAiTGkgUWlhbmciIDxsaXEzZWFAZ21haWwu
Y29tPiB3cm90ZToKCgoKCgpkZG0gPGhvcGUyaG9wZUAxNjMuY29tPiDT2jIwMTnE6jjUwjXI1dbc
0rsgz8LO5zE6MjDQtLXAo7oKCkhpLCAKCgpBcyBpIGtub3csIEtWTSBpcyBiYXNlZCBvbiBwYXNz
dGhyb3VnaCBob3N0IGNwdSB0byBpbXBsZW1lbnQgZnVsbC12aXJ0dWFsaXp0aW9uLCAKaWYgaG9z
dCBjcHUgZG9lc24ndCBzdXBwb3J0IHRoaXMgZmVhdHVyZSwgaXQncyBpbXBvc3NpYmxlIHRvIHR1
cm4gb24gdGhpcyBmZWF0dXJlIGJ5IEtWTS4KV2hlaGVyIHRoZXJlIGFyZSBhbm90aGVyIHdheXMg
aW4gUUVNVSB0byBlbXVsYXRlIHRoaXMgZmVhdHVyZaOsc3VjaCBhcyBlbXVsYXRlIGl0IGJhc2Vk
IG9uIHB1cmUgc29mdHdhcmUsIG5vdCByZWx5IG9uIGhhcmR3YXJlLgoKCgoKSUlVQyB0aGVyZSBp
cyBubyBBUElDdiBlbXVsYXRlLgoKCgoKVGhhbmtzLApMaSBRaWFuZwoKCiAKVGhhbmtzIQoKCgpB
dCAyMDE5LTA4LTA1IDEyOjQyOjU1LCAiTGkgUWlhbmciIDxsaXEzZWFAZ21haWwuY29tPiB3cm90
ZToKCgoKCgpkZG0gPGhvcGUyaG9wZUAxNjMuY29tPiDT2jIwMTnE6jjUwjXI1dbc0rsgyc/O5zEx
OjU10LS1wKO6CgpIaSBndXlzLAoKCkkgaGF2ZSB0cmllZCB2aWEgbW9kcHJvYmUga3ZtaW50ZWwg
ZW5hYmxlX2FwaWN2PVkgIHRvIGFkanVzdCBLVk0gcGFyYW1ldGVyLCBidXQgaXQgZG9lc24ndCBl
ZmZlY3QsICBhbmQKY2F0IC9zeXMvbW9kdWxlL2t2bV9pbnRlbC9wYXJhbWV0ZXJzL2VuYWJsZV9h
cGljdiBhbHdheXMgcmV0dXJuICJOIi4KSSBkb24ndCBrbm93IGhvdyB0byBjb25maWd1cmUgS1ZN
IG9yIFFFTVUgdG8gc3VwcG9ydCBBUElDIHZpcnR1YWxpemFpb24gZmVhdHVyZT8KCgoKCkFGQUlD
VCBBUElDdiBpcyBoYXJkd2FyZSBmZWF0dXJlLCBidXQgSSBzdGlsbCBkb24ndCBrbm93IGFjY3Vy
YXRlbHkgYWZ0ZXIgd2hpY2ggQ1BVIHN1cHBvcnQgaXQuCllvdSBtYXkgcmVmZXIgdGhlIGNvZGUg
YWJvdXQgJ2VuYWJsZV9hcGljdicgcmVsYXRlZCBjb2RlIGluIGt2bSB0byBzZWUgaG93IHRvIGRl
dGVjdCB0aGlzIGNhcGFiaWxpdHkuCgoKVGhhbmtzLApMaSBRaWFuZwogCgpNeSBob3N0IGluZm9z
IGFyZSBhcyBmb2xsb3dzOgpBcmNoaXRlY3R1cmU6ICAgICAgICAgIHg4Nl82NApDUFUgb3AtbW9k
ZShzKTogICAgICAgIDMyLWJpdCwgNjQtYml0CkJ5dGUgT3JkZXI6ICAgICAgICAgICAgTGl0dGxl
IEVuZGlhbgpDUFUocyk6ICAgICAgICAgICAgICAgIDEKT24tbGluZSBDUFUocykgbGlzdDogICAw
ClRocmVhZChzKSBwZXIgY29yZTogICAgMQpDb3JlKHMpIHBlciBzb2NrZXQ6ICAgIDEKU29ja2V0
KHMpOiAgICAgICAgICAgICAxCk5VTUEgbm9kZShzKTogICAgICAgICAgMQpWZW5kb3IgSUQ6ICAg
ICAgICAgICAgIEdlbnVpbmVJbnRlbApDUFUgZmFtaWx5OiAgICAgICAgICAgIDYKTW9kZWw6ICAg
ICAgICAgICAgICAgICAxNDIKTW9kZWwgbmFtZTogICAgICAgICAgICBJbnRlbChSKSBDb3JlKFRN
KSBpNy04NjUwVSBDUFUgQCAxLjkwR0h6ClN0ZXBwaW5nOiAgICAgICAgICAgICAgMTAKQ1BVIE1I
ejogICAgICAgICAgICAgICAyMTEyLjAwMQpCb2dvTUlQUzogICAgICAgICAgICAgIDQyMjQuMDAK
VmlydHVhbGl6YXRpb246ICAgICAgICBWVC14Ckh5cGVydmlzb3IgdmVuZG9yOiAgICAgVk13YXJl
ClZpcnR1YWxpemF0aW9uIHR5cGU6ICAgZnVsbApMMWQgY2FjaGU6ICAgICAgICAgICAgIDMySwpM
MWkgY2FjaGU6ICAgICAgICAgICAgIDMySwpMMiBjYWNoZTogICAgICAgICAgICAgIDI1NksKTDMg
Y2FjaGU6ICAgICAgICAgICAgICA4MTkySwpOVU1BIG5vZGUwIENQVShzKTogICAgIDAKRmxhZ3M6
ICAgICAgICAgICAgICAgICBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMg
c2VwIG10cnIgcGdlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZsdXNoIG1teCBmeHNyIHNzZSBzc2Uy
IHNzIHN5c2NhbGwgbnggcGRwZTFnYiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFyY2hfcGVyZm1v
biBub3BsIHh0b3BvbG9neSB0c2NfcmVsaWFibGUgbm9uc3RvcF90c2MgY3B1aWQgcG5pIHBjbG11
bHFkcSB2bXggc3NzZTMgZm1hIGN4MTYgcGNpZCBzc2U0XzEgc3NlNF8yIHgyYXBpYyBtb3ZiZSBw
b3BjbnQgdHNjX2RlYWRsaW5lX3RpbWVyIGFlcyB4c2F2ZSBhdnggZjE2YyByZHJhbmQgaHlwZXJ2
aXNvciBsYWhmX2xtIGFibSAzZG5vd3ByZWZldGNoIGNwdWlkX2ZhdWx0IGludnBjaWRfc2luZ2xl
IHB0aSBzc2JkIGlicnMgaWJwYiBzdGlicCB0cHJfc2hhZG93IHZubWkgZXB0IHZwaWQgZnNnc2Jh
c2UgdHNjX2FkanVzdCBibWkxIGhsZSBhdngyIHNtZXAgYm1pMiBpbnZwY2lkIHJ0bSByZHNlZWQg
YWR4IHNtYXAgeHNhdmVvcHQgYXJhdCBmbHVzaF9sMWQgYXJjaF9jYXBhYmlsaXRpZXMKCgpDb3Vs
ZCB5b3UgdGVsbCBtZSBob3cgdG8gY29uZmlndXJlIGl0PwoKClRoYW5rcyEKCgoKCgoKIA==
