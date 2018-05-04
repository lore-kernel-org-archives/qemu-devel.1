Received: from eggs.gnu.org ([2001:4830:134:3::10]:39013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEP8l-0005XA-IN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fEP8k-0001cQ-EL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:04:03 -0400
References: <20180503225648.13153-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <df5d75a1-6855-c462-6f05-662a42f50f39@redhat.com>
Date: Thu, 3 May 2018 21:03:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180503225648.13153-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] qemu-img: make subcommand usage
 docstrings consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 05/03/2018 06:56 PM, John Snow wrote:
> I'm working on a project to attempt to autogenerate all of this, but
> until then let's just do a bit of the usual kinds of tidying.
> 
> ________________________________________________________________________________
> 
> For convenience, this branch is available at:
> https://github.com/jnsnow/qemu.git branch trivial-qemu-img
> https://github.com/jnsnow/qemu/tree/trivial-qemu-img
> 
> This version is tagged trivial-qemu-img-v1:
> https://github.com/jnsnow/qemu/releases/tag/trivial-qemu-img-v1
> 
> John Snow (5):
>   qemu-img-commands.hx: argument ordering fixups
>   qemu-img.texi: fix command ordering
>   qemu-img: remove references to GEN_DOCS
>   qemu-img: Make documentation between .texi and .hx consistent
>   qemu-img-cmds.hx: add passive-aggressive note
> 
>  qemu-img-cmds.hx       | 13 +++++----
>  qemu-img.c             |  2 --
>  qemu-img.texi          | 78 ++++++++++++++++++++++++++------------------------
>  qemu-options-wrapper.h |  1 -
>  4 files changed, 48 insertions(+), 46 deletions(-)
> 

Possessed by some kind of malevolent phantasm, I documented the following:

amend	 [--object objectdef] [--image-opts] [-q] [-f fmt]      filename
bench                                        [-q] [-f fmt] [-U] filename
check    [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filename
commit   [--object objectdef] [--image-opts] [-q] [-f fmt]      filename
compare  [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filename
convert  [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filename
create   [--object objectdef]                [-q] [-f fmt]      filename
dd                            [--image-opts]      [-f fmt] [-U]
info     [--object objectdef] [--image-opts]      [-f fmt] [-U] filename
map      [--object objectdef] [--image-opts]      [-f fmt] [-U] filename
measure  [--object objectdef] [--image-opts]      [-f fmt]      filename
snapshot [--object objectdef] [--image-opts] [-q]          [-U] filename
rebase   [--object objectdef] [--image-opts] [-q] [-f fmt] [-U] filename
resize   [--object objectdef] [--image-opts] [-q] [-f fmt]      filename

These are the largely universal set of options we support on most
commands, except sometimes some commands don't support them. Maybe
that's intentional, Maybe it isn't:

- Maybe we don't really want -U on commands that are opened RDWR.
- Maybe -f fmt isn't useful on snapshot or amend (which only work for
qcow2?)
- Maybe -q is inherently pretty useless for commands like info, map, or
measure whose job is to show you something.

Less clear to me:

- Is there no place for --image-opts for create?
- Or --object for dd?
- Or either of these two for bench?


The thought, though, is to define some core set of options that will
always apply to all commands. It might not always be perfect, but the
arguments listed here are a start for what probably makes sense for most
commands. Maybe it's a bad idea; but maybe individual parsers could opt
out of the common set of arguments on an as-needed basis instead.

Might help the documentation along to be able to point to some
definitely universal core group of options.

--js
