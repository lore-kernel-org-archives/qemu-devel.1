Received: from eggs.gnu.org ([2001:4830:134:3::10]:54274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8YEK-00028e-Mp
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8YEJ-0005cy-LD
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:33:36 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9V86LVT4L8Neq5hzz-w5LtYyR3BsEnDHJ8f4Sn3L-naw@mail.gmail.com>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
	<CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
	<20180416184406.GC14488@redhat.com>
	<CAFEAcA_uS7f-uf+-OkcskdHG3=eTgr92Mw46nk430q27-wve4g@mail.gmail.com>
	<19b7bccd-2282-5c94-fe7c-68f72ccbaba7@amsat.org>
	<CAFEAcA9V86LVT4L8Neq5hzz-w5LtYyR3BsEnDHJ8f4Sn3L-naw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Apr 2018 23:33:27 +0200
Message-ID: <CAJ+F1C+d5JvTyJQhXExE=B_niZnQnw+YkD+sC4fSEbk67deLHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Tue, Apr 17, 2018 at 11:19 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 17 April 2018 at 19:36, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>> Since this commit, the console on the Malta board stay black...
>>
>> Before:
>> $ qemu-system-mips -M malta -m 512 \
>>   -kernel vmlinux-3.2.0-4-4kc-malta -append 'root=3D/dev/sda1' \
>>   -nographic
>> [    0.000000] Initializing cgroup subsys cpuset
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 3.2.0-4-4kc-malta
>> (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-14) )
>> #1 Debian 3.2.51-1
>> [    0.000000] Config serial console: console=3DttyS0,38400n8r
>> [    0.000000] bootconsole [early0] enabled
>> ...
>>
>> After:
>> $ qemu-system-mips -M malta -m 512 \
>>   -kernel vmlinux-3.2.0-4-4kc-malta -append 'root=3D/dev/sda1' \
>>   -nographic
>> QEMU 2.11.92 monitor - type 'help' for more information
>> (qemu) QEMU 2.11.92 monitor - type 'help' for more information
>> (qemu) q
>
> I reproed this, and as you can see from the transcripts you
> give the problem is that the mux is confused about what the
> active console should be. Before the patch, we correctly
> start with the serial as the active console and C-a c
> switches, but afterwards we start out with the monitor
> active and C-a c doesn't switch. Revert pushed to master.

Thanks Peter for taking care of this "mess" so simply and diligently.

I'll look into it again asap

--=20
Marc-Andr=C3=A9 Lureau
