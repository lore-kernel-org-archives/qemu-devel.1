Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913FC2BB85
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8252082D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 08:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kAbIxVZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8252082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM5ec-0000l9-7R
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 04:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jM5du-0000LV-FN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jM5ds-0005ym-Pz
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:01:02 -0400
Received: from ozlabs.org ([203.11.71.1]:48895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1jM5dr-0005vO-Np
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 04:01:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xxY22C5Zz9sSG; Wed,  8 Apr 2020 18:00:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586332854;
 bh=M/k/Nc9aO+7LmtmIlGUsSx5PmoGqfXqcMk1oDtCOzf8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kAbIxVZKUJNJUV/aWJlqEC43/YPHq8Gp47WK7xemW2bh1L/yixNXn+zQ+CTUeEK7B
 OqSgIXEyDJmxhGj3jE1y+7Jl034EMts+LjLbXin0b7yW/YMjOuqAe5q/TvHNh4ox5M
 IPMV7NbWQh8exGQHYiQL8gBkmn+SfLs1aVn+zkhI=
Date: Wed, 8 Apr 2020 18:00:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH] configure: check for bison, flex before dtc submodule
 build
Message-ID: <20200408080046.GD304335@umbus.fritz.box>
References: <20200407111618.17241-1-cfontana@suse.de>
 <CAFEAcA9SYT227B9K7yHcv_J==r4xZ1spUSNzL_bRXUpAjT5QVA@mail.gmail.com>
 <20200408015717.GA44664@umbus.fritz.box>
 <1353d8a4-fe8b-ee8f-2f42-f1f463188767@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <1353d8a4-fe8b-ee8f-2f42-f1f463188767@suse.de>
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


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 09:52:40AM +0200, Claudio Fontana wrote:
> On 4/8/20 3:57 AM, David Gibson wrote:
> > On Tue, Apr 07, 2020 at 12:20:15PM +0100, Peter Maydell wrote:
> >> On Tue, 7 Apr 2020 at 12:16, Claudio Fontana <cfontana@suse.de> wrote:
> >>>
> >>> if fdt is required, and the system DTC (libfdt) is not usable,
> >>> check for the dtc submodule requirements before trying to build it,
> >>> and error out with a helpful message in case the dependencies are not=
 met.
