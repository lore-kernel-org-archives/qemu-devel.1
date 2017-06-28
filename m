Received: from eggs.gnu.org ([2001:4830:134:3::10]:55074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dQEQK-0001dT-3U
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dQEQJ-0006Hi-6D
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:58:32 -0400
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Wed, 28 Jun 2017 16:57:59 +0200
Message-Id: <1498661881-9605-1-git-send-email-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] Rewrite 'live-block-ops.txt';
 convert 'bitmaps.md' to rST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, stephen@that.guru, qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>

Rewrite the 'live-block-ops.txt' document (after renaming it to
'live-block-operations.rst') in reStructuredText (rST) format.  Given
upstream QEMU's desire[*] to take advantage of the Sphinx + rST
framework to gerate its documentation:

    "Based on experience from the Linux kernel, QEMU's docs pipeline is
    going to be based on Sphinx [...] Sphinx is extensible and it is
    easy to add new input formats and input directives."

And as part of review, John Snow suggested[+] to link to the
'bitmaps.md' document.  So while at it, convert the 'bitmaps.md'
document also into rST syntax.

Then, moved both the documents ('live-block-operations.rst', and
'bitmaps.rst') to 'qemu/docs/interop' directory.  (Paolo explained the
term "interop" as: "management & interoperability with QEMU".)

That's the result of this series:

(1) Rewrite the 'live-block-ops.txt' document (for details, refer the
    commit message of the patch) in rST.

    Sphinx-generted HTML rendering:

        https://kashyapc.fedorapeople.org/v4-QEMU-Docs/_build/html/docs/live-block-operations.html

(2) Convert the 'bitmaps.md' document to rST, as discussed on this[+]
    thread.
    
    Sphinx-generted HTML rendering:

        https://kashyapc.fedorapeople.org/v4-QEMU-Docs/_build/html/docs/bitmaps.html

    NB: Since I rolled up the bitmaps.rst into this submission, I just
    stuck a v4 for this patch, too.

[*] http://wiki.qemu.org/Features/Documentation
[+] https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05428.html

Kashyap Chamarthy (2):
  live-block-ops.txt: Rename, rewrite, and improve it
  bitmaps.md: Convert to rST; move it into 'interop' dir

 docs/devel/bitmaps.md                  |  505 ----------------
 docs/interop/bitmaps.rst               |  555 +++++++++++++++++
 docs/interop/live-block-operations.rst | 1037 ++++++++++++++++++++++++++++++++
 docs/live-block-ops.txt                |   72 ---
 4 files changed, 1592 insertions(+), 577 deletions(-)
 delete mode 100644 docs/devel/bitmaps.md
 create mode 100644 docs/interop/bitmaps.rst
 create mode 100644 docs/interop/live-block-operations.rst
 delete mode 100644 docs/live-block-ops.txt

-- 
2.7.5
