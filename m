Received: from eggs.gnu.org ([2001:4830:134:3::10]:43614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dxd0a-0002Eh-0b
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dxd0Z-0004Im-5j
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 13:54:00 -0400
Date: Thu, 28 Sep 2017 13:53:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170928175351.GA14777@flamenco>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<50c325943b1547813567efe6a11fb44644494d70.1506384414.git.alistair.francis@xilinx.com>
	<20170926005520.GA7906@flamenco>
	<CAKmqyKP7b0OP35ctzOmkCwPH4sHQFZAKtyTRgPTYN0iSXkgsaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKP7b0OP35ctzOmkCwPH4sHQFZAKtyTRgPTYN0iSXkgsaw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/8] tests: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Wed, Sep 27, 2017 at 16:08:50 -0700, Alistair Francis wrote:
> On Mon, Sep 25, 2017 at 5:55 PM, Emilio G. Cota <cota@braap.org> wrote:
> > On Mon, Sep 25, 2017 at 17:08:48 -0700, Alistair Francis wrote:
> >> diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
> >> index caa1e8e689..41ba1600c0 100644
> >> --- a/tests/atomic_add-bench.c
> >> +++ b/tests/atomic_add-bench.c
> >> @@ -29,7 +29,7 @@ static const char commands_string[] =
> >>  static void usage_complete(char *argv[])
> >>  {
> >>      fprintf(stderr, "Usage: %s [options]\n", argv[0]);
> >> -    fprintf(stderr, "options:\n%s\n", commands_string);
> >> +    fprintf(stderr, "options:\n%s", commands_string);
> >>  }
> >
> > We do want that trailing \n, unless we move it to commands_string.
> 
> Yeah, this was a mistake. It should have swapped to error_report().
> 
> >
> > Also, I think using error_report here would be confusing -- this is a standalone
> > test program with as little QEMU-specific knowledge as possible (QemuThreads
> > are used for portability); using error_report here is confusing (this is not
> > an error).
> 
> Do you mean in all tests/ sub directory or just a few certain cases?

I was talking specifically about tests/atomic-add-bench and tests/qht-bench,
because I know those well. I don't have a good grasp on everything that's under tests/,
but I presume there are similar cases there too -- that is, standalone programs
where QEMU monitor and/or any other QEMU-specific form of logging makes no sense,
and therefore fprintf(stderr) is the right thing to do.

Thanks,

		Emilio
