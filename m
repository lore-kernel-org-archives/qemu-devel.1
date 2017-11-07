Received: from eggs.gnu.org ([2001:4830:134:3::10]:40678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC84g-0003ny-6Y
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC84f-0003Ig-Jh
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:54:10 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC84f-0003IM-CL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:54:09 -0500
Received: by mail-wr0-x243.google.com with SMTP id u97so53132wrc.1
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 09:54:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOG5kASrXuKKm9aLXSRo=jmF3a_LEbBkq4y_LvKGFhbBw@mail.gmail.com>
References: <1509697171.31823.9.camel@redhat.com>
	<CAFEAcA8LWHP-yWZxSQmnL_U2f_RAk-_ZfSERF8U48zqRE+bq0Q@mail.gmail.com>
	<1509715357.5662.1.camel@redhat.com>
	<CAFEAcA-0d1hEz-O1Q9cCGYAJfcc-rFAg2hNA3Wwq5LzBx1PD9Q@mail.gmail.com>
	<1509716406.5662.3.camel@redhat.com>
	<CAKmqyKOG5kASrXuKKm9aLXSRo=jmF3a_LEbBkq4y_LvKGFhbBw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 17:53:47 +0000
Message-ID: <CAFEAcA_4NfAHSM+qZ7qAys=wTPGJRJfta-H_LvyVp4rYfP49mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] capstone broke mingw cross build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 7 November 2017 at 17:52, Alistair Francis <alistair23@gmail.com> wrote:
> On Fri, Nov 3, 2017 at 6:40 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>   Hi,
>>
>>> > "x86_64-w64-mingw32-ar --version" says "GNU ar (GNU Binutils) 2.25"
>>>
>>> Hmm, I guess this 'ar' isn't capable of avoiding the requirement for
>>> ranlib. The capstone makefiles look like they have support for
>>> running ranlib, though...
>>
>> Ah, the recursive call in the qemu Makefile doesn't set RANLIB.
>> So it probably works if that happens to be set correctly in the
>> environment.  I'm using 'configure --cross-prefix=x86_64-w64-mingw32-'
>> for cross builds though.
>
> I'm seeing the same problem on RHEL7.2 as well. Did you find a nicer
> solution then manually running runlib?

Does adding RANLIB to the Makefile rune that calls the capstone
makefile work? (I guess we might need to set it up in configure too.)

thanks
-- PMM
