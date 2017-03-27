Received: from eggs.gnu.org ([2001:4830:134:3::10]:39125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csWPc-0004AY-Vt
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1csWPY-0005kO-Ec
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:18:28 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1csWPY-0005jr-6r
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:18:24 -0400
Received: by mail-wr0-x231.google.com with SMTP id u1so61639952wra.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 08:18:24 -0700 (PDT)
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<CAFEAcA8UYsjy6sBTGqk1Crd-0tWpF0WWukA03_GyNRaG95L07Q@mail.gmail.com>
	<87d1d8xn41.fsf@linaro.org>
	<CAFEAcA-VQHv-wD+2NBwYAe75139+37qkaypCbKOoHHk5ZRr-QA@mail.gmail.com>
	<87bmssxm9s.fsf@linaro.org> <1490621384.31035.30.camel@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1490621384.31035.30.camel@redhat.com>
Date: Mon, 27 Mar 2017 16:18:21 +0100
Message-ID: <871sti694y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1675108] [NEW] Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Bug 1675108 <1675108@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> On Do, 2017-03-23 at 11:31 +0000, Alex Bennée wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On 23 March 2017 at 11:13, Alex Bennée <alex.bennee@linaro.org> wrote:
>> >> Technically its not a random thread its the vCPU context (which ensures
>> >> the vCPU isn't updating while the display is being updated). But I guess
>> >> the Cocoa is limited to not being able to update from an arbitrary
>> >> thread?
>> >
>> > Yes. It's very common for windowing libraries to mandate that you
>> > do all windowing operations from one specific thread.
>>
>> Fair enough. Well let me know if that works OK on MacOS and I'll fold it
>> in to the other console patches. In fact I might as well do the
>> start/end_exclusive dance for all OSes and it will achieve the same thing.
>
> Where do we stand with this one?

I've got two patches in my tree at the moment. I was holding off posting
the series to see if I could make more progress with the record/replay
bug. I'll post the series tomorrow morning but if you want to grab them
ahead of that see:

  https://github.com/stsquad/qemu/commit/6c0ddfc5752f311b4c5a2956de25821cc2cd3fd6
  https://github.com/stsquad/qemu/commit/15d2b05a20879017f20370b71d5d144947b693fe

--
Alex Bennée
