Received: from eggs.gnu.org ([209.51.188.92]:52090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGnd4-0006iv-QN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGnd3-0000Df-Eo
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:41:46 -0400
Received: from mail-eopbgr710133.outbound.protection.outlook.com
	([40.107.71.133]:51296
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGnd2-0000CM-Vn
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:41:45 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 17 Apr 2019 16:41:39 +0000
Message-ID: <BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH] target/mips: Amend tests for MSA binary integer operatio=
ns
>
> Amend tests for certain MSA binary integer instructions
> (for example DIV_S.B) by appending two missing test cases
> to complete standard battery of 80 test cases for each
> such instruction. Expected values were pulled from the
> results of the MIPS64r6 machine that executed those
> instruction, and QEMU emulation should produce the same
> results.
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

I'm afraid your patch doesn't apply to the tip of the source tree:

$ git am target-mips-Amend-tests-for-MSA-binary-integer-operations.patch Ap=
plying: target/mips: Amend tests for MSA binary integer operations
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c=
:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c: patch does n=
ot apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c:=
2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c: patch does no=
t apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c: patch does =
not apply
error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.=
c:2
error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c: patch does =
not apply
Patch failed at 0001 target/mips: Amend tests for MSA binary integer operat=
ions
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Please update/rebase your tree before sending patches in future.

Thanks,
Aleksandar=
