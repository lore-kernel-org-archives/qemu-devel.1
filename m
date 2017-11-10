Received: from eggs.gnu.org ([2001:4830:134:3::10]:42391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1eDH6U-0005wd-BO
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zachriggle@gmail.com>) id 1eDH6Q-00028r-6x
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 16:44:46 -0500
MIME-Version: 1.0
In-Reply-To: <20171107200634.GB27631@kos.to>
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
	<20171027093600.GA29513@kos.to>
	<CAMP9c5mm7icy06goXr3iiOEgqPbzyaWDt775+9+L=oxnqwRhpA@mail.gmail.com>
	<CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
	<2251f54e-4c55-7495-8f60-af40cdd80594@redhat.com>
	<CAFEAcA-r-KxNDkHFJEdQDVnNXf4N-8zptjQK9a-uPixnSMsg+w@mail.gmail.com>
	<CAMP9c5krrvH-TpH0mM1D3Fm8=E+C7nYHU8h3b5CwU1Nb2HxN-A@mail.gmail.com>
	<20171107200634.GB27631@kos.to>
From: Zach Riggle <zachriggle@gmail.com>
Date: Fri, 10 Nov 2017 15:44:08 -0600
Message-ID: <CAMP9c5==+vgyYzb2+VdijvaxBhYLx4zhhyqJoptdhLZAdEaEGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix is_proc_myself to check
 the paths via realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Day 17 Ping :)



*Zach Riggle*

On Tue, Nov 7, 2017 at 2:06 PM, Riku Voipio <riku.voipio@iki.fi> wrote:

> Hi,
>
> On Mon, Nov 06, 2017 at 08:17:44PM +0000, Zach Riggle wrote:
> > Ping! What needs to be done to move this forward? My current
> implementation
> > is compatible with musl.
>
> I'll have a look at it soon.
>
> Riku
>
> > On Thu, Nov 2, 2017 at 12:36 PM Peter Maydell <peter.maydell@linaro.org>
> > wrote:
> >
> > > On 28 October 2017 at 06:14, Eric Blake <eblake@redhat.com> wrote:
> > > > By definition, in linux-user, we ARE using glibc; therefore, you are
> > > > free to use all GNU extensions.
> > >
> > > Don't we also support musl libc? I forget...
> > >
> > > thanks
> > > -- PMM
> > >
>
