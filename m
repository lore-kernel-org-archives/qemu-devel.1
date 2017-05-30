Received: from eggs.gnu.org ([2001:4830:134:3::10]:58498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dFmm2-0002uf-2P
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dFmly-0002N3-4B
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:25:46 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:34034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1dFmlx-0002My-UF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:25:42 -0400
Received: by mail-oi0-x22f.google.com with SMTP id b204so124196078oii.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 12:25:41 -0700 (PDT)
References: <619adaac-955d-c6f6-f137-ff627b7cbfb0@landley.net>
	<CAFEAcA9-Jjnn2mCE56YxiQ4S6+kAb_EpisXtkv9G=Gf-nje+5Q@mail.gmail.com>
From: Rob Landley <rob@landley.net>
Message-ID: <189f5322-2aab-7f2c-3f5a-029f811edc0c@landley.net>
Date: Tue, 30 May 2017 14:25:39 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9-Jjnn2mCE56YxiQ4S6+kAb_EpisXtkv9G=Gf-nje+5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How do you -sd squashfs.img without truncating?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05/30/2017 07:17 AM, Peter Maydell wrote:
> On 8 May 2017 at 06:08, Rob Landley <rob@landley.net> wrote:
>> As far as I can tell "qemu-system-arm -M vexpress-a9" only implements sd
>> card, not any conventional hard drive, and it uses an sdcard block size
>> of 262144 bytes rounded down. This means when I create a squashfs image
>> and feed it in through the sd card, it truncates it.
>>
>> Wouldn't -sd rounding _up_ be more useful?
> 
> This vaguely rings a bell but I forget exactly. I think the
> intention is that you're supposed to pass it a file of
> exactly the right length, not one that's too short. If we
> rounded up, then it would create the awkward question of
> "what happens when the guest writes into the bit of the
> sd card image that doesn't actually exist in the image file".
> 
> I'm not strongly attached to the current behaviour (especially
> if the behaviour for sd card images doesn't match that for
> hd images and other kinds of disk), but I think that may have
> been the "this is more complicated than it appears on the surface"
> reason that nobody's got round to trying to change the behaviour.
> It's been years though, so I might just be completely misremembering.

I worked around it by switching to the -M virt machine. (The project is
https://github.com/landley/mkroot if you're curious.)

Thanks,

Rob
