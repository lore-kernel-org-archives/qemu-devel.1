Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F856C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D6920673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D6920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8pU-0007oT-BY
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:08:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL8nb-0006iX-LQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL8nX-00007j-JJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:06:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL8nX-00007A-Bm
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:06:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id a9so16880029wrp.6
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TMYY+oUbqasXkRpsVOksYkBugkZpbpTbPgd076eEaNI=;
	b=kLY6thuqBvNvIicMIaoi1qOHA16c0gajAzhSqA5WKXYiSXdlhRI/YcUHNwCku2VHMv
	vZz17TIkmU0t7mIw23t365C48wLBMtfMXNlIUNFO1i43SQhcAQ53UPnQEeiYsYKO2MOo
	FsQ/MJ7LnPZH8jKnyih28yoz5FOeGxGA7wdGXzh3b74N9jOhlWHtDa/cI4itI0xrr1wn
	F0pRb91Tt25XQTS3Q8PJyUcrUZ7ypn81EJ8lRYoiiwjpIrtHOcZlT190qf26aiYNRCxc
	qxBe7qTKzIOgaiVFZEED9RhmBSursglJpkDOTosYwJMQK6jSfvcD9P6nS6fuS9c8mVwv
	wIaw==
X-Gm-Message-State: APjAAAVPI7UMx/1VmEa+RtiSf2QQIwK26Jr1XHrODwGxIOOyw7nDT6xo
	SO6gFMPkdsz6yXARhqCDNbxB6A==
X-Google-Smtp-Source: APXvYqwQJHCBMzDeaNdBI2JZOcFXIk5DKmVoPpM61AECMVs7Ynav9NBE/LsNSsKVfEqimsr5DcrDzw==
X-Received: by 2002:a5d:4ec2:: with SMTP id s2mr26535966wrv.160.1556553990335; 
	Mon, 29 Apr 2019 09:06:30 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a12sm12008034wrh.46.2019.04.29.09.06.28
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 09:06:29 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-17-thuth@redhat.com>
	<98855a34-ff5a-896f-7959-480b89d62833@redhat.com>
	<b78d5517-5f23-6028-6726-b60f916f22fd@redhat.com>
	<CAFEAcA8xWTwbU6RSBbQkF2j5OfozEq9g3Pq83KyYG_J1CqGM-A@mail.gmail.com>
	<3f8cad24-3eb9-4c05-063e-196e27184f90@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <399a3be9-332e-fe3a-570b-4c1e43cbe2d9@redhat.com>
Date: Mon, 29 Apr 2019 18:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3f8cad24-3eb9-4c05-063e-196e27184f90@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 16/29] hw/arm: Express
 dependencies of the virt machine with Kconfig
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Yang Zhong <yang.zhong@intel.com>, Rob Herring <robh@kernel.org>,
	Qemu-block <qemu-block@nongnu.org>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Andrew Jeffery <andrew@aj.id.au>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429160627.nDzBmizi1tQNmDW1kHuIBilX3XI85wls8zjuNnhLaTo@z>

On 4/29/19 6:02 PM, Thomas Huth wrote:
> On 29/04/2019 17.53, Peter Maydell wrote:
>> On Mon, 29 Apr 2019 at 16:34, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 25/04/2019 17.53, Philippe Mathieu-Daudé wrote:
>>>> Hi Thomas,
>>>>
>>>> On 4/18/19 8:00 PM, Thomas Huth wrote:
>>>>> Dependencies have been determined by looking at hw/arm/virt.c
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  default-configs/arm-softmmu.mak | 11 +----------
>>>>>  hw/arm/Kconfig                  | 19 +++++++++++++++++++
>>>>>  hw/arm/Makefile.objs            |  3 ++-
>>>>>  3 files changed, 22 insertions(+), 11 deletions(-)
>>
>>>> Without -nodefaults I get:
>>>> qemu-system-aarch64: Unsupported NIC model: virtio-net-pci
>>>> This is expected.
>>>
>>> Yes, it should still work with "-nic none" or "-nodefaults".
>>
>> Er, if you need either -nic none or -nodefaults after this
>> patch then this would be a change in behaviour, which seems
>> wrong to me.
> 
> No worry, this only applies to compiling builds where you run "configure
>  --without-default-devices". For normal builds, virtio-net should still
> be included fine. ... at least I hope this is what Philippe was talking
> about ... but for me it's working fine when I run "configure" normally.

Yes, I tested both cases, without --without-default-devices it works as
expected (no behaviour change). With --without-default-devices (this is
a new configure switch) it is probably required to run QEMU with
-nodefaults.

