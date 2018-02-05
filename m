Received: from eggs.gnu.org ([2001:4830:134:3::10]:46896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eiYqq-0008H3-4D
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 23:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eiYqn-0008VF-1V
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 23:57:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eiYqm-0008Us-P8
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 23:57:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w154vRdN084863
	for <qemu-devel@nongnu.org>; Sun, 4 Feb 2018 23:57:51 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxey22u8f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 23:57:50 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Sun, 4 Feb 2018 23:57:49 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180202063412.22466-3-famz@redhat.com>
References: <20180202063412.22466-1-famz@redhat.com>
	<20180202063412.22466-3-famz@redhat.com>
Date: Sun, 04 Feb 2018 22:57:25 -0600
Message-Id: <151780664539.30594.12268633315246645437@sif>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] README: Document 'git-publish'
 workflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, stefanha@redhat.com

Quoting Fam Zheng (2018-02-02 00:34:12)
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  .gitpublish |  1 +
>  README      | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
> =

> diff --git a/.gitpublish b/.gitpublish
> index 170bd2ed48..7542e878fc 100644
> --- a/.gitpublish
> +++ b/.gitpublish
> @@ -26,6 +26,7 @@ cccmd =3D scripts/get_maintainer.pl --noroles --noroles=
tats --nogit --nogit-fallba
>  base =3D master
>  prefix =3D PATCH
>  to =3D qemu-devel@nongnu.org
> +cc =3D qemu-trivial@nongnu.org

I think you meant to squash this into patch 1?

>  cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --no=
git-fallback 2>/dev/null
> =

>  [gitpublishprofile "block"]
> diff --git a/README b/README
> index b92a07a61a..d1a944ce20 100644
> --- a/README
> +++ b/README
> @@ -56,7 +56,7 @@ The QEMU source code is maintained under the GIT versio=
n control system.
> =

>     git clone git://git.qemu.org/qemu.git
> =

> -When submitting patches, the preferred approach is to use 'git
> +When submitting patches, one common approach is to use 'git
>  format-patch' and/or 'git send-email' to format & send the mail to the
>  qemu-devel@nongnu.org mailing list. All patches submitted must contain
>  a 'Signed-off-by' line from the author. Patches should follow the
> @@ -68,6 +68,34 @@ the QEMU website
>    https://qemu.org/Contribute/SubmitAPatch
>    https://qemu.org/Contribute/TrivialPatches
> =

> +A 'git-profile' utility was created to make above process less
> +cumbersome, and is highly recommended for making regular contributions,
> +or even just for sending consecutive patch series revisions. It also
> +requires a working 'git send-email' setup, and by default doesn't
> +automate everything, so you may want to go through the above steps
> +manually for once.
> +
> +For installation instructions, please go to
> +
> +  https://github.com/stefanha/git-publish
> +
> +The workflow with 'git-publish' is:
> +
> +  $ git checkout master -b my-feature
> +  $ # work on new commits, add your 'Signed-off-by' lines to each
> +  $ git publish
> +
> +Your patch series will be sent and tagged as my-feature-v1 if you need t=
o refer
> +back to it in the future.
> +
> +Sending v2:
> +
> +  $ git checkout my-feature # same topic branch
> +  $ # making changes to the commits (using 'git rebase', for example)
> +  $ git publish
> +
> +Your patch series will be sent with 'v2' tag in the subject and the git =
tip
> +will be tagged as my-feature-v2.
> =

>  Bug reporting
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -- =

> 2.14.3
> =

>=20
