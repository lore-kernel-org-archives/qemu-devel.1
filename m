Received: from eggs.gnu.org ([2001:4830:134:3::10]:35988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1csjwm-0005vz-4j
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1csjwk-0003Vg-KM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 01:45:36 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Mon, 27 Mar 2017 17:10:16 +0000
Message-ID: <HE1P194MB0139BDEBD270E4A51DAAC348C8330@HE1P194MB0139.EURP194.PROD.OUTLOOK.COM>
References: <CABLmASH=JA8qh+bqNjHiAB_hwbxZ-DnA4fy5tgu8+THbwvM7zg@mail.gmail.com>
	<81b9d4e2-92b2-4ab9-8e67-faf2dee8dc81@ilande.co.uk>,
	<25901d9c-7539-3bc6-8372-9ab04d91c95b@redhat.com>
In-Reply-To: <25901d9c-7539-3bc6-8372-9ab04d91c95b@redhat.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] Bug in qemu-system-ppc in Windows using
 the SDL2 GUI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Howard Spoelstra <hsp.cat7@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, =?Windows-1252?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Thomas,

i had been patched the qemu 2.8.91 on the git repository too and the patch =
gave positive result.

i have no more the exit of qemu when a key was pressed .


Thanks

Luigi


________________________________
Da: Thomas Huth <thuth@redhat.com>
Inviato: venerd=EC 24 marzo 2017 10.33
A: Mark Cave-Ayland; Howard Spoelstra; qemu-ppc@nongnu.org; luigi burdo; Al=
ex Benn=E9e; QEMU Developers
Oggetto: Re: [Qemu-ppc] Bug in qemu-system-ppc in Windows using the SDL2 GU=
I

On 24.03.2017 09:56, Mark Cave-Ayland wrote:
> On 24/03/17 08:47, Howard Spoelstra wrote:
>
>> Hi,
>>
>> Running qemu-system-ppc.exe in windows with the SDL2 GUI results in a
>> hangup. I bisected to this commit:
>>
>> 8bb93c6f99a42c2e0943bc904b283cd622d302c5 is the first bad commit
>> commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5
>> Author: Alex Benn=E9e <alex.bennee@linaro.org>
>> Date:   Wed Mar 15 14:48:25 2017 +0000
>>
>>     ui/console: ensure graphic updates don't race with TCG vCPUs
>>
>>     Commit 8d04fb55..
>>
>>       tcg: drop global lock during TCG code execution
>>
>>     ..broke the assumption that updates to the GUI couldn't happen at th=
e
>>     same time as TCG vCPUs where running. As a result the TCG vCPU could
>>     still be updating a directly mapped frame-buffer while the display
>>     side was updating. This would cause artefacts to appear when the
>>     update code assumed that memory block hadn't changed.
>>
>>     The simplest solution is to ensure the two things can't happen at th=
e
>>     same time like the old BQL locking scheme. Here we use the solution
>>     introduced for MTTCG and schedule the update as async_safe_work when
>>     we know no vCPUs can be running.
>>
>>     Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>     Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>>     Message-id: 20170315144825.3108-1-alex.bennee@linaro.org
>>     Cc: BALATON Zoltan <balaton@eik.bme.hu>
>>     Cc: Gerd Hoffmann <kraxel@redhat.com>
>>     Cc: Paolo Bonzini <pbonzini@redhat.com>
>>     Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>>
>>     [ kraxel: updated comment clarifying the display adapters are buggy
>>               and this is a temporary workaround ]
>>
>>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Hi Howard,
>
> Alex posted another patch yesterday to resolve a similar issue:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04474.html.
>
> Does applying the above patch help at all?

Luigi Burdo reported a similar issue here:

https://bugs.launchpad.net/qemu/+bug/1675549
Bug #1675549 =93tcg softmmu i386 crashes on BE hardware " : Bugs : QEMU<htt=
ps://bugs.launchpad.net/qemu/+bug/1675549>
bugs.launchpad.net
Hi, today i try to test qemu 2.9rc 1 with qemu-system-i386 if i set display=
 as sdl and i push a key on keyboard qemu exit with an error translate-comm=
on.c:34:tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked=
()) This issue was not present on qemu 2.8.0 Test Machine PowerMac G5 Quad =
Fedora 25 Server PPC64 Qemu build with target-list=3Di386-softmuu --with-sd=
labi=3D2.0 Ciao Luigi



Luigi, could you please try Alex' patch to see whether it fixes your crash?

 Thanks,
  Thomas
