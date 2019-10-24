Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920D4CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695D820856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695D820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gaisler.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNXfO-0002FJ-Ip
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 03:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiri@gaisler.se>) id 1iNXbG-00051j-2q
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiri@gaisler.se>) id 1iNXbD-0001zI-Fo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:32:00 -0400
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:34384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiri@gaisler.se>) id 1iNXb8-0001tS-Ib
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:31:59 -0400
X-Halon-ID: 430d3c75-f630-11e9-bdc3-005056917a89
Authorized-sender: jiri@gaisler.se
Received: from [192.168.9.20] (unknown [92.33.136.219])
 by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPSA
 id 430d3c75-f630-11e9-bdc3-005056917a89;
 Thu, 24 Oct 2019 09:31:16 +0200 (CEST)
Subject: Re: LEON3 networking
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joshua Shaffer <joshua.shaffer@astrobotic.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>
References: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
 <6bb8abb2-68f0-db85-1557-6e04839b5ea2@redhat.com>
 <32c38984-e745-de6c-792e-09910b68cedd@adacore.com>
 <CAPJW7GLOTyjdMozrb+TSnqpEyoiFh2sxZjYkLXx2pz2_J_dPgA@mail.gmail.com>
 <a6783ce6-eea2-214f-7dbd-7224e830db0b@gaisler.se>
 <2ea63643-5cb2-017e-8889-bb8c77fd75cf@gaisler.se>
 <6d0ffeda-68c4-3c0e-39bb-e00d544e1b8e@redhat.com>
From: Jiri Gaisler <jiri@gaisler.se>
Openpgp: preference=signencrypt
Autocrypt: addr=jiri@gaisler.se; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9ce71f42-741c-000a-1b44-d473575f7458@gaisler.se>
Date: Thu, 24 Oct 2019 09:31:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6d0ffeda-68c4-3c0e-39bb-e00d544e1b8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 195.74.38.229
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/24/19 12:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Jiri,
>
> On 10/23/19 9:55 PM, Jiri Gaisler wrote:
>> BTW, here is a patch that you might want to apply to qemu if you inten=
d
>> to run RTEMS on leon3. The plug&play area must support byte accesses,
>> which is used by the RTEMS grlib scanning functions...
>
> Do you mean this one?
>
> http://gaisler.org/qemu/qemu-4.1.0-leon3.patch


Yes.

>
> -- >8 --
> --- a/hw/misc/grlib_ahb_apb_pnp.c
> +++ b/hw/misc/grlib_ahb_apb_pnp.c
> @@ -228,6 +228,9 @@ static uint64_t grlib_apb_pnp_read(void *opaque, hw=
addr offset, unsigned size)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 APBPnp *apb_pnp =3D GRLIB_APB_PNP(opaque);
>
> +=C2=A0=C2=A0=C2=A0 if (size !=3D 4)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return apb_pnp->regs[offset=
 >> 2] >> ((~offset & 3) * 8);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 return apb_pnp->regs[offset >> 2];
> =C2=A0}
>
> ---
>
> But then this is incorrect for 16-bit accesses.

Correct, it only fixes 8-bit accesses so that RTEMS can boot.


>
> The proper patch might be:
>
> -- >8 --
> @@ -234,6 +234,13 @@ static uint64_t grlib_apb_pnp_read(void *opaque, h=
waddr offset, unsigned size)
> =C2=A0static const MemoryRegionOps grlib_apb_pnp_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .read=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D =
grlib_apb_pnp_read,
> =C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_BIG_ENDIAN,
> +=C2=A0=C2=A0=C2=A0 .valid =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .min_access_size =3D 1,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 .impl =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .min_access_size =3D 4,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_access_size =3D 4,
> +=C2=A0=C2=A0=C2=A0 },
> =C2=A0};
>

I don't know enough about qemu internals to have an opinion on this, but =
it certainly looks much more elegant than my simple fix .. :-)

Jiri.

> ---
>
> (Unrelated note, this device model lacks the MemoryRegionOps::write han=
dler).
>
>> Jiri.
>>
>> On 10/23/19 8:37 PM, Jiri Gaisler wrote:
>>> Leon3 uses the GRETH ethernet IP core for networking. You would need =
to
>>> write a qemu emulation model of it to get networking support. The GRE=
TH
>>> is fairly well described in the GRLIB IP manual, so it should not be
>>> impossible. The core is also available in open-source (VHDL) if you n=
eed
>>> to look up some finer details ... :-)
>>>
>>> Jiri.
>>>
>>> On 10/23/19 6:59 PM, Joshua Shaffer wrote:
>>>> Does anyone know what needs implemented to get networking supported?=

>>>>
>>>> Joshua
>>>>
>>>> On Wed, Oct 16, 2019 at 6:34 AM Fabien Chouteau <chouteau@adacore.co=
m> wrote:
>>>>> Hello people,
>>>>>
>>>>> On 15/10/2019 18:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> Hi Joshua,
>>>>>>
>>>>>> On 10/15/19 3:17 PM, Joshua Shaffer wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> I've been using the LEON3 port of qemu, and am wondering if anyon=
e has touched the networking setup for such since the thread here: https:=
//lists.rtems.org/pipermail/users/2014-September/028224.html
>>>>>> Thanks for sharing this!
>>>>>>
>>>>>> Good news, Jiri keeps rebasing his patch with the latest stable ve=
rsion.
>>>>>> Bad news, he didn't not signed his work with a "Signed-off-by" tag=
 so we can not take this as it into the mainstream repository, see https:=
//wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signe=
d-off-by:_line
>>>>>>
>>>>> The Gaisler patches have been rewrote by my colleague Frederic (in =
CC) and they are now in mainstream.
>>>>> (see https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03869=
=2Ehtml)
>>>>>
>>>>> But none of them are implementing network support, and I never hear=
d of someone working on network for leon3.
>>>>>
>>>>> Regards,
>>>>>
>


