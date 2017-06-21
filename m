Received: from eggs.gnu.org ([2001:4830:134:3::10]:36044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dNoQy-00020o-B8
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dNoQx-0000Zd-6M
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:49:12 -0400
References: <1498040351-6376-2-git-send-email-kchamart@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bdbe5523-b066-a2ef-9e46-ece40ff4060d@redhat.com>
Date: Wed, 21 Jun 2017 18:49:02 -0400
MIME-Version: 1.0
In-Reply-To: <1498040351-6376-2-git-send-email-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stephen@that.guru, armbru@redhat.com, mreitz@redhat.com



On 06/21/2017 06:19 AM, Kashyap Chamarthy wrote:
> This edition documents (including their QMP invocations) all four
> operations:
> 
>   - `block-stream`
>   - `block-commit`
>   - `drive-mirror` (& `blockdev-mirror`)
>   - `drive-backup` (& `blockdev-backup`)
> 
> Things considered while writing this document:
> 
>   - Use reStructuredText as markup language (with the goal of generating
>     the HTML output using the Sphinx Documentation Generator).  It is
>     gentler on the eye, and can be trivially converted to different
>     formats.  (Another reason: upstream QEMU is considering to switch to
>     Sphinx, which uses reStructuredText as its markup language.)
> 
>   - Raw QMP JSON output vs. 'qmp-shell'.  I debated with myself whether
>     to only show raw QMP JSON output (as that is the canonical
>     representation), or use 'qmp-shell', which takes key-value pairs.  I
>     settled on the approach of: for the first occurence of a command,
>     use raw JSON; for subsequent occurences, use 'qmp-shell', with an
>     occasional exception.
> 
>   - Usage of `-blockdev` command-line.
> 
>   - Usage of 'node-name' vs. file path to refer to disks.  While we have
>     `blockdev-{mirror, backup}` as 'node-name'-alternatives for
>     `drive-{mirror, backup}`, the `block-commit` command still operate
>     on file names for parameters 'base' and 'top'.  So I added a caveat
>     at the beginning to that effect.
> 
>     Refer this related thread that I started (where I learnt
>     `block-stream` was recently reworked to accept 'node-name' for 'top'
>     and 'base' parameters):
>     https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg06466.html
>     "[RFC] Making 'block-stream', and 'block-commit' accept node-name"
> 
> All commands showed in this document were tested while documenting.
> 
> Thanks: Eric Blake for the section: "A note on points-in-time vs file
> names".  This useful bit was originally articulated by Eric in his
> KVMForum 2015 presentation, so I included that specific bit in this
> document.
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> * A Sphinx-rendered HTML version is here:
>   https://kashyapc.fedorapeople.org/v3-QEMU-Docs/_build/html/docs/live-block-operations.html
> 
> 

[snip]

> 
> * TODO (after feedback from John Snow):
>    - Eric Blake suggested to consider documenting incremental backup
>      policies as part of the section: "Live disk backup ---
>      `drive-backup` and `blockdev-backup`"

Perhaps it could be mentioned, but hopefully I've covered it in some
sufficient detail in the (now) docs/devel/bitmaps.md file; I'm a little
wary of duplicating efforts in this area, but you've covered everything
*else* in good detail here, so now my file is the odd one out.

I will leave this up to you, really. Perhaps it could be paid some lip
service with a link to the other document? The detail in bitmaps.md is a
little more verbose than the rest of this file, so if you include it
wholesale it'd dwarf the rest of this document.

What do you think?
