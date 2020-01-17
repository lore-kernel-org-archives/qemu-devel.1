Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031B8C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAEC20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAEC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVXL-0005QS-RW
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1isVUF-00027y-OG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1isVUD-0003nU-ID
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:32:47 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:13307)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1isVUD-0003e7-7I; Fri, 17 Jan 2020 12:32:45 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D21BB7475F9;
 Fri, 17 Jan 2020 18:32:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A1A7E7475F6; Fri, 17 Jan 2020 18:32:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9F6767456F8;
 Fri, 17 Jan 2020 18:32:32 +0100 (CET)
Date: Fri, 17 Jan 2020 18:32:32 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 66/86] ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
In-Reply-To: <20200117173926.7d52023c@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001171819040.86714@zero.eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-67-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001152149120.24151@zero.eik.bme.hu>
 <20200117114629.5b245c83@redhat.com>
 <d3d50fff-3449-ba3e-12f2-5b74e20a1e4c@redhat.com>
 <20200117173926.7d52023c@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-309490024-1579282352=:86714"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-ppc@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-309490024-1579282352=:86714
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jan 2020, Igor Mammedov wrote:
> On Fri, 17 Jan 2020 16:38:02 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
>> On 1/17/20 11:46 AM, Igor Mammedov wrote:
>>> On Wed, 15 Jan 2020 22:33:46 +0100 (CET)
>>> BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>
>> [...]
>>> v2 basically works the same as original code, except of that
>>> instead of fixing up ram_size, it ask user to fix CLI to
>>> the same value.
>>>
>>>> but I've not yet given up to keep current functionality
>>>> (also for other boards where this series would drop it). If you don'=
t like
>>>> a generic callback then how about letting the board optionally speci=
fy in
>>>> the machine class next to default_ram_size some constraints such as
>>>> min_ram_size, max_ram_size and an array of valid_ram_sizes (like
>>>> ppc460ex_sdram_bank_sizes[]) that the generic code doing the allocat=
ion
>>>> could check and clamp sizes to the nearest valid one emitting a warn=
ing
>>>> and only bail out if constraints are not given. This would cover mos=
t
>>>> cases expect the e500 where it has an alignment without max so
>>>> representing it as a list of valid values is probably not practical =
(could
>>>> also have ram_alignment but then a generic callback may be simpler).=
 Would
>>>> that way work for you?
>>>
>>> I agree that we need to consolidate ram_size checks,
>>> that would allow to clean up boards that practically do
>>> the mostly the same. In the end it would allow to introspect
>>> supported ram_sizes which would be good for upper layers.
>>>
>>> I even started something in that direction but dropped
>>> all of that patches as not directly related to this
>>> series purpose.
>>> Phillipe is also trying to something like this for raspi
>>> board.
>>>
>>> As for clamping, I still think that it's not good idea
>>> to accept invalid value and fix it up.
>>> Users should get what they asked for or get a clear error
>>> (it's double true if user is management software as it
>>> won't read any sort of warnings, well not all human users
>>> would head warnings either as far as QEMU continues to run)
>>>
>>> Anyways, most maintainers agreed to dropping fixups
>>> and generalizing checks or generalizing fix up for convenience
>>> of users frameworks are out of scope of this series.
>>>
>>> Someone can work on these refactorings later on
>>> (assuming someone is enough interested in it)
>>>
>>> PS:
>>> If you insist on fixing ram_size up, it would still be possible
>>> to do so locally within board. One can take all RAM that user
>>> provided and then create clamped memory region alias.
>>> It's rather ugly but will do the job without affecting generic
>>> code. (though I wouldn't volunteer to write up such a hack)
>>
>> I think from the virtualization point of view, you don't want to
>> allocate unused resources. Is that why you say it is "ugly"?
>>
>>  From the emulation point of view, it is easier to stay as close as
>> possible to the hardware, where sometimes resources are wasted to
>> simplify the design (or reduce production delays).
>> If it matches hardware, clamping doesn't look "ugly" to me.
>>
>
> gist of discussion in this case is that:
>
> bamboo HW supports 4 banks of RAM that could be populated by
> 256/128/64/32/16/8Mb DIMMs

I care more about sam460ex but limitations are similar (with different=20
list of supported DIMMs). This comes from how the SoC's memory controller=
=20
stores memory size (that's similar to how SPD data encodes it) so we can'=
t=20
represent different size.

> so -m XXX must be multiple of that, otherwise we are not
> able distribute all -m specified size between supported banks.
>
> Current patch then would error out with
>  "Max 4 banks of 256, 128, 64, 32, 16, 8 MB DIMM/bank supported"
>  "Possible valid RAM size: XXX"
> where XXX is clamped value original code uses to after fixup
>
> Argument was that it's not convenient for users do what they
> would do on real hw (i.e. calculate desired size manually
> based on available banks/DIMMs).

On real hardware one cannot have invalid RAM size because you can only=20
plug DIMMs of above sizes so the problem does not happen. The argument wa=
s=20
more that it worked before and now users may find their previously workin=
g=20
options to error out. Current version of this patch is better as it gives=
=20
valid option so the user who does not know about SoC limitations can just=
=20
use the printed value and doesn't have to calculate valid value.

> I gave an attempt to dumping all possible sizes and it results
> in not practically useful unique ~80 entries list, so that idea
> also goes down the drain.
>
> I agree that it's not convenient, but I think that human user
> can easily adapt to error message and either fix CLI to use
> suggested value (i.e. what they are getting now) or pick desired
> DIMMs number/size and do the math.

This version is acceptable and I can live with it. If every other board i=
s=20
happy with returning error then it's OK to do the same here as long as=20
it's easy for users to fix their command line by using the printed value.

Regards,
BALATON Zoltan
--3866299591-309490024-1579282352=:86714--

