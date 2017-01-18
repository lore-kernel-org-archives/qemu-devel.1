Received: from eggs.gnu.org ([2001:4830:134:3::10]:50659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtTs-0000zM-5i
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtTo-0006HH-9t
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:53:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTtTo-0006Ga-3p
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:53:00 -0500
Date: Wed, 18 Jan 2017 14:52:56 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118165256.GC6657@thinpad.lan.raisama.net>
References: <cover.1481121503.git.julian@codesourcery.com>
	<b7f0904f00d135f9b2760b8881dbc9ead23cedbf.1481121503.git.julian@codesourcery.com>
	<CAFEAcA-EQ-e39uv1rnTUb5SwDZzPrHUfhydY5hzc8CrP4NhX_w@mail.gmail.com>
	<20170111123552.1873cb3b@squid.athome>
	<20170112142836.53bbd87b@squid.athome>
	<CAFEAcA8eYeLNrTK-hupM9jA7CPjD8OgEU85As94fWXQETxRgXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8eYeLNrTK-hupM9jA7CPjD8OgEU85As94fWXQETxRgXA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] Add cfgend parameter for ARM CPU
 selection.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Julian Brown <julian@codesourcery.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 17, 2017 at 11:52:24AM +0000, Peter Maydell wrote:
> On 12 January 2017 at 14:28, Julian Brown <julian@codesourcery.com> wrote:
> > On Wed, 11 Jan 2017 12:35:52 +0000
> > Julian Brown <julian@codesourcery.com> wrote:
> >
> >> I'm a little confused, I think -- these changes seemed to be necessary
> >> to allow the parsing of the command-line syntax you suggested earlier
> >> (-mcpu=foo,cfgend=bar):
> >> [...]
> >> Can the existing properties be set like that via the command line?
> >
> > Aha! The answer was yes, but only currently for the "virt" board
> > (which we haven't been using for aarch32, and only supports a few recent
> > CPU types at present). I'm less confused now! (The string-splitting code
> > in arm_cpu_class_by_name is still dubious though, IMO.)
> 
> Oops, I'd forgotten there was board-specific code for handling
> cpu feature flags. I think we want to change the other boards
> to do it like the virt board does, but maybe I'm wrong.
> I've cc'd Eduardo who will hopefully know the right way to handle
> this.

I don't understand what's missing here: cpu_arm_init() already
calls cpu_generic_init(), which already calls
CPUClass::parse_features() after splitting the cpu_model string
and calling CPUClass::class_by_name().

Which board aree you using to test this? Is the board calling
cpu_arm_init() to create the CPU?

-- 
Eduardo
