Received: from eggs.gnu.org ([2001:4830:134:3::10]:41434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dikn0-000661-6q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dikmz-0004EQ-8e
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:10:30 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dikmz-0004EA-2I
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:10:29 -0400
Received: by mail-wm0-x22f.google.com with SMTP id t201so4569268wmt.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:10:29 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87efs95tkl.fsf@dusky.pond.sub.org>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<87valqw9x0.fsf@dusky.pond.sub.org>
	<CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
	<87lgmluw2g.fsf@dusky.pond.sub.org>
	<ab184e25-19f5-5fd2-494a-7ea04e48f6c7@redhat.com>
	<87fucq86wh.fsf@dusky.pond.sub.org>
	<CAKmqyKOnhGZ6Ei+gSdmOBjHGpVt+G6_J4VF6GVkTCAt1_8GV4w@mail.gmail.com>
	<e7220fad-0b73-68af-20d4-6522789b17c3@amsat.org>
	<87efs95tkl.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 18 Aug 2017 10:09:57 -0700
Message-ID: <CAKmqyKMT81e-E+5A1y0Qj7VWpU_++Pn1mFhgbF6KcOYcRj-W+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Thu, Aug 17, 2017 at 10:32 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
>> On 08/17/2017 02:55 PM, Alistair Francis wrote:
>>>>> On 15/08/2017 09:30, Markus Armbruster wrote:
>>>>>> The stupid fix is to repeat libraries until the link succeeds:
>>>>>>
>>>>>>      test-util-obj-y =3D libqemuutil.a libqemustub.a libqemuutil.a
>>>>>>
>> [...]
>>>>>>
>>>>>> Sticking '-Wp,-(' and '-Wp,-)' into the command line I get from make=
 V=3D1
>>>>>> doesn't work for me, though.
>>>>>>
>>>>>> The smart solution is not to have .a reference each other.
>>>>>
>>>>> Nah, I think we should teach those new kids on the block about -lX11
>>>>> instead. :)
>>>
>>> This sounds scary...
>>>
>>>>>
>>>>>> Paolo, what do you think?
>>>>>
>>>>> Another possibility is to just merge the two static libraries into on=
e.
>>>>
>>>> Sounds good to me!
>>>
>>> I feel like I have opened a can of worms.
>>
>> you are good at it! IIRC it all started with a 1-line change in
>> tcp_chr_wait_connected() more than 2 months ago :)
>>
>>>
>>> I can try and combine libqemustub.a into libqemuutil.a is that the
>>> solution? I just want to make sure before I start this.
>>
>> IMHO your series is OK like this, add a "TODO remove once
>> libqemuutil.a circular dep is resolved" comment in the Makefile is
>> enough, and let this issue for another time.
>
> I disagree.
>
> If merging the two .a is beyond your reach (I hope it isn't), then the
> spot to mess up is this one:

This actually seems pretty easy to do.

I'm going to split this patch and the Makefile changes into a separate
series and send those so I don't end up spamming everyone with the
earlier patches in the series. Then after 2.10 I can combine them all
and send the full series.

Thanks,
Alistair

>
>     # TODO bla bla explain bla
>     test-util-obj-y =3D libqemuutil.a libqemustub.a libqemuutil.a
>
