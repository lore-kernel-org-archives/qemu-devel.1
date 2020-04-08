Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3619C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAE02074F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 09:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XujKIKO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAE02074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM6jA-0004Wa-QF
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 05:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jM6JF-0003hz-MD
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jM6JC-0001eK-J7
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:43:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37857 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1jM6JA-0001bg-GL
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:43:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xyVH1phsz9sSG; Wed,  8 Apr 2020 18:43:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586335415;
 bh=zhRo/eQUGHWzQheZOLhJztXqQHYDc6QL9QQfrHkUo8A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XujKIKO0Pxd2ai/zACXJYGBmgXH/u6QtaZTVMUt/ZUjY3iqLYT96Z2dQehfrftVPg
 GY00NMyKrjW/bisNh7j/8RgAgf/guVuldTKbfbozuyIHiQGCkm5Jt5T2sk8XtvdRmz
 +sy50246v0E/wvj3LirmUwEu/HWsBzs0YN+JICDM=
Date: Wed, 8 Apr 2020 18:36:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH] configure: check for bison, flex before dtc submodule
 build
Message-ID: <20200408083631.GF304335@umbus.fritz.box>
References: <20200407111618.17241-1-cfontana@suse.de>
 <CAFEAcA9SYT227B9K7yHcv_J==r4xZ1spUSNzL_bRXUpAjT5QVA@mail.gmail.com>
 <20200408015717.GA44664@umbus.fritz.box>
 <1353d8a4-fe8b-ee8f-2f42-f1f463188767@suse.de>
 <20200408080046.GD304335@umbus.fritz.box>
 <8019e044-04d8-df5a-9eae-c525ac1881e5@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Content-Disposition: inline
In-Reply-To: <8019e044-04d8-df5a-9eae-c525ac1881e5@suse.de>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 10:08:57AM +0200, Claudio Fontana wrote:
> On 4/8/20 10:00 AM, David Gibson wrote:
> > On Wed, Apr 08, 2020 at 09:52:40AM +0200, Claudio Fontana wrote:
> >> On 4/8/20 3:57 AM, David Gibson wrote:
> >>> On Tue, Apr 07, 2020 at 12:20:15PM +0100, Peter Maydell wrote:
> >>>> On Tue, 7 Apr 2020 at 12:16, Claudio Fontana <cfontana@suse.de> wrot=
e:
> >>>>>
> >>>>> if fdt is required, and the system DTC (libfdt) is not usable,
> >>>>> check for the dtc submodule requirements before trying to build it,
> >>>>> and error out with a helpful message in case the dependencies are n=
ot met.
> >>>>>
> >>>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> >>>>
> >>>> Does the dtc module actually need bison/flex, or does it just
> >>>> print an ugly warning about it? We only want the 'libfdt' part
> >>>> of dtc, which doesn't need the parser, we don't need to build
> >>>> the actual dtc compiler.
> >>>
> >>> Assuming we're just invoking "make libfdt" within the submodule,
> >>> rather than "make" which will build dtc as well, then bison / flex
> >>> shouldn't be needed.
> >>>
> >>
> >> Indeed; I just sent a patch that works for me,
> >> tried a few in-tree and out-of-tree full builds, and it seems to work =
as intended.
> >> patchew complains about docker builds/tests though, although running t=
he same TEST SCRIPTs manually with docker works for me.
> >>
> >> The libfdt target inside dtc/Makefile actually causes more than just l=
ibfdt to be built:
> >>
> >> ~/git/qemu/dtc> make libdtc
> >> 	 DEP tests/dumptrees.c
> >> 	 DEP tests/trees.S
> >> 	 DEP tests/testutils.c
> >> 	 DEP tests/value-labels.c
> >> 	 DEP tests/asm_tree_dump.c
> >> 	 DEP tests/truncated_memrsv.c
> >> 	 DEP tests/truncated_string.c
> >> 	 DEP tests/truncated_property.c
> >> 	 DEP tests/check_full.c
> >> 	 DEP tests/check_header.c
> >> 	 DEP tests/check_path.c
> >> 	 DEP tests/overlay_bad_fixup.c
> >> 	 DEP tests/overlay.c
> >> 	 DEP tests/subnode_iterate.c
> >> 	 DEP tests/property_iterate.c
> >> 	 DEP tests/integer-expressions.c
> >> 	 DEP tests/utilfdt_test.c
> >> 	 DEP tests/path_offset_aliases.c
> >> 	 DEP tests/add_subnode_with_nops.c
> >> 	 DEP tests/dtbs_equal_unordered.c
> >> 	 DEP tests/dtb_reverse.c
> >> 	 DEP tests/dtbs_equal_ordered.c
> >> 	 DEP tests/extra-terminating-null.c
> >> 	 DEP tests/incbin.c
> >> 	 DEP tests/boot-cpuid.c
> >> 	 DEP tests/phandle_format.c
> >> 	 DEP tests/path-references.c
> >> 	 DEP tests/references.c
> >> 	 DEP tests/string_escapes.c
> >> 	 DEP tests/propname_escapes.c
> >> 	 DEP tests/appendprop2.c
> >> 	 DEP tests/appendprop1.c
> >> 	 DEP tests/del_node.c
> >> 	 DEP tests/del_property.c
> >> 	 DEP tests/setprop.c
> >> 	 DEP tests/set_name.c
> >> 	 DEP tests/rw_tree1.c
> >> 	 DEP tests/open_pack.c
> >> 	 DEP tests/nopulate.c
> >> 	 DEP tests/mangle-layout.c
> >> 	 DEP tests/move_and_save.c
> >> 	 DEP tests/sw_states.c
> >> 	 DEP tests/sw_tree1.c
> >> 	 DEP tests/nop_node.c
> >> 	 DEP tests/nop_property.c
> >> 	 DEP tests/setprop_inplace.c
> >> 	 DEP tests/stringlist.c
> >> 	 DEP tests/addr_size_cells2.c
> >> 	 DEP tests/addr_size_cells.c
> >> 	 DEP tests/notfound.c
> >> 	 DEP tests/sized_cells.c
> >> 	 DEP tests/char_literal.c
> >> 	 DEP tests/get_alias.c
> >> 	 DEP tests/node_offset_by_compatible.c
> >> 	 DEP tests/node_check_compatible.c
> >> 	 DEP tests/node_offset_by_phandle.c
> >> 	 DEP tests/node_offset_by_prop_value.c
> >> 	 DEP tests/parent_offset.c
> >> 	 DEP tests/supernode_atdepth_offset.c
> >> 	 DEP tests/get_path.c
> >> 	 DEP tests/get_phandle.c
> >> 	 DEP tests/getprop.c
> >> 	 DEP tests/get_name.c
> >> 	 DEP tests/path_offset.c
> >> 	 DEP tests/subnode_offset.c
> >> 	 DEP tests/find_property.c
> >> 	 DEP tests/root_node.c
> >> 	 DEP tests/get_mem_rsv.c
> >> 	 DEP libfdt/fdt_overlay.c
> >> 	 DEP libfdt/fdt_addresses.c
> >> 	 DEP libfdt/fdt_empty_tree.c
> >> 	 DEP libfdt/fdt_strerror.c
> >> 	 DEP libfdt/fdt_rw.c
> >> 	 DEP libfdt/fdt_sw.c
> >> 	 DEP libfdt/fdt_wip.c
> >> 	 DEP libfdt/fdt_ro.c
> >> 	 DEP libfdt/fdt.c
> >> 	 DEP util.c
> >> 	 DEP fdtoverlay.c
> >> 	 DEP fdtput.c
> >> 	 DEP fdtget.c
> >> 	 DEP fdtdump.c
> >> 	 LEX convert-dtsv0-lexer.lex.c
> >> make: flex: Command not found
> >> 	 DEP srcpos.c
> >> 	 BISON dtc-parser.tab.c
> >> make: bison: Command not found
> >> 	 LEX dtc-lexer.lex.c
> >> make: flex: Command not found
> >> 	 DEP treesource.c
> >> 	 DEP livetree.c
> >> 	 DEP fstree.c
> >> 	 DEP flattree.c
> >> 	 DEP dtc.c
> >> 	 DEP data.c
> >> 	 DEP checks.c
> >> 	CHK version_gen.h
> >> 	 LEX convert-dtsv0-lexer.lex.c
> >> make: flex: Command not found
> >> 	 BISON dtc-parser.tab.c
> >> make: bison: Command not found
> >> 	 LEX dtc-lexer.lex.c
> >> make: flex: Command not found
> >> make: *** No rule to make target 'libdtc'.  Stop.
> >>
> >>
> >> so I just used dtc/libfdt/Makefile.libfdt directly and removed the
> >> recursion altogether.
> >=20
> > The Makefile setup of dtc/libfdt is a bit weird (mostly to allow for
> > Makefile fragments to be used in weird build environments).  But for
> > this case you might be better off still doing the recursion, but just
> > changing the target from 'all' to 'libfdt'.
>=20
> Hi David,
>=20
> that approach (recursing the same way, just building libfdt instead
> of all) is what I tried first, however as showcased above the libfdt
> target seems to cause more stuff to be built than necessary.

