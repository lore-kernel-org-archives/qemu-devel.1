Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B934C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C9C20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KvVMP5a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C9C20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaOg-0003pC-OA
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iyaLm-0003Jd-9u
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iyaLl-0004us-Af
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:57:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:38379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iyaLk-0004sR-0f
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580731007;
 bh=YZW+ZP2oTyKQ+Q5j/C9+wf0jv9TDzhGy8qTuuNuSuA0=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=KvVMP5a2v7eRa7V+Drh0hG9ef1D444fhr+3jPNaAYhDchgdKNKvzj/IT3QLE1oVP4
 AaqjxIm5N8nvxwio+7cg/dZ9EtvskVjtyJe6YCyE0zeh2ulEx7+8llNmTPiC2dp9fr
 ztTYvCI5OfcIt3A9arOeT9dxwSlotyOC5s17tyuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8hV5-1iuTjq2qkj-004jIl; Mon, 03
 Feb 2020 12:56:47 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, max@m00nbsd.net
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-3-n54@gmx.com>
 <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Subject: Re: [PATCH v2 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Message-ID: <4e29b732-ce95-02f1-ec9c-31f1ce33cda0@gmx.com>
Date: Mon, 3 Feb 2020 12:56:03 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e3279b9d-e6f9-43f3-3ebb-b31ba8ff5f7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+o3i7g/w89RSO1IrIuD0puusJ9Pz8sL+Yyq3mRfmAQtP/23cS1y
 UjFRDBjQCbVVejkaOZJs6IBa7tQNf6VPrmjH7c5N2+E9Lola1P6ZRzuQ1Q2kVyw9bMl9Z4T
 6uObGc6N+t8P+nNZ4ShXJcy8XpIgP2Ej2HxmYIiqeZTuQJUBLZELTZ2VESkzMwJKT6y52Oo
 oaWnpsK9WqFvXbciczUcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJRpew0xFKo=:HMk4YwjH/XamT6OkcvplTB
 VGzx5lydZ9uajPKEX/1tnB7TCJewTctOyHQGGjHa8fzrbdSWJlZW5kVnrKwQTWMCWvN6iLSMd
 aQoBSEqAObiyjcAs+QvBUCsf94BJbVResBBfbWiNn4IADJz4vFdTarmR5dxm0Np8iTjtXWMQa
 PNe0wC9xGDpWEDuESr3Po6zXMlHljhDMutW8fTKeSUZkj7Kp7For9702qO5Yruvm16rUcxLsz
 wMwNk9AqgC8p8tD1Uss02ErIY9DpddsjPMu7wseSswA+xixHE0IBSr1EwVjH/BY/joWMKkB+C
 YLNAKOPDKx3EEdUzJ6HwJev4yZZ0HrsaEihjBTlims5RO7EnMfsIdU4Ht84v40fQMPGTX+UCs
 9TdLM6NucabfEox/SsUekRRd9bGd5oS/THnuIG7hAjHB3tZVQV5QsW4YUfUkP/I0rsPJcMWtS
 T9kzDY8OHDpOghMtwIazlMXuvERLZcHwn5Hwu0ltoPDqM29wq8vzLvoxI+2co9m1zIO8NUO/5
 9HkdXQwHYBCeZLjxQyUX+yMxMElnRh5iEnou7CcBJ15wJyQ2o+RDLmJdAC1P3d9TNSqW86jI3
 YavOnCrSchTOc3G4979PxVkrCDn4Hrm7dureg4wxKv7nHpf3kNsArEy/AVOuwpYw8Dm28Mpnk
 48TxK6BUCcFLsvat+F0jwPzr01fIxQmj+gBa4MKow+xrxYw/NbqFJu8naDLeJ+aEfsxTbC0Op
 lj4Ja900/0XSriSIPWSCofhCl964sIFbfYFjmIg/VqigqFKUgnIfRAy4YuBljsW6LkPKtjre1
 5uUW3yM7Knsk/thqOJ6lbGgXIxBzMKyOT0SCbIqPYhXUzz4wBj8fGX1vdngyq/RjrdYETAKYI
 GLlWCPq9/EZrZ3IzrpnTpxHj4gNekvuLD4+c7TuS8tFbh77vqEaXyhTpFJAZxJ2POIteF8PAJ
 /PsNI1K6yNvOXh9HRvM262UL1ltmi6MUxKGXCk1rDxpHOLc0dkikHnF5H6HPQUEcbTJSeyp1I
 Ny9PYDw/4BXR4ubEJ6zTvL6QLrfrwNb7IZ8hA29E0ANtRiSBs5tDYfFtdYIgYF0GZkOzK5Gs6
 MMgNOwttCWeMR6QyfSulexrnllNfuxVIjg7Sd1GBdlnfrRgDYwkU3kCiq4+YLqEJx4EzlTOCc
 u9dOjTL/HKnF59TyqPGxnrSsu49H66wgUQu96NX5ocBaACHKm+RisPCXYXm3/YIcjFeqA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMDMuMDIuMjAyMCAxMjo0MSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+PiBA
QCAtMTc2OCw2ICsxNzg1LDcgQEAgZGlzYWJsZWQgd2l0aCAtLWRpc2FibGUtRkVBVFVSRSwgZGVm
YXVsdCBpcw0KPj4gZW5hYmxlZCBpZiBhdmFpbGFibGU6DQo+PiDCoMKgwqAgaGF4wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIEhBWCBhY2NlbGVyYXRpb24gc3VwcG9ydA0KPj4gwqDCoMKgIGh2ZsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIeXBlcnZpc29yLmZyYW1ld29yayBhY2NlbGVyYXRpb24g
c3VwcG9ydA0KPj4gwqDCoMKgIHdocHjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdpbmRvd3MgSHlw
ZXJ2aXNvciBQbGF0Zm9ybSBhY2NlbGVyYXRpb24gc3VwcG9ydA0KPj4gK8KgIG52bW3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE5ldEJTRCBWaXJ0dWFsIE1hY2hpbmUgTW9uaXRvciBhY2NlbGVyYXRp
b24gc3VwcG9ydA0KPj4gwqDCoMKgIHJkbWHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVuYWJsZSBS
RE1BLWJhc2VkIG1pZ3JhdGlvbg0KPj4gwqDCoMKgIHB2cmRtYcKgwqDCoMKgwqDCoMKgwqDCoCBF
bmFibGUgUFZSRE1BIHN1cHBvcnQNCj4+IMKgwqDCoCB2ZGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3VwcG9ydCBmb3IgdmRlIG5ldHdvcmsNCj4+IEBAIC0yNzU3LDYgKzI3NzUsMjAgQEAgaWYg
dGVzdCAiJHdocHgiICE9ICJubyIgOyB0aGVuDQo+PiDCoMKgwqDCoMKgIGZpDQo+PiDCoCBmaQ0K
Pj4NCj4gDQo+IE1heWJlIHlvdSBjYW4gYWRkIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gaWYgdGVz
dCAiJHRhcmdldG9zIiA9ICJOZXRCU0QiOyB0aGVuDQo+IMKgwqDCoCBudm1tPSJjaGVjayINCj4g
ZmkNCj4gDQo+IHRvIGJ1aWxkIGJ5IGRlZmF1bHQgd2l0aCBOVk1NIGlmIGF2YWlsYWJsZS4NCg0K
SSB3aWxsIGFkZCBudm1tPXllcyB0byB0aGUgTmV0QlNEKSB0YXJnZXRvcyBjaGVjayBzZWN0aW9u
Lg0K

