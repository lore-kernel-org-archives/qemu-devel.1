Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C26C22226
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DFL1D9GT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C26C22226
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbxL-0003S4-A6
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=543da8664=graf@amazon.de>)
 id 1kQbw9-0002y2-UG
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:50:50 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:16858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=543da8664=graf@amazon.de>)
 id 1kQbw7-0001Dp-4N
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1602186647; x=1633722647;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=jYYAxaF0vQWifMiG+uK70R9AoMr4h9Q1fTyVhFFAwhA=;
 b=DFL1D9GT58lFBEEEbJgqhePog6LBvt9F1CorqsYKm4hQc2d65xADGeG+
 sy2hd4EtlG9LBlZuY5z611MsO3NUVS/lgJ/HiALA92JH1TpGXZPF/CAMH
 7gy2SEDMJnpPQczPJiPVwFK/yYa0Jegfdeig7a11OnFMFCVp2fZtlHYcj g=;
X-IronPort-AV: E=Sophos;i="5.77,351,1596499200"; d="scan'208";a="74598211"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP;
 08 Oct 2020 19:50:38 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS
 id 77B6AA1D86; Thu,  8 Oct 2020 19:50:37 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 8 Oct 2020 19:50:36 +0000
Received: from Alexanders-MacBook-Air.local (10.43.161.24) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 8 Oct 2020 19:50:34 +0000
Subject: Re: [RFC PATCH 02/21] contrib/gitdm: Add Amazon to the domain map
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 <qemu-devel@nongnu.org>
CC: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Anthony Liguori
 <aliguori@amazon.com>, Craig Janeczek <jancraig@amazon.com>, Paul Durrant
 <pdurrant@amazon.com>, Hendrik Borghorst <hborghor@amazon.de>, Julien Grall
 <jgrall@amazon.com>, KarimAllah Ahmed <karahmed@amazon.de>, Simon Veith
 <sveith@amazon.de>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-3-f4bug@amsat.org>
From: Alexander Graf <graf@amazon.com>
Message-ID: <95dcdcbc-1dbb-8bc1-917f-0827ac552ebd@amazon.com>
Date: Thu, 8 Oct 2020 21:50:32 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201004180443.2035359-3-f4bug@amsat.org>
Content-Language: en-US
X-Originating-IP: [10.43.161.24]
X-ClientProxiedBy: EX13D32UWA001.ant.amazon.com (10.43.160.4) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Precedence: Bulk
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.184.25;
 envelope-from=prvs=543da8664=graf@amazon.de; helo=smtp-fw-9101.amazon.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 15:50:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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

CgpPbiAwNC4xMC4yMCAyMDowNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6Cj4gCj4g
VGhlcmUgaXMgYSBudW1iZXIgb2YgY29udHJpYnV0b3JzIGZyb20gdGhpcyBkb21haW4sCj4gYWRk
IGl0cyBvd24gZW50cnkgdG8gdGhlIGdpdGRtIGRvbWFpbiBtYXAuCj4gCj4gQ2M6IEFsZXhhbmRl
ciBHcmFmIDxncmFmQGFtYXpvbi5jb20+Cj4gQ2M6IEFudGhvbnkgTGlndW9yaSA8YWxpZ3VvcmlA
YW1hem9uLmNvbT4KPiBDYzogQ3JhaWcgSmFuZWN6ZWsgPGphbmNyYWlnQGFtYXpvbi5jb20+Cj4g
Q2M6IFBhdWwgRHVycmFudCA8cGR1cnJhbnRAYW1hem9uLmNvbT4KPiBDYzogSGVuZHJpayBCb3Jn
aG9yc3QgPGhib3JnaG9yQGFtYXpvbi5kZT4KPiBDYzogSnVsaWVuIEdyYWxsIDxqZ3JhbGxAYW1h
em9uLmNvbT4KPiBDYzogS2FyaW1BbGxhaCBBaG1lZCA8a2FyYWhtZWRAYW1hem9uLmRlPgo+IENj
OiBTaW1vbiBWZWl0aCA8c3ZlaXRoQGFtYXpvbi5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8ZjRidWdAYW1zYXQub3JnPgo+IC0tLQo+IE9uZSBSZXZpZXdlZC1i
eS9BY2stYnkgZnJvbSBzb21lb25lIGZyb20gdGhpcyBkb21haW4KPiBzaG91bGQgYmUgc3VmZmlj
aWVudCB0byBnZXQgdGhpcyBwYXRjaCBtZXJnZWQuCgpBY2tlZC1ieTogQWxleGFuZGVyIEdyYWYg
PGdyYWZAYW1hem9uLmNvbT4KCgpBbGV4Cgo+IC0tLQo+ICAgY29udHJpYi9naXRkbS9kb21haW4t
bWFwIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYg
LS1naXQgYS9jb250cmliL2dpdGRtL2RvbWFpbi1tYXAgYi9jb250cmliL2dpdGRtL2RvbWFpbi1t
YXAKPiBpbmRleCBlZGZmOTFiMjhjLi4yOTU2ZjllNGRlIDEwMDY0NAo+IC0tLSBhL2NvbnRyaWIv
Z2l0ZG0vZG9tYWluLW1hcAo+ICsrKyBiL2NvbnRyaWIvZ2l0ZG0vZG9tYWluLW1hcAo+IEBAIC01
LDYgKzUsOCBAQAo+ICAgIwo+IAo+ICAgbGludXguYWxpYmFiYS5jb20gQWxpYmFiYQo+ICthbWF6
b24uY29tICAgICAgQW1hem9uCj4gK2FtYXpvbi5kZSAgICAgICBBbWF6b24KPiAgIGFtZC5jb20g
ICAgICAgICBBTUQKPiAgIGNtc3MuY2hpbmFtb2JpbGUuY29tIENoaW5hIE1vYmlsZQo+ICAgY2l0
cml4LmNvbSAgICAgIENpdHJpeAo+IC0tCj4gMi4yNi4yCj4gCgoKCkFtYXpvbiBEZXZlbG9wbWVu
dCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFl
ZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJh
Z2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6
OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==


