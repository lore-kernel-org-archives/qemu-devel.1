Received: from eggs.gnu.org ([2001:4830:134:3::10]:34116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKAR9-0002j3-Kr
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKAR7-0001a9-M9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:07:06 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKAR7-0001Wb-FB
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 18:07:05 -0500
Received: by mail-oi1-x244.google.com with SMTP id u130-v6so12281320oie.7
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 15:07:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <30bb371d-4183-dd25-3413-08fd60a9eeea@redhat.com>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<30bb371d-4183-dd25-3413-08fd60a9eeea@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 23:06:44 +0000
Message-ID: <CAFEAcA_2MqRX2j1pabqbfNdrexpCfNS=xJn=TCaPrkpnD2Bvcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2018 at 19:16, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 6/11/18 19:43, Peter Maydell wrote:
>>
>> I had an idea for how to get a rough list of source files
>> containing devices that haven't been QOMified. The theory
>> is that a pre-QOM device generally has an "init" function
>> which allocates memory for the device struct. So looking in
>> hw/ for files which call g_new*() or g_malloc*() should get
>> us all the non-QOM devices (as well as a pile of false
>> positives, of course). The following link is the result of
>> doing that and then eyeballing the results for false positives
>> and throwing those out. It might have missed one or two
>> files or included one or two by mistake. But I think it's
>> pretty close, and it seems to have caught all the obvious
>> ones I knew about. There are 61 files on this list.
>>
>> I am also suspicious about hw/bt/ but don't know enough
>> about that subsystem to say if it could benefit from
>> using QOM objects more.
>>
>
>> hw/arm/exynos4210.c
>
> I already did this one.
>
>> hw/sd/omap_mmc.c
> I will do this one.

I have some out-of-tree stuff that deals with this device
(part of the omap3 patchset tries to do some QOMification,
but it was a bit tangled with adding omap3 features),
so if you could hold off on working on the various omap
devices in this set that might be better, til I see
whether any of the out-of-tree code is usefully salvageable.

thanks
-- PMM
