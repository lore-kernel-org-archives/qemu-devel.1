Received: from eggs.gnu.org ([2001:4830:134:3::10]:35813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dXJrc-0006ay-P7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dXJrb-0008HK-Ot
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:12:00 -0400
Date: Tue, 18 Jul 2017 00:11:50 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170718041150.GE26034@localhost.localdomain>
References: <20170717105205.32639-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717105205.32639-1-kchamart@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 0/2] Rewrite
 'live-block-ops.txt'; convert 'bitmaps.md' to rST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com

On Mon, Jul 17, 2017 at 12:52:03PM +0200, Kashyap Chamarthy wrote:
> v7: Address feedback from Eric; add his 'Reviewed-by' on both patches; 
>     also retain John Snow's 'Reviewed-by' on bitmaps.rst
> v6: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02188.html
> v5: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg01368.html
> v4: https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg06395.html
> 
> Rewrite the 'live-block-ops.txt' document (after renaming it to
> 'live-block-operations.rst') in reStructuredText (rST) format.  Given
> upstream QEMU's desire[*] to take advantage of the Sphinx + rST
> framework to gerate its documentation:
> 
>     "Based on experience from the Linux kernel, QEMU's docs pipeline is
>     going to be based on Sphinx [...] Sphinx is extensible and it is
>     easy to add new input formats and input directives."
> 
> And as part of review, John Snow suggested[+] to link to the
> 'bitmaps.md' document.  So while at it, convert the 'bitmaps.md'
> document also into rST syntax.
> 
> Then, moved both the documents ('live-block-operations.rst', and
> 'bitmaps.rst') to 'qemu/docs/interop' directory.  (Paolo explained the
> term "interop" as: "management & interoperability with QEMU".)
> 
> That's the result of this series:
> 
> (1) Rewrite the 'live-block-ops.txt' document (for details, refer the
>     commit message of the patch) in rST.
> 
>     Sphinx-generted HTML rendering:
> 
>         https://kashyapc.fedorapeople.org/v7-QEMU-Docs/_build/html/docs/live-block-operations.html
> 
> (2) Convert the 'bitmaps.md' document to rST, as discussed on this[+]
>     thread.
> 
> 
> [*] http://wiki.qemu.org/Features/Documentation
> [+] https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05428.html
> 
> 
> Kashyap Chamarthy (2):
>   bitmaps.md: Convert to rST; move it into 'interop' dir
>   live-block-ops.txt: Rename, rewrite, and improve it
> 
>  docs/devel/bitmaps.md                  |  505 ---------------
>  docs/interop/bitmaps.rst               |  555 ++++++++++++++++
>  docs/interop/live-block-operations.rst | 1088 ++++++++++++++++++++++++++++++++
>  docs/live-block-ops.txt                |   72 ---
>  4 files changed, 1643 insertions(+), 577 deletions(-)
>  delete mode 100644 docs/devel/bitmaps.md
>  create mode 100644 docs/interop/bitmaps.rst
>  create mode 100644 docs/interop/live-block-operations.rst
>  delete mode 100644 docs/live-block-ops.txt
> 
> -- 
> 2.9.4
> 
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