> >>>
> >>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> >>
> >> Does the dtc module actually need bison/flex, or does it just
> >> print an ugly warning about it? We only want the 'libfdt' part
> >> of dtc, which doesn't need the parser, we don't need to build
> >> the actual dtc compiler.
> >=20
> > Assuming we're just invoking "make libfdt" within the submodule,
> > rather than "make" which will build dtc as well, then bison / flex
> > shouldn't be needed.
> >=20
>=20
> Indeed; I just sent a patch that works for me,
> tried a few in-tree and out-of-tree full builds, and it seems to work as =
intended.
> patchew complains about docker builds/tests though, although running the =
same TEST SCRIPTs manually with docker works for me.
>=20
> The libfdt target inside dtc/Makefile actually causes more than just libf=
dt to be built:
>=20
> ~/git/qemu/dtc> make libdtc
> 	 DEP tests/dumptrees.c
> 	 DEP tests/trees.S
> 	 DEP tests/testutils.c
> 	 DEP tests/value-labels.c
> 	 DEP tests/asm_tree_dump.c
> 	 DEP tests/truncated_memrsv.c
> 	 DEP tests/truncated_string.c
> 	 DEP tests/truncated_property.c
> 	 DEP tests/check_full.c
> 	 DEP tests/check_header.c
> 	 DEP tests/check_path.c
> 	 DEP tests/overlay_bad_fixup.c
> 	 DEP tests/overlay.c
> 	 DEP tests/subnode_iterate.c
> 	 DEP tests/property_iterate.c
> 	 DEP tests/integer-expressions.c
> 	 DEP tests/utilfdt_test.c
> 	 DEP tests/path_offset_aliases.c
> 	 DEP tests/add_subnode_with_nops.c
> 	 DEP tests/dtbs_equal_unordered.c
> 	 DEP tests/dtb_reverse.c
> 	 DEP tests/dtbs_equal_ordered.c
> 	 DEP tests/extra-terminating-null.c
> 	 DEP tests/incbin.c
> 	 DEP tests/boot-cpuid.c
> 	 DEP tests/phandle_format.c
> 	 DEP tests/path-references.c
> 	 DEP tests/references.c
> 	 DEP tests/string_escapes.c
> 	 DEP tests/propname_escapes.c
> 	 DEP tests/appendprop2.c
> 	 DEP tests/appendprop1.c
> 	 DEP tests/del_node.c
> 	 DEP tests/del_property.c
> 	 DEP tests/setprop.c
> 	 DEP tests/set_name.c
> 	 DEP tests/rw_tree1.c
> 	 DEP tests/open_pack.c
> 	 DEP tests/nopulate.c
> 	 DEP tests/mangle-layout.c
> 	 DEP tests/move_and_save.c
> 	 DEP tests/sw_states.c
> 	 DEP tests/sw_tree1.c
> 	 DEP tests/nop_node.c
> 	 DEP tests/nop_property.c
> 	 DEP tests/setprop_inplace.c
> 	 DEP tests/stringlist.c
> 	 DEP tests/addr_size_cells2.c
> 	 DEP tests/addr_size_cells.c
> 	 DEP tests/notfound.c
> 	 DEP tests/sized_cells.c
> 	 DEP tests/char_literal.c
> 	 DEP tests/get_alias.c
> 	 DEP tests/node_offset_by_compatible.c
> 	 DEP tests/node_check_compatible.c
> 	 DEP tests/node_offset_by_phandle.c
> 	 DEP tests/node_offset_by_prop_value.c
> 	 DEP tests/parent_offset.c
> 	 DEP tests/supernode_atdepth_offset.c
> 	 DEP tests/get_path.c
> 	 DEP tests/get_phandle.c
> 	 DEP tests/getprop.c
> 	 DEP tests/get_name.c
> 	 DEP tests/path_offset.c
> 	 DEP tests/subnode_offset.c
> 	 DEP tests/find_property.c
> 	 DEP tests/root_node.c
> 	 DEP tests/get_mem_rsv.c
> 	 DEP libfdt/fdt_overlay.c
> 	 DEP libfdt/fdt_addresses.c
> 	 DEP libfdt/fdt_empty_tree.c
> 	 DEP libfdt/fdt_strerror.c
> 	 DEP libfdt/fdt_rw.c
> 	 DEP libfdt/fdt_sw.c
> 	 DEP libfdt/fdt_wip.c
> 	 DEP libfdt/fdt_ro.c
> 	 DEP libfdt/fdt.c
> 	 DEP util.c
> 	 DEP fdtoverlay.c
> 	 DEP fdtput.c
> 	 DEP fdtget.c
> 	 DEP fdtdump.c
> 	 LEX convert-dtsv0-lexer.lex.c
> make: flex: Command not found
> 	 DEP srcpos.c
> 	 BISON dtc-parser.tab.c
> make: bison: Command not found
> 	 LEX dtc-lexer.lex.c
> make: flex: Command not found
> 	 DEP treesource.c
> 	 DEP livetree.c
> 	 DEP fstree.c
> 	 DEP flattree.c
> 	 DEP dtc.c
> 	 DEP data.c
> 	 DEP checks.c
> 	CHK version_gen.h
> 	 LEX convert-dtsv0-lexer.lex.c
> make: flex: Command not found
> 	 BISON dtc-parser.tab.c
> make: bison: Command not found
> 	 LEX dtc-lexer.lex.c
> make: flex: Command not found
> make: *** No rule to make target 'libdtc'.  Stop.
>=20
>=20
> so I just used dtc/libfdt/Makefile.libfdt directly and removed the
> recursion altogether.

The Makefile setup of dtc/libfdt is a bit weird (mostly to allow for
Makefile fragments to be used in weird build environments).  But for
this case you might be better off still doing the recursion, but just
changing the target from 'all' to 'libfdt'.

> Let me know what you think about the idea in general, or if anybody knows=
 what is wrong in the patch that makes patchew complain?
>=20
> Ciao,
>=20
> Claudio
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6NhKsACgkQbDjKyiDZ
s5KlNRAAiMR6MaLKjfxsHLWJ679n28LRkOSWfMgekIn4enqQocw0iEnTy1aHdqP8
nZOE4mSHubegKZam6VFSn/ziQ/9k1hHf60+Oz4TS0a90I9as6aSllLRrzmppe9Mc
agbx44b04/G79Iv7Q5ZoXkNk6USpyVZ4kJXjL5LHNLE0Lk7QYAHj9XDYWhJ8ZOoX
CZTutT+Usjb5RlECVKEHUX//o6Cpg+/QlyGRmWmHlmSDYfcbitlgkniV1QbbfZ7J
NGkuvf8MMGzaYB9DdqxWZ7aLHxpy27AS0i2LncONTCOjKGvmfMC4UgjV6QQCUt1C
Mbf+u6ec5DiHsaA7K7El3yBKfEHYjvxOLuFLuHtSuNH3cpO55AtJh92P+KfmZhxw
mT30Kd5KWMzQxUVUxTTQj4iCR6WCR2mqzh34TCLZwm8pTrYECNFlB1gf6gufpV/g
8qmdILMpC0KN24zkspYgmD538cx5K7VsJ/tOqdmfqg6dEkltSMwLKCJBza9xbQfj
HEbFsdg1p+tMiDbVHvX1tRle7UBCa5TOIItocq0+Ab94GAUzjyD4sTqopUoc5TUq
4bFlmfhMCWtGU4c/zGGdNzpiS727xbegWeK99pPBieWdcwj6ctEZ1hJTfRoEyPST
teE6bOWAsZV1JQDoo8mmxqDFkOxT7cbNfQMdTqu4T53Nv52VpIs=
=UPo4
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--

