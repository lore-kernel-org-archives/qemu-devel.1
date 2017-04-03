Received: from eggs.gnu.org ([2001:4830:134:3::10]:60771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cuy95-00079g-0l
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cuy91-0005kB-QL
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:19:31 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36263
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cuy91-0005j2-IS
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:19:27 -0400
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<4ccee8ca-8045-784e-5074-3007d8667238@ilande.co.uk>
	<1491209040.17505.18.camel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1d264820-edb6-0a39-e87c-a846810df648@ilande.co.uk>
Date: Mon, 3 Apr 2017 10:18:57 +0100
MIME-Version: 1.0
In-Reply-To: <1491209040.17505.18.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 03/04/17 09:44, Gerd Hoffmann wrote:

>   Hi,
> 
>> I've spent a bit of time over the weekend attempting to convert the
>> SPARC CG3/TCX framebuffers over to use your new code and pushed the
>> result to my github branch here:
>> https://github.com/mcayland/qemu/commits/vga-fixes-sparc.
> 
> work/vga-fixes branch updated & rebased to latest master, with your
> patches added.

I've just rebased on your branch with some extra fixes which should be
squashed into the earlier commits and pushed to github again - see the
commit messages for more information.

>> 2) Redraw issues with CG3/TCX after conversion
>>
>> Despite the conversion from your patches looking reasonably
>> straightforward, I still see problems with areas of the screen not
>> updating after conversion. I can easily reproduce these locally as follows:
>>
>> ./qemu-system-sparc -vga cg3 -prom-env 'auto-boot?=false'
>> ./qemu-system-sparc -vga tcx -g 1024x768x8 -prom-env 'auto-boot?=false'
>> ./qemu-system-sparc -vga tcx -g 1024x768x24 -prom-env 'auto-boot?=false'
> 
> Hmm, I have a blank screen only (yellow with cg3, black with tcx).
> No openfirmware prompt showing up ...

Yeah it's slightly baffling. The easiest one to look at is cg3 since
it's a simple 8-bit palette dumb framebuffer with 256 colors, i.e. the
differences between 8d3af4a~1 and 8d3af4a ("cg3: make display updates
thread safe") in your updated branch. If nothing seems wrong with the
conversion (once my latest fixes have been squashed in) then I presume
something odd is happening in the dirty bitmap code...


ATB,

Mark.
