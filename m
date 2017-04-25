Received: from eggs.gnu.org ([2001:4830:134:3::10]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2yZQ-0004YW-7f
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2yZN-0000a7-IF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:23:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2yZN-0000ZN-8Z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:23:45 -0400
Date: Tue, 25 Apr 2017 12:23:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170425112339.GD2103@work-vm>
References: <CGME20170414131739eucas1p1ea9a6adcdbe8cfe45ac1ff582d28d873@eucas1p1.samsung.com>
	<1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<1492175840-5021-3-git-send-email-a.perevalov@samsung.com>
	<CAFEAcA9ve6APJtoHrqmzOTMcmu0KAFqdJ9bfyfTX7wjJD7eULQ@mail.gmail.com>
	<20170421151005.GA5101@aperevalov-ubuntu>
	<CAFEAcA9WPO+=jCFfOod=dnP0k9-H=d7Jb3KVm69E95WoMwyVrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9WPO+=jCFfOod=dnP0k9-H=d7Jb3KVm69E95WoMwyVrA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] util: introduce glib-helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey <a.perevalov@samsung.com>, i.maximets@samsung.com, QEMU Developers <qemu-devel@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 21 April 2017 at 16:10, Alexey <a.perevalov@samsung.com> wrote:
> > Hello, thank you for so  detailed comment,
> >
> > On Fri, Apr 21, 2017 at 11:27:55AM +0100, Peter Maydell wrote:
> 
> >> Can we have a proper doc comment format comment, please,
> >> since this is now a function available to all of QEMU?
> >>
> >> > +gint g_int_cmp64(gconstpointer a, gconstpointer b,
> >> > +        gpointer __attribute__((unused)) user_data);
> >>
> >> What is this actually for? Looking at the original uses
> >> I can tell that this is a GCompareDataFunc function, but
> >> the comment should tell me that.
> > I looked at another functions comments in QEMU, I didn't find
> > some common style, and decided keep it as is. Maybe I omitted some
> > best practice here.
> 
> See include/qemu/bitops.h for an example of the comment style.
> More important than just the style is that the comment
> should clearly explain the purpose of the function in detail.
> 
> Certainly many of our existing functions are poorly documented,
> but we're trying to raise the bar gradually here.
> 
> > yes, it was copy pasted,
> > right now, after mingw build check I think to use intptr_t as a type
> > for comparision in this function or even keep gpointer and merge these two
> > functions into _direct_.
> > I saw intptr_t is widely used in QEMU.
> >
> > The intent of this function was a comparator for case when client code
> > want to keep integers in pointer field. xen_disk.c uses UINT32 so it
> > wasn't a problem, but migration uses 64 address (kernel provides it in
> > __u64, long long), so on 32 platform it's a problem.
> 
> Code which tries to put a genuinely 64 bit value into a pointer
> is buggy and needs to be fixed. I'm not clear if that is the
> case here, or if the ABI from the kernel guarantees that the
> value is really a pointer type and fits in uintptr_t / gpointer.

It's a (probably masked) HVA, so always a valid pointer.

Dave

> I don't think we need more than one of these functions.
> 
> >> This is also missing the copyright line.
> > Yes, maybe it was better for me to ask before send.
> > I found in util files with reference to GNU GPL, version 2, like
> > in this file, also I found that
> >
> >  * This library is free software; you can redistribute it and/or
> >  * modify it under the terms of the GNU Lesser General Public
> >  * License as published by the Free Software Foundation; either
> >  * version 2 of the License, or (at your option) any later version.
> >
> > So I just copied copyright reference from glib-compat.h.
> 
> Yes, that's the license statement, which is fine. What is
> missing is the copyright line, which in glib-compat.h looks
> like:
>  Copyright IBM, Corp. 2013
> 
> For code you write, you want either your personal or (more likely)
> a Samsung copyright line -- check with your company about what
> their preferred form is.
> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
