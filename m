Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A160DC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A33D2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 05:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="YnGDDBTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A33D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huVQf-0007ci-Ig
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 01:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hope2hope@163.com>) id 1huVPs-0006hZ-6a
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hope2hope@163.com>) id 1huVPq-0003S2-Sr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 01:20:16 -0400
Received: from m13-149.163.com ([220.181.13.149]:57281)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <hope2hope@163.com>)
 id 1huVPl-0003ID-Or; Mon, 05 Aug 2019 01:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=NuBwv
 UkgfJOcMVP+YkWKL6fFePpMZ4PfhLcO5dS1BuA=; b=YnGDDBTYXm6TzE8kIlHd3
 3O7KnHF7sSCi1NolX48IJpo3wV88+9RDRp9amTyGpUQACRzeWrS4hiYkObj2B252
 OIlMKoX6R0nc5i3eWbg8aOkQW5le/jg8EcFs26Dd4Zp2GFFwQLcbXt0FyYv7PtEv
 39zFdwrbX4xClR3Xl/Si/Q=
Received: from hope2hope$163.com ( [36.152.9.226] ) by ajax-webmail-wmsvr149
 (Coremail) ; Mon, 5 Aug 2019 13:20:02 +0800 (CST)
X-Originating-IP: [36.152.9.226]
Date: Mon, 5 Aug 2019 13:20:02 +0800 (CST)
From: ddm  <hope2hope@163.com>
To: "Li Qiang" <liq3ea@gmail.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 163com
In-Reply-To: <CAKXe6SKMS__GaxTL4rkTBFpCpRkRS_bHoJx8=6w6WktFr5K9XQ@mail.gmail.com>
References: <7f455f0d.730d.16c5fdc21af.Coremail.hope2hope@163.com>
 <CAKXe6SKMS__GaxTL4rkTBFpCpRkRS_bHoJx8=6w6WktFr5K9XQ@mail.gmail.com>
X-CM-CTRLDATA: /7eSvmZvb3Rlcl9odG09NDA3MTo1Ng==
MIME-Version: 1.0
Message-ID: <70dbf96f.87bc.16c60385de4.Coremail.hope2hope@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lcGowABXdzWCvEddq+bVAQ--.3934W
X-CM-SenderInfo: pkrsvjpkrsvqqrwthudrp/1tbi8AIIK1uoUMVNwgAAs4
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

