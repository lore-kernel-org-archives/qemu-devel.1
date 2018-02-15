Received: from eggs.gnu.org ([2001:4830:134:3::10]:58295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1emNxy-0002QR-Oa
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1emNxv-0005AL-Go
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:09:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45252
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1emNxv-0005AA-BG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:09:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FHsJjO123899
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 13:09:01 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5e07u4pp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 13:09:01 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 11:09:00 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180212124008.8960-1-cohuck@redhat.com>
References: <20180212124008.8960-1-cohuck@redhat.com>
Date: Thu, 15 Feb 2018 12:08:49 -0600
Message-Id: <151871812906.15399.7207601076155911374@sif>
Subject: Re: [Qemu-devel] [PATCH v2] docs: document our stable process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

Quoting Cornelia Huck (2018-02-12 06:40:08)
> Some pointers on how to get a patch into stable.
> =

> [contains some suggestions by mdroth]
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> RFC/D->v2: added mdroth's suggestions
> ---
>  docs/stable-process.rst | 67 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 docs/stable-process.rst
> =

> diff --git a/docs/stable-process.rst b/docs/stable-process.rst
> new file mode 100644
> index 0000000000..c571204c9f
> --- /dev/null
> +++ b/docs/stable-process.rst
> @@ -0,0 +1,67 @@
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
> +Usually, stable releases are only provided for the last major QEMU
> +release. For example, when QEMU 2.11.0 is released, 2.11.x or 2.11.x.y
> +stable releases are produced only until QEMU 2.12.0 is released, at
> +which the stable process moves to producing 2.12.x/2.12.x.y releases.

"at which point"

Sorry, looks like one of my errors slipped through :)

With that and Eric's suggestions addressed:

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

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
> +  to the patch description. By default, this will send a copy of the  pa=
tch
> +  to ``qemu-stable@nongnu.org`` if you use git send-email, which is where
> +  patches that are stable candidates are tracked by the maintainers.
> +
> +* You can also reply to a patch and put ``qemu-stable@nongnu.org`` on co=
py
> +  directly in your mail client if you think a previously submitted patch
> +  should be considered for a stable release.
> +
> +* If a maintainer judges the patch appropriate for stable later on (or y=
ou
> +  notify them), they will add the same line to the patch, meaning that
> +  the stable maintainers will be on copy on the maintainer's pull reques=
t.
> +
> +* If you judge an already merged patch suitable for stable, send a mail
> +  (preferably as a reply to the most recent patch submission) to
> +  ``qemu-stable@nongnu.org`` along with ``qemu-devel@nongnu.org`` and
> +  appropriate other people (like the patch author or the relevant mainta=
iner)
> +  on copy.
> +
> +Stable release process
> +----------------------
> +
> +When the stable maintainers prepare a new stable release, they will prep=
are
> +a git branch with a release candidate and send the patches out to
> +``qemu-devel@nongnu.org`` for review. If any of your patches are include=
d,
> +please verify that they look fine. You may also nominate other patches t=
hat
> +you think are suitable for inclusion. After review is complete (may invo=
lve
> +more release candidates), a new stable release is made available.
> -- =

> 2.13.6
>=20
