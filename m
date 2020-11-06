Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7FCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B445208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B445208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ruijie.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayB9-00053n-Q4
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1kayA7-0004Wx-67
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:36:03 -0500
Received: from [240e:678:8c0:5::c0a8:3a62] (port=27451
 helo=FZEX3.ruijie.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lichun@ruijie.com.cn>)
 id 1kayA3-0006mh-TQ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:36:01 -0500
Received: from FZEX5.ruijie.com.cn ([fe80::f133:c96b:b8b4:690f]) by
 FZEX3.ruijie.com.cn ([fe80::9480:e49e:2190:b001%15]) with mapi id
 14.03.0123.003; Fri, 6 Nov 2020 17:35:50 +0800
From: <lichun@ruijie.com.cn>
To: <kraxel@redhat.com>
Subject: Re: Re: [PATCH] console: avoid passing con=NULL to
 graphic_hw_update_done() In graphic_hw_update(), first select an existing
 console, a specific-console or active_console(if not specified), then
 updating the console.
Thread-Topic: Re: [PATCH] console: avoid passing con=NULL to
 graphic_hw_update_done() In graphic_hw_update(), first select an existing
 console, a specific-console or active_console(if not specified), then
 updating the console.
Thread-Index: AQHWtB/3xk3iH7M07U+qMJmj9onc3g==
Date: Fri, 6 Nov 2020 09:35:50 +0000
Message-ID: <EEB2AE3E67807845A92E2350C6F5E02E0178EBB962@FZEX5.ruijie.com.cn>
References: <1604682219-114389-1-git-send-email-lichun@ruijie.com.cn>,
 <20201106092848.yqoajggs2pdqbhjm@sirius.home.kraxel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.20.101.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 240e:678:8c0:5::c0a8:3a62
 (failed)
Received-SPF: permerror client-ip=240e:678:8c0:5::c0a8:3a62;
 envelope-from=lichun@ruijie.com.cn; helo=FZEX3.ruijie.com.cn
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PsKgIEhpLAo+Cj5JZiB5b3UgaGF2ZSBhbiBsb25nIGNvbW1pdCBtZXNzYWdlIHB1dCBpdCBpbnRv
IHRoZSBib2R5IG5vdCB0aGUgc3ViamVjdAo+cGxlYXNlLiAKT2tleSwgSSBzaG91bGQgbGVhdmUg
YSBibGFuayBsaW5lLgo+Cj5PbiBTYXQsIE5vdiAwNywgMjAyMCBhdCAwMTowMzozOUFNICswODAw
LCBsaWNodW4gd3JvdGU6Cj4+IFNpZ25lZC1vZmYtYnk6IGxpY2h1biA8bGljaHVuQHJ1aWppZS5j
b20uY24+Cj4+IC0tLQo+PsKgIHVpL2NvbnNvbGUuYyB8IDUgKysrLS0KPj7CoCAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
dWkvY29uc29sZS5jIGIvdWkvY29uc29sZS5jCj4+IGluZGV4IGU4ZTU5NzAuLmUwN2QyYzMgMTAw
NjQ0Cj4+IC0tLSBhL3VpL2NvbnNvbGUuYwo+PiArKysgYi91aS9jb25zb2xlLmMKPj4gQEAgLTI3
MCwxMCArMjcwLDExIEBAIHZvaWQgZ3JhcGhpY19od191cGRhdGVfZG9uZShRZW11Q29uc29sZSAq
Y29uKQo+PsKgIHZvaWQgZ3JhcGhpY19od191cGRhdGUoUWVtdUNvbnNvbGUgKmNvbikKPj7CoCB7
Cj4+wqDCoMKgwqDCoCBib29sIGFzeW5jID0gZmFsc2U7Cj4+ICvCoMKgwqAgY29uID0gY29uID8g
Y29uIDogYWN0aXZlX2NvbnNvbGU7Cj4KPmNvbiBzaG91bGQgbm90IGJlIE5VTEwgYXQgdGhpcyBw
b2ludC4KPgo+Q2FuIHlvdSB0cmlnZ2VyIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGhlcmUg
c29tZWhvdz8gCnJ1biAjLi9xZW11LXN5c3RlbS14ODZfNjQgLW5vZGVmYXVsdHMgdGVzdC5pbWcg
LXZuYyAwLjAuMC4wOjAKVGhlbiBjb25uZWN0IHdpdGggVk5DIGNsaWVudCwgSXQgd2lsbCBjYXVz
ZSBRRU1VIENSQVNILgo+Cj50aGFua3MsCj7CoCBHZXJkCj4=

