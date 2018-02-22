Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shea@shealevy.com>) id 1eosdW-0001jV-Rs
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shea@shealevy.com>) id 1eosdS-0004mb-AX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:18:18 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:59818
	helo=smtprelay.hostedemail.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shea@shealevy.com>) id 1eosdS-0004k7-4n
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:18:14 -0500
From: Shea Levy <shea@shealevy.com>
In-Reply-To: <151930950662.717.8558573146147214756@bdbb90650ae5>
References: <151930950662.717.8558573146147214756@bdbb90650ae5>
Date: Thu, 22 Feb 2018 10:18:09 -0500
Message-ID: <87tvu93vf2.fsf@xps13.shealevy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Support f_flags in statfs
 when available.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

--=-=-=
Content-Type: text/plain

Hello,

These tabs match the existing style of linux-user/syscall.h, should I
remove them?

Also, there doesn't appear to be a maintainer for checkpatch in the
current MAINTAINERS file, whom should I CC on this?

Thanks,
Shea

no-reply@patchew.org writes:

> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20180219024555.26467-1-shea@shealevy.com
> Subject: [Qemu-devel] [PATCH v2] linux-user: Support f_flags in statfs when available.
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
>
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
>
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
>
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
>
> exit $failed
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 3ad392fde0 linux-user: Support f_flags in statfs when available.
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: linux-user: Support f_flags in statfs when available....
> ERROR: code indent should never use tabs
> #70: FILE: linux-user/syscall_defs.h:366:
> +^Iint f_frsize;$
>
> ERROR: code indent should never use tabs
> #71: FILE: linux-user/syscall_defs.h:367:
> +^Iint f_flags;$
>
> ERROR: code indent should never use tabs
> #72: FILE: linux-user/syscall_defs.h:368:
> +^Iint f_spare[4];$
>
> ERROR: code indent should never use tabs
> #85: FILE: linux-user/syscall_defs.h:2234:
> +^Iint32_t^I^I^If_flags;$
>
> ERROR: code indent should never use tabs
> #86: FILE: linux-user/syscall_defs.h:2235:
> +^Iint32_t^I^I^If_spare[5];$
>
> ERROR: code indent should never use tabs
> #98: FILE: linux-user/syscall_defs.h:2255:
> +^Iabi_long^I^If_flags;$
>
> ERROR: code indent should never use tabs
> #99: FILE: linux-user/syscall_defs.h:2256:
> +^Iabi_long^I^If_spare[5];$
>
> ERROR: code indent should never use tabs
> #111: FILE: linux-user/syscall_defs.h:2276:
> +^Iuint32_t^If_flags;$
>
> ERROR: code indent should never use tabs
> #112: FILE: linux-user/syscall_defs.h:2277:
> +^Iuint32_t^If_spare[5];$
>
> ERROR: code indent should never use tabs
> #124: FILE: linux-user/syscall_defs.h:2297:
> +^Iabi_long f_flags;$
>
> ERROR: code indent should never use tabs
> #125: FILE: linux-user/syscall_defs.h:2298:
> +^Iabi_long f_spare[4];$
>
> ERROR: code indent should never use tabs
> #137: FILE: linux-user/syscall_defs.h:2316:
> +^Iabi_long f_flags;$
>
> ERROR: code indent should never use tabs
> #138: FILE: linux-user/syscall_defs.h:2317:
> +^Iabi_long f_spare[4];$
>
> ERROR: code indent should never use tabs
> #177: FILE: linux-user/syscall_defs.h:2374:
> +^Iuint32_t f_flags;$
>
> ERROR: code indent should never use tabs
> #178: FILE: linux-user/syscall_defs.h:2375:
> +^Iuint32_t f_spare[4];$
>
> ERROR: code indent should never use tabs
> #190: FILE: linux-user/syscall_defs.h:2393:
> +^Iuint32_t f_flags;$
>
> ERROR: code indent should never use tabs
> #191: FILE: linux-user/syscall_defs.h:2394:
> +^Iuint32_t f_spare[4];$
>
> total: 17 errors, 0 warnings, 164 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlqO3zEACgkQXAvWlX2G
/icByg//Z5Sp8hxT32kw5ao1K2Ea27Y/NWf3wQC0929pGVrjQfZPAob3FoA7OpJN
JjN4wh2360ky7v1BUCmZqCPzBE7+n49lDKirwe+bdup27Zz41ThmVwXBjLtECptI
1ml0t59eUBvo2COyL8RJoOpJcUACBtu0ik6awx3OAEMDDHXJZj9UBijR5yadxJ3s
+hWilPnatGn5n7fCKCr7bJHdORl8jjUFyQ50fR/PhzHq3+kjmYCXxU2IDHXiiKcz
KATqDvji+8xrqMm0mFiSbaYPThTdppQnsywMZ+ylxUkPi7QzL6V0swZkbvNUms6A
Ldyb3cPO9iBlkACOb6HAfZ/j7NxtVPr7xPtQKCO0HIZzzwyLv96N661pY3obC+RX
DTMCwxgyOEbQdj6QBRroA2WDjbVS/QqnOshsI8JMzu0ECxhTr6IeLPKNki6VtOx2
tDsBYX53wy8TeEe5/IUt82jk1fnhEvK9NlHHKHlIH5ey0qXAN0OmYJcHj9VYRAxG
CiftqcWjz4H5JalPe0YnB13PGxStvxDe7h8cu3kssd4Mu9MvjgNK2MEDnaEShNqq
RqgSgDr6N2Rif1NtMQuBgXQ1nC3Gm4DaSLiSdAEX1fs6uDy7evZjGkh8F9fdXJmq
tqKn2vMfedVrLmZxApfJEVCML/SNEFExo6WwgstlIxBaNGpNETI=
=yXGs
-----END PGP SIGNATURE-----
--=-=-=--
