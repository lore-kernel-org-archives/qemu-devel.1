Received: from eggs.gnu.org ([2001:4830:134:3::10]:35828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoUgq-0006ez-EK
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoUgp-0005yO-CM
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:44:08 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoUgp-0005yA-6x
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:44:07 -0500
Received: by mail-oi0-x243.google.com with SMTP id u6so1123059oiv.9
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 05:44:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220204450.GA27101@flamenco>
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
	<20180220204450.GA27101@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Feb 2018 13:43:46 +0000
Message-ID: <CAFEAcA-p_og1Dc3DOTbAYofqAUEn0rnuuizoU8xtWrtOtzpp-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Firmware blob and git submodule for
 Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Francois Revol <revol@free.fr>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On 20 February 2018 at 20:44, Emilio G. Cota <cota@braap.org> wrote:
> On Tue, Feb 20, 2018 at 18:31:17 +0000, Peter Maydell wrote:
>> On 20 February 2018 at 18:10, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> > I've created a git repo for the Sam460ex u-boot sources and this adds
>> > that as a submodule and a separate patch to add the binary built from
>> > these sources. Feel free to keep this as two patches, squash them into
>> > one patch or take the git repo and commit the content under the QEMU
>> > repo and use that as a submodule as you see fit (or let me know if any
>> > changes are needed for these patches).
>> >
>> > BALATON Zoltan (2):
>> >   roms: Added git submodule for u-boot-sam460 (firmware for sam460ex)
>> >   pc-bios: Added u-boot-sam460 firmware binary
>>
>> We already have a submodule for u-boot. Is it not possible to
>> build this bios blob from those upstream u-boot sources?
>
> This is discussed in the following thread:
>   Re: [Qemu-ppc] [PATCH v3 2/2] ppc: Add aCube Sam460ex board
>   http://lists.gnu.org/archive/html/qemu-ppc/2018-02/msg00268.html

If upstream u-boot have abandoned the board support I'm not very
enthusiastic about our taking it on :-(

thanks
-- PMM
