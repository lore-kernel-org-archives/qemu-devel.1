Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E939BC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA012146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 17:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA012146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCoP9-0001IA-V0
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 13:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iCoN0-00086S-TV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iCoMy-0005D8-76
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 13:12:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1iCoMx-0005CW-SV; Tue, 24 Sep 2019 13:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12DDA81F31;
 Tue, 24 Sep 2019 17:12:55 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-118.rdu2.redhat.com
 [10.10.120.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1EA060852;
 Tue, 24 Sep 2019 17:12:50 +0000 (UTC)
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
 <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
 <16bab4bf-b91e-ef0c-2d22-53538f74cfc4@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <102dcf49-2bce-757d-be28-3594b5d280cc@redhat.com>
Date: Tue, 24 Sep 2019 19:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <16bab4bf-b91e-ef0c-2d22-53538f74cfc4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 24 Sep 2019 17:12:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/24/19 11:32, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/23/19 11:46 PM, Peter Maydell wrote:
>> On Fri, 20 Sep 2019 at 23:23, Alistair Francis <alistair23@gmail.com> =
wrote:
>>> On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>> I don't think we should mirror what is used on ARM virt board to
>>>> create 2 flash for sifive_u. For ARM virt, there are 2 flashes becau=
se
>>>> they need distinguish secure and non-secure. For sifive_u, only one =
is
>>>> enough.
>>>
>>> I went back and forward about 1 or 2. Two seems more usable as maybe
>>> someone wants to include two pflash files? The Xilinx machine also ha=
s
>>> two so I'm kind of used to 2, but I'm not really fussed.
>=20
> The Xilinx machine has 2 because it matches the hardware.
>=20
>> One of the reasons for having 2 on the Arm board (we do this
>> even if we're not supporting secure vs non-secure) is that
>> then you can use one for a fixed read-only BIOS image (backed
>> by a file on the host filesystem shared between all VMs), and
>> one backed by a read-write per-VM file providing permanent
>> storage for BIOS environment variables. Notably UEFI likes to
>> work this way, but the idea applies in theory to other
>> boot loader or BIOSes I guess.
>=20
> IIRC Laszlo's explanation, the only reason it is that way is because th=
e
> pflash_cfi01 model still doesn't implement sector locking. At the OVMF
> emerged from EDK2, to have a safe ROM vs DATA storage it was decided to
> use 2 different flashes.
> When I understood when this config layout started, I suggested Laszlo t=
o
> use a real ROM to store the OVMF CODE since it is pointless to do
> firmware upgrade in virtualized environment, but he said it was too lat=
e
> to change the design.

Right, at that point I couldn't see how "-bios" *plus* "-pflash" could
have worked. In chronological order (for OVMF anyway), there was -bios,
then -pflash (R/W), then (with some QEMU changes) two -pflash flags (R/O
+ R/W, which OVMF wouldn't tell apart from the single R/W -pflash).

Thanks
Laszlo

>=20
> If you don't plan to run UEFI "Capsule Update" on your Virt board, I
> suggest using memory_region_init_rom() with your firmware CODE, and a
> parallel/SPI flash for the data VARStore.
>=20
>> I would suggest also checking with Markus that your code
>> for instantiating the flash devices follows the current
>> recommendations so the backing storage can be configured
>> via -blockdev. (This is a fairly recent change from June or
>> so; current-in-master virt and sbsa boards provide an example
>> of doing the right thing, I think.)
>>
>> thanks
>> -- PMM
>>


