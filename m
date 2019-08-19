Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DC4C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A54F2086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A54F2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45377 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzbOo-0004gQ-Gh
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 02:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1hzbNl-0003r6-1Z
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hzbNk-0007pz-2i
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:43:08 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:46168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hzbNj-0007p4-U1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:43:08 -0400
Received: from player737.ha.ovh.net (unknown [10.108.42.168])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 44894116F64
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:43:05 +0200 (CEST)
Received: from kaod.org (lfbn-ren-1-123-36.w83-205.abo.wanadoo.fr
 [83.205.208.36]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id D6CBD9083C3D;
 Mon, 19 Aug 2019 06:42:58 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org
References: <1565814456-1264-1-git-send-email-eajames@linux.ibm.com>
 <ca560d31-25ca-5d48-a16a-4fdf74f4779b@kaod.org>
 <24e21dd0-55b8-a5df-57da-2d68bee204a0@linux.ibm.com>
 <cb2d52b2-65ef-41d6-0e3f-6aefb78f4d34@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e93c7ced-ad33-fbca-427b-8996bb4860fe@kaod.org>
Date: Mon, 19 Aug 2019 08:42:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cb2d52b2-65ef-41d6-0e3f-6aefb78f4d34@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4969722188967086865
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefkedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.180
Subject: Re: [Qemu-devel] [RFC v2] hw/sd/aspeed_sdhci: New device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/08/2019 22:21, Eddie James wrote:
>=20
> On 8/15/19 3:13 PM, Eddie James wrote:
>>
>> On 8/15/19 3:05 AM, C=C3=A9dric Le Goater wrote:
>>> Hello Eddie,
>>>
>>> On 14/08/2019 22:27, Eddie James wrote:
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[0].capareg =
=3D (uint64_t)(uint32_t)val;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_148:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[0].maxcurr =
=3D (uint64_t)(uint32_t)val;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_240:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[1].capareg =
=3D (uint64_t)(uint32_t)val;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 case ASPEED_SDHCI_SDIO_248:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdhci->slots[1].maxcurr =
=3D (uint64_t)(uint32_t)val;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> I think these regs are readonly.
>>
>>
>> Well the actual regs at slot + 0x40/0x48 are indeed, but not the Aspee=
d-specific ones that mirror there. I think the idea is that Aspeed-specif=
ic code can set it's capabilities differently if desired. This may preven=
t the use of alias regions here.
>=20
>=20
> Actually I could be wrong after reading the specs again. It's a little =
confusing. I'm fine with making it read-only anyway, I doubt there will b=
e any code that needs to write it.

Let's ask Aspeed what was the intent. It is a bit weird indeed.=20

>=20
>=20
>>
>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (addr < ASPEED_SDHCI_=
REG_SIZE) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sdhci->regs[TO_REG(addr)] =3D (uint32_t)val;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +}
>>>> +
>>>> +static const MemoryRegionOps aspeed_sdhci_ops =3D {
>>>> +=C2=A0=C2=A0=C2=A0 .read =3D aspeed_sdhci_read,
>>>> +=C2=A0=C2=A0=C2=A0 .write =3D aspeed_sdhci_write,
>>>> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,
>>>> +=C2=A0=C2=A0=C2=A0 .valid.min_access_size =3D 4,=20


