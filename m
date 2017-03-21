Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cqS5E-00071H-2d
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cqS5D-00012F-63
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:16:52 -0400
Date: Tue, 21 Mar 2017 23:15:26 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170321221526.2lcwi25rkahla2ks@eukaryote>
References: <20170317104541.28979-1-stefanha@redhat.com>
	<20170317104541.28979-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317104541.28979-4-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/3] qemu-img: print short
 help on getopt failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com

On Fri, Mar 17, 2017 at 06:45:41PM +0800, Stefan Hajnoczi wrote:
> Printing the full help output obscures the error message for an invalid
> command-line option or missing argument.
> 
> Before this patch:
> 
>   $ ./qemu-img --foo
>   ...pages of output...

That gives me:

    $ qemu-img --foo
    qemu-img: unrecognized option '--foo'

I think you meant any one of the `qemu-img create|convert|... --foo`:

    $ qemu-img create --foo
    [...]

Which _does_ give "pages of output".

Just noting if you want to tweak the commit message.

> After this patch:
> 
>   $ ./qemu-img --foo
>   qemu-img: unrecognized option '--foo'
>   Try 'qemu-img --help' for more information
> 

[...]

-- 
/kashyap
