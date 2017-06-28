Received: from eggs.gnu.org ([2001:4830:134:3::10]:53325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dQEL7-0007JP-2E
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dQEL6-0003oc-2S
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:53:09 -0400
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Wed, 28 Jun 2017 16:52:50 +0200
Message-Id: <1498661572-9272-1-git-send-email-kchamart@redhat.com>
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

David Hildenbrand (2):
  target/s390x: Improve heuristic for ipte
  target/s390x: Implement idte instruction

 target/s390x/cpu_models.c  |  1 +
 target/s390x/helper.h      |  1 +
 target/s390x/insn-data.def |  2 ++
 target/s390x/mem_helper.c  | 76 ++++++++++++++++++++++++++++++++++++++++------
 target/s390x/translate.c   | 15 +++++++++
 5 files changed, 86 insertions(+), 9 deletions(-)

-- 
2.7.5
