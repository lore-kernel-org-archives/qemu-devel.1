Received: from eggs.gnu.org ([2001:4830:134:3::10]:52585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1djnIX-0006jU-Hd
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1djnIT-0006UO-HE
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:03:21 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:38639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1djnIT-0006Rq-B7
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 10:03:17 -0400
Received: by mail-wr0-x22a.google.com with SMTP id p8so35958319wrf.5
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 07:03:15 -0700 (PDT)
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
	<be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
	<1503316706.26016.11.camel@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1503316706.26016.11.camel@redhat.com>
Date: Mon, 21 Aug 2017 15:03:13 +0100
Message-ID: <874lt1587y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> On Mon, 2017-08-07 at 18:51 +0200, Laszlo Ersek wrote:
>> On 08/07/17 16:40, Peter Maydell wrote:
>> > On 7 August 2017 at 15:31, Igor Mammedov <imammedo@redhat.com>
>> > wrote:
>> > > As I recall there were issues with FAT driver licensing in edk2,
>> > > but I've heard there were some changes in that regard.
>> > >
>> > > Is there any other reasons why we are not putting subj.
>> > > in QEMU tree like we do with SeaBIOS and other roms?
>> >
>> > I suspect the primary answer is "nobody who's willing to
>> > maintain, test and update the resulting binary blobs has
>> > stepped forward to say they want to do so" :-)
>> >
>> > (I think that shipping them in the QEMU tree would be
>> > nice but is principally a convenience for our direct
>> > users, since distros are going to want to build their
>> > own ROM blobs from source anyway.)
>>
>> I agree that OVMF and ArmVirtQemu firmware binaries (and matching
>> varstore templates, likely compressed) should be bundled with QEMU.
>> There are no license-related reasons left that would prevent this.
>>
>> Please let us discuss this when Gerd returns from vacation. (CC'ing
>> Gerd.)
>
> slighly oldish wip branch:
> https://www.kraxel.org/cgit/qemu/log/?h=work/edk2
>
> Related question (as the edk2 blobs are pretty big):  Do we want commit
> this to the qemu repo directly?   Or should we create a qemu-firmware
> repo for the precompiled blobs and hook it up as submodule?

How big? Things like github tend to get picky with blobs over 50Mb and
git isn't really set-up for large binary bits hence things like git-lfs.
Unfortunately there seems to be multiple solutions to the blobs in git
problem.

We should also take some care to reproducibility so they can be updated
by someone other than the original author.

>
> cheers,
>   Gerd


--
Alex Bennée
