Received: from eggs.gnu.org ([2001:4830:134:3::10]:48626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fC8cb-0003RC-Pu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fC8cW-0003AG-Rq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:01:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1fC8cW-00034C-Jk
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 15:01:24 -0400
Date: Fri, 27 Apr 2018 21:01:20 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180427210120.03d037b0@naga.suse.cz>
In-Reply-To: <CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 27 Apr 2018 17:24:38 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 27 April 2018 at 17:17, Thomas Huth <thuth@redhat.com> wrote:
> > On 27.04.2018 17:51, Peter Maydell wrote:  
> >> Hi; I usually let people forget about releases for a month or
> >> so before bringing this topic up, but:
> >>
> >> (1) do we want to call the next release 2.13, or something else?
> >> There's no particular reason to bump to 3.0 except some
> >> combination of
> >>  * if we keep going like this we'll get up to 2.42, which starts to
> >>    get silly
> >>  * Linus-style "avoid being too predictable"
> >>  * triskaidekaphobia  
> >
> > and maybe:
> >
> >  * Celebrate 15 years of QEMU  
> 
> Oh, hey, I hadn't noticed that. That's as good a reason as
> any other!
> 
> > By the way, just another crazy idea for v3.0 (i.e. feel free to
> > turn it down immediately ;-)): Since compilation and testing time
> > for QEMU is really huge, what do you think if we got rid of some
> > QEMU binaries? qemu-system-aarch64 is a superset of
> > qemu-system-arm, qemu-system-x86_64 is a superset of
> > qemu-system-i386 and qemu-system-ppc64 is a superset of
> > qemu-system-ppc (and qemu-system-ppcemb). Would be feasible to get
> > rid of the subset binaries with some work? (I think they were
> > especially useful on 32-bit machines in the past, but most people
> > are using 64-bit machines nowadays, aren't they?).  
> 
> I think Markus' backward-compatibility rubber chicken may prevent
> us from removing those executables...

At least the PPC vs PPC64 default to different BIOS, machine type, etc.

That could be achieved by a wrapper script around the 64bit binary I
suppose.

Is there any reason why the 64bit emulator would not run on 32bit
system? The emulated 64bit system is .. emulated after all.

Thanks

Michal
