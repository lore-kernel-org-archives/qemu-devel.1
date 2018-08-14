Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpUsp-0004sB-4J
	for Qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpUsk-0006eS-8w
	for Qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:40:55 -0400
Date: Tue, 14 Aug 2018 10:40:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814084047.GD5025@dhcp-200-186.str.redhat.com>
References: <20180730212249.16418-1-programmingkidx@gmail.com>
	<5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
	<f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between
 commands in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, John Arbuckle <programmingkidx@gmail.com>, qemu-block@nongnu.org, Qemu-devel@nongnu.org

Am 13.08.2018 um 20:19 hat Eric Blake geschrieben:
> On 08/13/2018 11:56 AM, Max Reitz wrote:
> > 
> > Ah, hm, so much for that.  Hm...  I don't quite know what to think of
> > this.  It does indeed improve legibility.  But the question is whether
> > --help should be as condensed as possible, and if the user finds it hard
> > to read, whether they should not just open the man page...
> > 
> > Then again, our --help text already has 102 lines.
> > 
> > Let me just think about it for a bit longer. :-)
> > (And see whether others have opinions.)
> 
> And I've already expressed my opinion that it is already rather long, where
> making it longer is not necessarily making it smarter.

I think if we want to improve the help text, we should split it up.

$ qemu-img --help
qemu-img version 2.12.94 (v3.0.0-rc4-5-g4fe9c3e13d-dirty)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
usage: qemu-img [standard options] command [command options]
QEMU disk image utility

    '-h', '--help'       display this help and exit
    '-V', '--version'    output version information and exit
    '-T', '--trace'      [[enable=]<pattern>][,events=<file>][,file=<file>]
                         specify tracing options

Commands:

    amend               Change options of an existing disk image
    bench               Run benchmarks on a given disk image
    check               Check the disk image for consistency or repair it
    commit              Merge the disk image into its backing file
    ...

Run 'qemu-img <command> --help' for details.

See <https://qemu.org/contribute/report-a-bug> for how to report bugs.
More information on the QEMU project at <https://qemu.org>.

$ qemu-img check --help
usage: qemu-img check [--object objectdef] [--image-opts] [-q] [-f fmt] [--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename

Command parameters:
  -f        'fmt' is the disk image format. It is guessed automatically
            in most cases.

  -q        use Quiet mode - do not print any output (except errors).

  -r        tries to repair any inconsistencies that are found during the
            check. '-r leaks' repairs only cluster leaks, whereas '-r
            all' fixes all kinds of errors, with a higher risk of
            choosing the wrong fix or hiding corruption that has already
            occurred.

  -T        'src_cache' is the cache mode used to read input disk images,
            the valid options are the same as for the 'cache' option.

  --object  'objectdef' is a QEMU user creatable object definition. See
            the qemu(1) manual page for a description of the object
            properties. The most common object type is a 'secret', which
            is used to supply passwords and/or encryption keys.

  --output  'ofmt' is 'human' for human-readable output (default) or
            'json' for JSON output.

Examples:

    ...

Kevin