SGksIAoKCkFzIGkga25vdywgS1ZNIGlzIGJhc2VkIG9uIHBhc3N0aHJvdWdoIGhvc3QgY3B1IHRv
IGltcGxlbWVudCBmdWxsLXZpcnR1YWxpenRpb24sIAppZiBob3N0IGNwdSBkb2Vzbid0IHN1cHBv
cnQgdGhpcyBmZWF0dXJlLCBpdCdzIGltcG9zc2libGUgdG8gdHVybiBvbiB0aGlzIGZlYXR1cmUg
YnkgS1ZNLgpXaGVoZXIgdGhlcmUgYXJlIGFub3RoZXIgd2F5cyBpbiBRRU1VIHRvIGVtdWxhdGUg
dGhpcyBmZWF0dXJlo6xzdWNoIGFzIGVtdWxhdGUgaXQgYmFzZWQgb24gcHVyZSBzb2Z0d2FyZSwg
bm90IHJlbHkgb24gaGFyZHdhcmUuCgoKVGhhbmtzIQoKCgpBdCAyMDE5LTA4LTA1IDEyOjQyOjU1
LCAiTGkgUWlhbmciIDxsaXEzZWFAZ21haWwuY29tPiB3cm90ZToKCgoKCgpkZG0gPGhvcGUyaG9w
ZUAxNjMuY29tPiDT2jIwMTnE6jjUwjXI1dbc0rsgyc/O5zExOjU10LS1wKO6CgpIaSBndXlzLAoK
CkkgaGF2ZSB0cmllZCB2aWEgbW9kcHJvYmUga3ZtaW50ZWwgZW5hYmxlX2FwaWN2PVkgIHRvIGFk
anVzdCBLVk0gcGFyYW1ldGVyLCBidXQgaXQgZG9lc24ndCBlZmZlY3QsICBhbmQKY2F0IC9zeXMv
bW9kdWxlL2t2bV9pbnRlbC9wYXJhbWV0ZXJzL2VuYWJsZV9hcGljdiBhbHdheXMgcmV0dXJuICJO
Ii4KSSBkb24ndCBrbm93IGhvdyB0byBjb25maWd1cmUgS1ZNIG9yIFFFTVUgdG8gc3VwcG9ydCBB
UElDIHZpcnR1YWxpemFpb24gZmVhdHVyZT8KCgoKCkFGQUlDVCBBUElDdiBpcyBoYXJkd2FyZSBm
ZWF0dXJlLCBidXQgSSBzdGlsbCBkb24ndCBrbm93IGFjY3VyYXRlbHkgYWZ0ZXIgd2hpY2ggQ1BV
IHN1cHBvcnQgaXQuCllvdSBtYXkgcmVmZXIgdGhlIGNvZGUgYWJvdXQgJ2VuYWJsZV9hcGljdicg
cmVsYXRlZCBjb2RlIGluIGt2bSB0byBzZWUgaG93IHRvIGRldGVjdCB0aGlzIGNhcGFiaWxpdHku
CgoKVGhhbmtzLApMaSBRaWFuZwogCgpNeSBob3N0IGluZm9zIGFyZSBhcyBmb2xsb3dzOgpBcmNo
aXRlY3R1cmU6ICAgICAgICAgIHg4Nl82NApDUFUgb3AtbW9kZShzKTogICAgICAgIDMyLWJpdCwg
NjQtYml0CkJ5dGUgT3JkZXI6ICAgICAgICAgICAgTGl0dGxlIEVuZGlhbgpDUFUocyk6ICAgICAg
ICAgICAgICAgIDEKT24tbGluZSBDUFUocykgbGlzdDogICAwClRocmVhZChzKSBwZXIgY29yZTog
ICAgMQpDb3JlKHMpIHBlciBzb2NrZXQ6ICAgIDEKU29ja2V0KHMpOiAgICAgICAgICAgICAxCk5V
TUEgbm9kZShzKTogICAgICAgICAgMQpWZW5kb3IgSUQ6ICAgICAgICAgICAgIEdlbnVpbmVJbnRl
bApDUFUgZmFtaWx5OiAgICAgICAgICAgIDYKTW9kZWw6ICAgICAgICAgICAgICAgICAxNDIKTW9k
ZWwgbmFtZTogICAgICAgICAgICBJbnRlbChSKSBDb3JlKFRNKSBpNy04NjUwVSBDUFUgQCAxLjkw
R0h6ClN0ZXBwaW5nOiAgICAgICAgICAgICAgMTAKQ1BVIE1IejogICAgICAgICAgICAgICAyMTEy
LjAwMQpCb2dvTUlQUzogICAgICAgICAgICAgIDQyMjQuMDAKVmlydHVhbGl6YXRpb246ICAgICAg
ICBWVC14Ckh5cGVydmlzb3IgdmVuZG9yOiAgICAgVk13YXJlClZpcnR1YWxpemF0aW9uIHR5cGU6
ICAgZnVsbApMMWQgY2FjaGU6ICAgICAgICAgICAgIDMySwpMMWkgY2FjaGU6ICAgICAgICAgICAg
IDMySwpMMiBjYWNoZTogICAgICAgICAgICAgIDI1NksKTDMgY2FjaGU6ICAgICAgICAgICAgICA4
MTkySwpOVU1BIG5vZGUwIENQVShzKTogICAgIDAKRmxhZ3M6ICAgICAgICAgICAgICAgICBmcHUg
dm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBjbW92
IHBhdCBwc2UzNiBjbGZsdXNoIG1teCBmeHNyIHNzZSBzc2UyIHNzIHN5c2NhbGwgbnggcGRwZTFn
YiByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFyY2hfcGVyZm1vbiBub3BsIHh0b3BvbG9neSB0c2Nf
cmVsaWFibGUgbm9uc3RvcF90c2MgY3B1aWQgcG5pIHBjbG11bHFkcSB2bXggc3NzZTMgZm1hIGN4
MTYgcGNpZCBzc2U0XzEgc3NlNF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWRsaW5lX3Rp
bWVyIGFlcyB4c2F2ZSBhdnggZjE2YyByZHJhbmQgaHlwZXJ2aXNvciBsYWhmX2xtIGFibSAzZG5v
d3ByZWZldGNoIGNwdWlkX2ZhdWx0IGludnBjaWRfc2luZ2xlIHB0aSBzc2JkIGlicnMgaWJwYiBz
dGlicCB0cHJfc2hhZG93IHZubWkgZXB0IHZwaWQgZnNnc2Jhc2UgdHNjX2FkanVzdCBibWkxIGhs
ZSBhdngyIHNtZXAgYm1pMiBpbnZwY2lkIHJ0bSByZHNlZWQgYWR4IHNtYXAgeHNhdmVvcHQgYXJh
dCBmbHVzaF9sMWQgYXJjaF9jYXBhYmlsaXRpZXMKCgpDb3VsZCB5b3UgdGVsbCBtZSBob3cgdG8g
Y29uZmlndXJlIGl0PwoKClRoYW5rcyEKCg==
