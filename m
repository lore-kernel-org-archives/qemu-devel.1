Received: from eggs.gnu.org ([2001:4830:134:3::10]:60834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYwmk-0000AS-KT
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eYwmj-00032z-KC
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:29:58 -0500
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA8NbL7ROZs99hWhpAF2Rdi2qEiWLNo3hr_9W7gmgXyw4A@mail.gmail.com>
	<6d20557d-5722-706f-ca4f-489ab85358c0@redhat.com>
	<CAFEAcA-Nn4VmSnxT7Of8Nh+p5QgF9cMzkqZ-VBCC=2zRgk-Xdw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e40cc107-2fe9-d8a5-b4fd-385c0d22c564@redhat.com>
Date: Tue, 9 Jan 2018 17:29:13 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Nn4VmSnxT7Of8Nh+p5QgF9cMzkqZ-VBCC=2zRgk-Xdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] GICv2 & GICv3: RAZ/WI
 reserved addresses rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Drew Jones <drjones@redhat.com>, Auger Eric <eric.auger@redhat.com>, Wei Huang <wei@redhat.com>

On 01/09/18 17:12, Peter Maydell wrote:
> On 9 January 2018 at 15:58, Laszlo Ersek <lersek@redhat.com> wrote:
>> Sorry, no clue about any of this -- where should I read up?
> 
> I cc'd you mostly as a heads-up since the QEMU bug is UEFI affecting,
> not because I wanted to make you read the GIC specs :-)

Thanks (and, thanks :) ) -- from patch #2, looks like GICv2 is affected
too, and the patch seems to be fixing commit a9d853533cc1
("hw/intc/arm_gic: Switch to read/write callbacks with tx attributes",
2015-05-12).

Is that right? That commit was released with v2.4.0. Should I have
experienced the error? Is it KVM / hardware specific? What are the symptoms?

>> Ard did ask a question though:
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg500055.html
> 
> Sounds plausible (my UEFI binary I hit this with is pretty ancient)
> but I don't know for certain. It's one of those things that seems
> like it's a bug in UEFI (perhaps now fixed) but which is also
> definitely a bug in QEMU, and if it is a UEFI bug it's pretty
> harmless.

... I don't know the symptoms of the issue either that was fixed by
<https://github.com/tianocore/edk2/commit/28f8d28faabf50a82ef8d137308592c64ea9e2b6>.
Guest crashes with unhandled data abort? (I.e., impossible not to notice.)

Thanks!
Laszlo
