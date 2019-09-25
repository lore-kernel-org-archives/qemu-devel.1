Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA76C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4875214D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4875214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5J2-0001lH-Fe
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD5H1-0000jD-IM
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD5H0-0002Q9-0q
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD5Gz-0002OY-OP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:15:53 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94FF62026F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:15:51 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so1944589wmo.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mz/uTOuIgKfe8DOWM5fk18hSi3MAKOgNRieLhwQuus0=;
 b=EPTJxRMAvqryirtICgh+twr6X/VvHKn9ALWHkl2KRMmmQ1CUqsLyCixGXZt29434pQ
 pdK0L95WJXWdhV30BzolQamLuh8lgpkaFyq3NSj6ewL1LvLEMkb64qBLfzZgmF/Woe/n
 ORVHrFRgwwtbEEISvX6jaI1s056mtPCh/EsPgnnCveYxl+bkICUMcPEJ5EtL1/yfe5Ja
 i63xD7mFTHL8w6ZPHtiIwRZ9PG2n+5fsvwQIvFjRvIK056EnMvKeBtM3tQknixQM6tMT
 4+DTWtiwMP0FBwu1zQXjdWx5+oCbUEbJu5j3P7iWIMlx3OxQUe8nLjbCJcU3C+AYrVhD
 VRLA==
X-Gm-Message-State: APjAAAVWTXws6/GaV4o+srjZyzIgFuKoOYno5iVrH7F6WcdnW4CW4Aoq
 s4941HnNnTo9sJrgxQw4pnlTHaZw7CQmUC87spdn8e/JvDlIC+gX2AqQz68DWF2fPuXvI8jtGhb
 hDzSMt8OrvqbJXB4=
X-Received: by 2002:a1c:2546:: with SMTP id l67mr7333675wml.10.1569410150335; 
 Wed, 25 Sep 2019 04:15:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1P1JGXoiYjORMP0BrUwaKNAH+aBh02rYeI8FHulHMY+ZAPwCtNpQmYEM3f4Uf+jNfGfoUiA==
X-Received: by 2002:a1c:2546:: with SMTP id l67mr7333652wml.10.1569410150130; 
 Wed, 25 Sep 2019 04:15:50 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id u83sm6917752wme.0.2019.09.25.04.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 04:15:49 -0700 (PDT)
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: Alistair Francis <alistair23@gmail.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
 <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
 <16bab4bf-b91e-ef0c-2d22-53538f74cfc4@redhat.com>
 <CAKmqyKNitR4YCLh1y8YThfVZqZj603pat3C=i=86Wx8=SWV3Wg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6719a00c-2527-7a21-b311-6e4966195110@redhat.com>
Date: Wed, 25 Sep 2019 13:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNitR4YCLh1y8YThfVZqZj603pat3C=i=86Wx8=SWV3Wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 2:55 AM, Alistair Francis wrote:
> On Tue, Sep 24, 2019 at 2:32 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> On 9/23/19 11:46 PM, Peter Maydell wrote:
>>> On Fri, 20 Sep 2019 at 23:23, Alistair Francis <alistair23@gmail.com>=
 wrote:
>>>> On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>>>>> I don't think we should mirror what is used on ARM virt board to
>>>>> create 2 flash for sifive_u. For ARM virt, there are 2 flashes beca=
use
>>>>> they need distinguish secure and non-secure. For sifive_u, only one=
 is
>>>>> enough.
>>>>
>>>> I went back and forward about 1 or 2. Two seems more usable as maybe
>>>> someone wants to include two pflash files? The Xilinx machine also h=
as
>>>> two so I'm kind of used to 2, but I'm not really fussed.
>>
>> The Xilinx machine has 2 because it matches the hardware.
>>
>>> One of the reasons for having 2 on the Arm board (we do this
>>> even if we're not supporting secure vs non-secure) is that
>>> then you can use one for a fixed read-only BIOS image (backed
>>> by a file on the host filesystem shared between all VMs), and
>>> one backed by a read-write per-VM file providing permanent
>>> storage for BIOS environment variables. Notably UEFI likes to
>>> work this way, but the idea applies in theory to other
>>> boot loader or BIOSes I guess.
>>
>> IIRC Laszlo's explanation, the only reason it is that way is because t=
he
>> pflash_cfi01 model still doesn't implement sector locking. At the OVMF
>> emerged from EDK2, to have a safe ROM vs DATA storage it was decided t=
o
>> use 2 different flashes.
>> When I understood when this config layout started, I suggested Laszlo =
to
>> use a real ROM to store the OVMF CODE since it is pointless to do
>> firmware upgrade in virtualized environment, but he said it was too la=
te
>> to change the design.
>>
>> If you don't plan to run UEFI "Capsule Update" on your Virt board, I
>> suggest using memory_region_init_rom() with your firmware CODE, and a
>> parallel/SPI flash for the data VARStore.
>=20
> We might run that one day, who knows :)

You certainly want to run EDK2, I'm following RISCV progress on the list.

What doesn't make sense on a virtualized platform is the "Capsule
Update" feature IMO. Where it makes sense is on the SiFive E/U boards
models.

>>> I would suggest also checking with Markus that your code
>>> for instantiating the flash devices follows the current
>>> recommendations so the backing storage can be configured
>>> via -blockdev. (This is a fairly recent change from June or
>>> so; current-in-master virt and sbsa boards provide an example
>>> of doing the right thing, I think.)
>>>
>>> thanks
>>> -- PMM
>>>

