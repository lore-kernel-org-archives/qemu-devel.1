Received: from eggs.gnu.org ([2001:4830:134:3::10]:42224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpfKy-00044o-Vw
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpfKv-0000wD-D9
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:50:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:38392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpfKu-0000vj-Ap
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 15:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpfKs-0000nA-4E
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 19:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F02342E851E
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 19:50:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Aug 2018 19:37:44 -0000
From: Michele Denber <1787012@bugs.launchpad.net>
Reply-To: Bug 1787012 <1787012@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153427470081.24411.7587190537485631648.malonedeb@soybean.canonical.com>
Message-Id: <153427546435.27118.6757465796583820980.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1787012] Re: Solaris build error: Bad string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Solved]

There's nothing like going public with a problem to find the answer
yourself shortly after.  In case it helps someone else in the future, it
turns out that the Makefile in dtc/ contains the following line:

HOSTOS :=3D $(shell uname -s | tr '[:upper:]' '[:lower:]' | \
   sed -e 's/\(cygwin\|msys\).*/\1/')

Apparently there's something in there that gmake doesn't like which
causes it to emit "Bad string" so I just replaced that line with:

HOSTOS=3DSunOS

(a call to uname -s from the command line returns SunOS) and I'm no
longer getting the "Bad string" from gmake.  (I'm getting soemthing else
now but that's a different matter).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1787012

Title:
  Solaris build error: Bad string

Status in QEMU:
  New

Bug description:
  While building qemu2.12.0 on a Sun Oracle Enterprise M3000 SPARC64 VII
  running Solaris 10U11, opencsw toolchain, gcc 7.3.0, and python 3.3.6
  I get:

  # gmake
  mkdir -p dtc/libfdt
  mkdir -p dtc/tests
  Bad string
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/dumptrees.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/trees.S
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/testutils.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/value-labels.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/asm_tree_dump.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/truncated_property=
.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/check_path.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/overlay_bad_fixup.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/overlay.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/subnode_iterate.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/property_iterate.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/integer-expression=
s.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/utilfdt_test.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/path_offset_aliase=
s.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/add_subnode_with_n=
ops.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/dtbs_equal_unorder=
ed.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/dtb_reverse.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/dtbs_equal_ordered=
.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/extra-terminating-=
null.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/incbin.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/boot-cpuid.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/phandle_format.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/path-references.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/references.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/string_escapes.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/propname_escapes.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/appendprop2.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/appendprop1.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/del_node.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/del_property.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/setprop.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/set_name.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/rw_tree1.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/open_pack.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/nopulate.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/mangle-layout.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/move_and_save.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/sw_tree1.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/nop_node.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/nop_property.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/setprop_inplace.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/stringlist.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/addr_size_cells.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/notfound.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/sized_cells.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/char_literal.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/get_alias.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/node_offset_by_com=
patible.c         DEP /export/home/denber/qemu-2.12.0/dtc/tests/node_check_=
compatible.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/node_offset_by_pha=
ndle.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/node_offset_by_pro=
p_value.c         DEP /export/home/denber/qemu-2.12.0/dtc/tests/parent_offs=
et.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/supernode_atdepth_=
offset.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/get_path.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/get_phandle.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/getprop.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/get_name.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/path_offset.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/subnode_offset.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/find_property.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/root_node.c
           DEP /export/home/denber/qemu-2.12.0/dtc/tests/get_mem_rsv.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_overlay.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_addresses.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_empty_tree.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_strerror.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_rw.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_sw.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_wip.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt_ro.c
           DEP /export/home/denber/qemu-2.12.0/dtc/libfdt/fdt.c
           DEP /export/home/denber/qemu-2.12.0/dtc/util.c
           DEP /export/home/denber/qemu-2.12.0/dtc/fdtoverlay.c
           DEP /export/home/denber/qemu-2.12.0/dtc/fdtput.c
           DEP /export/home/denber/qemu-2.12.0/dtc/fdtget.c
           DEP /export/home/denber/qemu-2.12.0/dtc/fdtdump.c
           DEP convert-dtsv0-lexer.lex.c
           DEP /export/home/denber/qemu-2.12.0/dtc/srcpos.c
           DEP dtc-parser.tab.c
           DEP dtc-lexer.lex.c
           DEP /export/home/denber/qemu-2.12.0/dtc/treesource.c
           DEP /export/home/denber/qemu-2.12.0/dtc/livetree.c
           DEP /export/home/denber/qemu-2.12.0/dtc/fstree.c
           DEP /export/home/denber/qemu-2.12.0/dtc/flattree.c
           DEP /export/home/denber/qemu-2.12.0/dtc/dtc.c
           DEP /export/home/denber/qemu-2.12.0/dtc/data.c
           DEP /export/home/denber/qemu-2.12.0/dtc/checks.c
  Bad string
           CC libfdt/fdt.o
           CC libfdt/fdt_ro.o
           CC libfdt/fdt_wip.o
           CC libfdt/fdt_sw.o
           CC libfdt/fdt_rw.o
           CC libfdt/fdt_strerror.o
           CC libfdt/fdt_empty_tree.o
           CC libfdt/fdt_addresses.o
           CC libfdt/fdt_overlay.o
           AR libfdt/libfdt.a
  a - libfdt/fdt.o
  a - libfdt/fdt_ro.o
  a - libfdt/fdt_wip.o
  a - libfdt/fdt_sw.o
  a - libfdt/fdt_rw.o
  a - libfdt/fdt_strerror.o
  a - libfdt/fdt_empty_tree.o
  a - libfdt/fdt_addresses.o
  a - libfdt/fdt_overlay.o
  ar: creating libfdt/libfdt.a
  ar: writing libfdt/libfdt.a
  ...

  gmake then completes, returning just a "#" prompt and no error
  messages.  However, no executable is created.  Apparently, "Bad
  string" is the problem, but it is unclear what that means and where
  the two instances of it are coming from.  A web search for this
  problem returned nothing.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1787012/+subscriptions
