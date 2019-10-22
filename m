Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FD521872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FD521872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpDU-00078N-VF
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMp3j-00065h-P1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMp3i-0006oo-Ca
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:58:27 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:49243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMp3i-0006nj-5l
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:58:26 -0400
Received: from player793.ha.ovh.net (unknown [10.108.35.74])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 537DE22C1A6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:58:23 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 8C0CEB391131;
 Tue, 22 Oct 2019 07:58:11 +0000 (UTC)
Subject: Re: qemu/powernv: coreboot support?
To: "Marty E. Plummer" <hanetzer@startmail.com>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
 <20191021053439.GA6439@umbus.fritz.box>
 <f196a1a6-fcbf-f409-e7e7-95b42135c0be@kaod.org>
 <20191022003209.6ssq2ojiv57ixeyd@proprietary-killer>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cfc2186f-52e2-53e8-bc3a-9511428542d0@kaod.org>
Date: Tue, 22 Oct 2019 09:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022003209.6ssq2ojiv57ixeyd@proprietary-killer>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 13158955164694776787
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeeigdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.162
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/10/2019 02:32, Marty E. Plummer wrote:
> On Mon, Oct 21, 2019 at 02:46:59PM +0200, C=C3=A9dric Le Goater wrote:
>> On 21/10/2019 07:34, David Gibson wrote:
>>> On Sun, Oct 20, 2019 at 08:51:47AM +0200, C=C3=A9dric Le Goater wrote=
:
>>>> On 20/10/2019 08:28, David Gibson wrote:
>>>>>
>>>>> Ok.  Note that the qemu emulated machine doesn't model the hardware
>>>>> right down to the level of hostboot.  That's wy we're just loading
>>>>> skiboot and jumping straight into it usually.  I guess clg's stuff =
to
>>>>> load pnor images gets us a little closer to the hardware behaviour,
>>>>> but I think it's still only a rough approximation.
>>>>
> On that note, is qemu-ppc64 currently capable of running LE firmware? M=
y
> coreboot port has currently reached a hitch in that part of the firmwar=
e
> headers mapping stuff out is saved in LE mode while the cpu (real or em=
u)
> is running in BE mode (FMAP headers are saved LE but CBFS headers are
> saved BE)
>>>> It's really tied to the OpenPOWER firmwares using the HIOMAP protoco=
l
>>>> to discuss with the BMC and load the flash. We could loosen how QEMU=
=20
>>>> interprets the MTD device and use a property to inform QEMU that thi=
s
>>>> is an OpenPOWER  PNOR file and that skiboot and can be loaded from i=
t.
>>>> Something to discuss.
>>>
>>> Right.  I'm guessing one significant issue here is that to fully mode=
l
>>> the BMC, with *its* firmware and comms channels with the main host
>>> would be quite a lot of work, hence cheating a bit to bypass that.
>>
>> In fact, we are not cheating that much. We use the IPMI BT interface o=
f=20
>> QEMU to handle the HIOMAP communication with the BMC and this model is=
=20
>> quite precise.=20
>>
>> The mapping of the PNOR is simply mapped on the LPC FW address space.=20
>> The underlying access are simplified because we don't have a LPC model
>> but we could generate all the SPI transaction using the Aspeed models.=
=20
>> I had experiments in that sense for P8.=20
>>
> Honestly getting the coreboot.rom into the lpc fw addr space in the sam=
e
> way you do pnor images would be a useful sim, as that's more or less ho=
w
> its going to be done on existing hardware.

That is covered by patch 'ppc/pnv: Add HIOMAP commands' in the series
I sent.

C.=20