Ah, right.  I had a look at this in dtc upstream.  It looks like the
problem is that we're always doing dependency generation for
everything, including on the flex and bison generated files.

> Do you think we should change the external module to make the
> minimal build of libfdt work, instead of removing the recursion?

It'd be nice to fix this upstream as well, which would also fix it
here.  Unfortunately, I'm not really sure how to do that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6NjQ8ACgkQbDjKyiDZ
s5ICCQ//TVvOk4glL2uDbit1wz3UqwjAKKRD/AyLdrTxVW8KiqzqfrThdvWk3S7B
yyP3ehit/iuHOzvx2x/1K0c0hgw7RVk4plbwI+31PELif9tLRwVwXe16saqFUcu0
kuQCc08GbN0RLa+P6eAJkCzHMezuhGAefyEh4prMbLinfENIMXRTkQuWatwAoc8S
wYTokguSMX+5HjkYaDjiI1agqe2DNEsNMkECBoIfVJp9URfQPNUm++3ECcl8Af/4
DJXziaiCFyoCwiu7qGikwfHRMziC3AeH8BNya5cM4XOJt8j49pkDTrXuX7BePLmL
Nj7yagaMwPzOQRtLGw24ivUfIUmHSG0A2QfIbICObjzqOgA1HDPHVaq1Pa/GGVWB
qWzQr4coF0zNsp09R9GQuXAegs5APITuHbOYrwq4FRP1RB+KrExOZPVA61f6brLF
qlwi4a0Twgy9te9KHBZAUH0lm77Fmm4GfYmWMYMAvu1ub7Ir/fBW0NUoITDqrMos
zks3vV+AR53cPBQUTCo58g7pPfdjh9+zK0dkh6/x2k17zEwpJ8qtt3+gda53SUV+
a6xk05DyRUdUcu6NIrnxAOEY1nOl7nJzpT7s9nEbWkshpWw8lnM4ZRM/FrhHgJIb
0ZS+DA4UE7JGhd/fJLYWcOlKwftT9zfHCzEUgNnW5PAWMAKPnzM=
=d9TJ
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--

