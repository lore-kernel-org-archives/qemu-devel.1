Received: from eggs.gnu.org ([2001:4830:134:3::10]:52886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1el4cU-0005fc-T7
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1el4cR-0001Lr-W3
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:17:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1el4cR-0001Jq-Md
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 22:17:27 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1C3EYhe141727
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 22:17:25 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g2h3r806x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 22:17:25 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sun, 11 Feb 2018 22:17:23 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180209131112.2068-1-cohuck@redhat.com>
References: <20180209131112.2068-1-cohuck@redhat.com>
Date: Sun, 11 Feb 2018 21:03:02 -0600
Message-Id: <151840458286.28114.4120688586561065910@sif>
Subject: Re: [Qemu-devel] [PATCH RFC/D] docs: document our stable process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

Quoting Cornelia Huck (2018-02-09 07:11:12)
> Some pointers on how to get a patch into stable.

Thanks for putting this together. I made some minor suggestions below
that might help clarify some points.

> =

> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> =

> This probably needs more love, but I'd like to have at least _some_
> kind of documentation.
> =

> Maybe this should also go into the wiki?

We can probably add a reference to it in:

  https://wiki.qemu.org/Contribute/SubmitAPatch

I should probably add a MAINTAINERS entry for stable that references
it too.

> =

> ---
>  docs/stable-process.rst | 57 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 docs/stable-process.rst
> =

> diff --git a/docs/stable-process.rst b/docs/stable-process.rst
> new file mode 100644
> index 0000000000..2502823dc5
> --- /dev/null
> +++ b/docs/stable-process.rst
> @@ -0,0 +1,57 @@
> +QEMU and the stable process
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +QEMU stable releases
> +--------------------
> +
> +QEMU stable releases are based upon the last released QEMU version
> +and marked by an additional version number, e.g. 2.10.1. Occasionally,
> +a four-number version is released, if a single urgent fix needs to go
> +on top.
> +
> +Usually, a stable release is only done for the last released version.

Maybe:

"Usually, stable releases are only provided for the last major QEMU
release. For example, when QEMU 2.11.0 is released, 2.11.x or 2.11.x.y
stable releases are only produced until QEMU 2.12.0 is released, at
which the stable process moves to producing 2.12.x/2.12.x.y releases."


> +
> +What should go into a stable release?
> +-------------------------------------
> +
> +Generally, the following patches are considered stable material:
> +- Patches that fix severe issues, like fixes for CVEs
> +- Patches that fix regressions
> +
> +If you think the patch would be important for users of the current relea=
se
> +(or for a distribution picking fixes), it is usually a good candidate
> +for stable.
> +
> +
> +How to get a patch into QEMU stable
> +-----------------------------------
> +
> +There are various ways to get a patch into stable:
> +
> +* Preferred: Make sure that the stable maintainers are on copy when you =
send
> +  the patch by adding
> +
> +  .. code::
> +
> +     Cc: qemu-stable@nongnu.org
> +
> +   to the patch description. This will make git add the stable maintaine=
rs
> +   on copy when your patch is sent out.

"By default, this will send the patch to qemu-stable@nongnu.org if you use
git send-email, which is where patches that are stable candidates are
tracked by the maintainers."

"You can also reply to a patch and Cc: qemu-stable@nongnu.org directly with
your mail client if you think a previously submitted patch should be
considered for a stable release."

> +
> +* If a maintainer judges the patch appropriate for stable later on (or y=
ou
> +  notify them), they will add the same line to your patch, meaning that

"to the patch" (in case the Cc'er isn't the author)

> +  the stable maintainers will be on copy on the maintainer's pull reques=
t.
> +
> +* If you judge an already merged patch suitable for stable, send a mail

(preferably as a reply to the most recent patch submission)

> +  to ``qemu-stable@nongnu.org`` with ``qemu-devel@nongnu.org`` and appro=
priate

"along with"

> +  other people (like the patch author or the relevant maintainer) on cop=
y.
> +
> +Stable release process
> +----------------------
> +
> +When the stable maintainers prepare a new stable release, they will prep=
are
> +a git branch with a release candidate and send the patches out to
> +``qemu-devel@nongnu.org`` for review. If any of your patches are include=
d,

"qemu-devel@nongnu.org and qemu-stable@nongnu.org"

> +please verify that they look fine. You may also nominate other patches t=
hat
> +you think are suitable for inclusion. After review is complete (may invo=
lve
> +more release candidates), a new stable release is made available.
> -- =

> 2.13.6
>=20
