Received: from eggs.gnu.org ([2001:4830:134:3::10]:34198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1eJxAx-0006qt-Kd
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1eJxAw-0004Sn-JI
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:52:59 -0500
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB0480A1F01D2CEF51E7CE21B09E3A0@MWHPR21MB0480.namprd21.prod.outlook.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
	<CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
	<CAFEAcA9_+wZJa7Ht6EHCCZYm+hrfdbjd9gUmVJPGgZ0yvbZOPA@mail.gmail.com>
	<MWHPR21MB0480DE1F826056BC8377EE289E250@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw31C0Z2vp0S0ZFBOC6A3146wxtZWvzJabACkGh44ZwC0w@mail.gmail.com>
	<MWHPR21MB0480A1F01D2CEF51E7CE21B09E3A0@MWHPR21MB0480.namprd21.prod.outlook.com>
From: bzt bzt <bztemail@gmail.com>
Date: Wed, 29 Nov 2017 08:52:54 +0100
Message-ID: <CADYoBw1Ro5gxROvhCVXGv0=-Y8zXmGbKR3D6xOqhkb0zp__LkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On Tue, Nov 28, 2017 at 6:54 PM, Andrew Baumann <
Andrew.Baumann@microsoft.com> wrote:

> > From: bzt bzt [mailto:bztemail@gmail.com]
> > Sent: Tuesday, 28 November 2017 03:27
>
> > Yes, I agree. I've provided a parameterised version on Oct 24, which
> does not
> > have a separate bcm2837 implementation. Is that patch ok?
>
> That patch was moving in the right direction, but I think there were two
> problems with it. First, the right way to pass a parameter is via a
> property field (as Peter explained). Second, IMO the parameter should be
> the CPU model string to instantiate and not the Pi version number.
>

Thanks!


>
> > Or should I wait
> > for Alistair's patch (https://lists.gnu.org/
> archive/html/qemu-devel/2017-
> > 10/msg04153.html)?
>
> Alistair's patch doesn't actually help you as far as I can see, since it
> doesn't change what CPU bcm2836 instantiates. I think it just means that if
> the user specifies a different CPU type they get an error rather than being
> silently ignored.
>

It does add the CPU model string, which can and should be used in bcm2836
to decide which CPU to instatiate (regardless the method of passing that
parameter). If I add yet another CPU model string, the two patch will be in
conflict containing redundant information. Also I'm sure would raspi3 use
different cpus, we should always instantiate the one the user specified.
Although here is only one possible CPU model, still that seems to be the
correct behavior. Don't get me wrong, I don't criticize, I just want to
find the best solution. Setting the CPU model only once for each version
seems right. I was thinking: if there's going to be a user specified CPU
model string anyway, why not use that one?

bzt


>
> Andrew
>
