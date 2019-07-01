Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCABC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15BE2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15BE2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxVJ-00035V-KN
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhwhf-0007je-QT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhwhe-0001SP-Fi
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:50:43 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:58268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhwhe-0001OZ-76
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:50:42 -0400
Received: from player693.ha.ovh.net (unknown [10.109.159.136])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id D3F276F2FC
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 15:50:34 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id 405EC769EFB6;
 Mon,  1 Jul 2019 13:50:29 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190618165311.27066-1-clg@kaod.org>
 <20190618165311.27066-16-clg@kaod.org>
 <CAFEAcA-J+bS2-EtX6pTFYJ1XMaNLx0roYEoQMxV_=-mwMSPDgg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6a826ad0-1830-a865-d267-80529ad27a84@kaod.org>
Date: Mon, 1 Jul 2019 15:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-J+bS2-EtX6pTFYJ1XMaNLx0roYEoQMxV_=-mwMSPDgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1128714660789586859
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeigdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.150
Subject: Re: [Qemu-devel] [PATCH v2 15/21] aspeed/smc: add support for DMAs
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/2019 15:06, Peter Maydell wrote:
> On Tue, 18 Jun 2019 at 17:55, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>>
>> The FMC controller on the Aspeed SoCs support DMA to access the flash
>> modules. It can operate in a normal mode, to copy to or from the flash
>> module mapping window, or in a checksum calculation mode, to evaluate
>> the best clock settings for reads.
>>
>> The model introduces two custom address spaces for DMAs: one for the
>> AHB window of the FMC flash devices and one for the DRAM. The latter
>> is populated using a "dram" link set from the machine with the RAM
>> container region.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Acked-by: Joel Stanley <joel@jms.id.au>
>> +/*
>> + * Accumulate the result of the reads to provide a checksum that will
>> + * be used to validate the read timing settings.
>> + */
>> +static void aspeed_smc_dma_checksum(AspeedSMCState *s)
>> +{
>> +    MemTxResult result;
>> +    uint32_t data;
>> +
>> +    if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: invalid direction for DMA checksum\n",  __=
func__);
>> +        return;
>> +    }
>> +
>> +    while (s->regs[R_DMA_LEN]) {
>> +        result =3D address_space_read(&s->flash_as, s->regs[R_DMA_FLA=
SH_ADDR],
>> +                                    MEMTXATTRS_UNSPECIFIED,
>> +                                    (uint8_t *)&data, 4);
>=20
> This does a byte-by-byte read into a local uint32_t...
>=20
>> +        if (result !=3D MEMTX_OK) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash read failed @%0=
8x\n",
>> +                          __func__, s->regs[R_DMA_FLASH_ADDR]);
>> +            return;
>> +        }
>> +
>> +        /*
>> +         * When the DMA is on-going, the DMA registers are updated
>> +         * with the current working addresses and length.
>> +         */
>> +        s->regs[R_DMA_CHECKSUM] +=3D data;
>=20
> ...which we then use as a (host-endian) 32-bit value.
>=20
> This will behave differently on big endian and little endian hosts.
> If the h/w behaviour is to to load a 32-bit data type you probably
> want address_space_ldl_le() (or _be() if it's doing a big-endian load).
>=20
>> +        s->regs[R_DMA_FLASH_ADDR] +=3D 4;
>> +        s->regs[R_DMA_LEN] -=3D 4;
>> +    }
>> +}
>> +
>> +static void aspeed_smc_dma_rw(AspeedSMCState *s)
>> +{
>> +    MemTxResult result;
>> +    uint32_t data;
>> +
>> +    while (s->regs[R_DMA_LEN]) {
>> +        if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
>> +            result =3D address_space_read(&s->dram_as, s->regs[R_DMA_=
DRAM_ADDR],
>> +                                        MEMTXATTRS_UNSPECIFIED,
>> +                                        (uint8_t *)&data, 4);
>> +            if (result !=3D MEMTX_OK) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM read failed =
@%08x\n",
>> +                              __func__, s->regs[R_DMA_DRAM_ADDR]);
>> +                return;
>> +            }
>> +
>> +            result =3D address_space_write(&s->flash_as,
>> +                                         s->regs[R_DMA_FLASH_ADDR],
>> +                                         MEMTXATTRS_UNSPECIFIED,
>> +                                         (uint8_t *)&data, 4);
>> +            if (result !=3D MEMTX_OK) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash write faile=
d @%08x\n",
>> +                              __func__, s->regs[R_DMA_FLASH_ADDR]);
>> +                return;
>> +            }
>> +        } else {
>> +            result =3D address_space_read(&s->flash_as, s->regs[R_DMA=
_FLASH_ADDR],
>> +                                        MEMTXATTRS_UNSPECIFIED,
>> +                                        (uint8_t *)&data, 4);
>> +            if (result !=3D MEMTX_OK) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Flash read failed=
 @%08x\n",
>> +                              __func__, s->regs[R_DMA_FLASH_ADDR]);
>> +                return;
>> +            }
>> +
>> +            result =3D address_space_write(&s->dram_as, s->regs[R_DMA=
_DRAM_ADDR],
>> +                                         MEMTXATTRS_UNSPECIFIED,
>> +                                         (uint8_t *)&data, 4);
>> +            if (result !=3D MEMTX_OK) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: DRAM write failed=
 @%08x\n",
>> +                              __func__, s->regs[R_DMA_DRAM_ADDR]);
>> +                return;
>> +            }
>> +        }
>=20
> Since the code here doesn't do anything with the data the
> address_space_read/write here aren't wrong, but you might
> prefer to use the ldl and stl functions to avoid the casts
> to uint8_t* and need to specify the length.

yes. I will check with the HW guys to know precisely how the values are
read and accumulated.

Thanks,

C.=20

