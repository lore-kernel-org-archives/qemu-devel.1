Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48712C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127C420881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbhterWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127C420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41163 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3HN-0003xD-8z
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:01:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hP393-0004yq-KN
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hP392-0001Nu-JM
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:52:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hP392-0001N9-D5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:52:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id o4so7329080wra.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=xHNdFnVAuh6l8PENFLVrR1X5PKoTCZIAYaFqvyp6FNg=;
	b=XbhterWMPdtEUlPW0lxU2Lx58uOa06XCdwuyG3dQ1H4p4GhQ6aot6hrAj4ktCNTiAf
	SugJVpIDJtWDo/ICxc6i6EK5+hg3jKwQSu6FB6WQOm9vw6q2td+trcv1SN5yzPoc1Uas
	6pPw+GuORr2MlZ0F6e8M2v1wvnJQJDIHWGZQCmQwfbIOlg3Ab7Un1RdboB7uUOzEE/1x
	Y09A8gLNkz9jIXYxLDPvLLyZZtfThMpkF7RdTdVvp2+g1IAMLzwC2L7E+1ANJ6BW66c4
	QHqUwivoifUybH+wabULPS8qgTmh2boDlxOcxp8Ks9LQ0dW5H24ItZk02DFnRcZ9bvEP
	kGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=xHNdFnVAuh6l8PENFLVrR1X5PKoTCZIAYaFqvyp6FNg=;
	b=jpaXJ8BGRRxcuA3DVfThEcG1irC2kCS3AzbER7RVsRDXwIoIC+kIDp4EHpDIqyrtDP
	jJcPtFI7gG2/UdyovGhXJQxOdjrCDNNk2CAw6CMuGRq362H5/Rg0KYfcYHw2BJzhlZd8
	ngeta3qauLqZR97KkD5dtOWTq3jI6lKK5KLe63eAW8J9jXHQARw3nuy9SSbNmZn4JF+1
	f58gWsADkKrwGgeTNyE6Rmb9frDyAcootSlBJPFxF8tj3l1rbb8Q/IurrMIHVwn2DBJT
	IGcyQsoZrwKTM6MOtnwGqXpw4qtqBRwLZHGu28Wy/bBjpaH8X8RFwIIIqbwRF139RKBw
	Xwxg==
X-Gm-Message-State: APjAAAVx9x2d8xWKy9Mli+iHYNBkb8TH5FZtdLlT9T9KC71dO3e5BeJU
	TZc494M9viUEDhPWlRh4u6ubqvLNaVo=
X-Google-Smtp-Source: APXvYqyqydfw2YhiIW3Q27CmhnE1czyUm92kcKP8mRSIjaBQekhNSzBI5j7ZSweuM1hXGC9hd2A7Jw==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr6907619wrq.23.1557485570478; 
	Fri, 10 May 2019 03:52:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0d:c0b:ba00:6fce:9bd8:fb12:6a42])
	by smtp.gmail.com with ESMTPSA id
	h11sm2136246wrr.44.2019.05.10.03.52.49
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 03:52:49 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmrndpONH_fVHbktHbBXvXPKESeRfis06TjrNRRfBpJzXLA@mail.gmail.com>
	<b6064b77-5ca4-03e1-80ef-027313096cb2@gmail.com>
	<CABSdmrkW6G23ZGDA7iLucM45vL0HHGsr2F76H0Mf8S0xkhPnsQ@mail.gmail.com>
	<3e619b5c-8fb3-2655-2d92-37598db098d8@gmail.com>
	<20190510085947.y62lttdtrg5cxx6b@sirius.home.kraxel.org>
	<3fb8b79d-9f68-2342-d3ae-3aefa873109b@gmail.com>
	<20190510103900.botgnbbo2ii4jxgo@sirius.home.kraxel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <01de4824-5c19-6b6c-5b75-fa54a883ab4a@gmail.com>
Date: Fri, 10 May 2019 13:52:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190510103900.botgnbbo2ii4jxgo@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 3/3] ramfb enhancement
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
Cc: Hou Qiming <hqm03ster@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/10/19 1:39 PM, Gerd Hoffmann wrote:
> On Fri, May 10, 2019 at 12:20:56PM +0300, Marcel Apfelbaum wrote:
>> Hi Gerd,
>>
>> On 5/10/19 11:59 AM, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>> Got it, thanks. Is a pity ramfb is not a PCI device :), it was worth the
>>>> question anyway.
>>> If you look for a simple pci display device check out bochs-display.
>>> It's simliar to stdvga (so ovmf and bochs-drm.ko can drive it just
>>> fine), but without legacy vga emulation, only a linear framebuffer is
>>> supported.  And code size is a fraction of stdvga ...
>> I actually need the ramfb display in conjunction with kvmgt.
>>
>> I want to be able to save the VM state to disk, which is actually a kind
>> of 'live migration' as far as I understand, but live-migration can't work
>> since
>> we use device assignment  (vfio-pci-nohotplug device).
> vfio live migration is being worked on btw.
>
>> I was hoping to be able to hot-unplug/hot-plug the vfio device,
>> but as the name suggests, can't do so since
>> the ramfb display uses fw-config to pass the configuration to firmware.
> Yes, fw_cfg files can't be hotplugged, that is where this restriction
> comes from.
>
>> How hard/possible is to make ramfb display a PCI device and move the
>> configuration from fw-config to PCI configuration space?
> Well, the whole point of using ramfb is that it is *not* a pci device,
> but something you can attach to other devices as boot display.  Right
> now we have that for vfio only, in theory it can likewise be done for
> virtio (so you can use virtio-ramfb instead of virtio-vga for bios
> display support).  Prototype exists.  Given that OVMF has a full
> virtio-gpu driver there isn't much need for that though ...
>
> Piggyback on the pci config space of the device you are attaching ramfb
> to isn't going to work very well for unknown devices (i.e. vfio case).
> For virtio it would have worked without too much trouble probably, using
> a vendor capability to grab some register space.
>
> For a separate pci device you can just use bochs-display.  Maybe add
> some logic for the automagic display switching (i.e. if vfio has a valid
> framebuffer use that and bochs-display otherwise).

Thanks for the explanation and the pointers!
I'll try to come up with something.

Thanks,
Marcel

> cheers,
>    Gerd
>


