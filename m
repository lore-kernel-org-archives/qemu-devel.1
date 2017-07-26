Received: from eggs.gnu.org ([2001:4830:134:3::10]:42978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daKYr-0000gI-P7
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daKYn-00078A-Sy
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1daKYn-00077F-Ju
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:33:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A03274A6EE
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:33:00 +0000 (UTC)
References: <20170726111049.18030-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <759fddfb-8b23-db01-40c8-c4ab2d1756e6@redhat.com>
Date: Wed, 26 Jul 2017 13:32:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170726111049.18030-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] move bug reporting instructions
 from wiki to www
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 26.07.2017 13:10, Paolo Bonzini wrote:
> The bug reporting instructions are pretty static, and it is nicer if bu=
g
> reporters stay within the familiar QEMU web site layout.  Move the page
> to qemu.org.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  _includes/footer.html      |  2 +-
>  contribute.md              |  2 +-
>  contribute/report-a-bug.md | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
>  create mode 100644 contribute/report-a-bug.md
>=20
> diff --git a/_includes/footer.html b/_includes/footer.html
> index cd28480..7a3e8b1 100644
> --- a/_includes/footer.html
> +++ b/_includes/footer.html
> @@ -7,9 +7,9 @@
>  		</ul>
>  		<ul class=3D"style">
>  			<li><a href=3D"/contribute">Contribute</a></li>
> +			<li><a href=3D"/contribute/report-a-bug">Reporting a bug</a></li>
>  			<li><a href=3D"http://wiki.qemu-project.org/Documentation/GettingSt=
artedDevelopers">New contributors</a></li>
>  			<li><a href=3D"http://wiki.qemu-project.org/Contribute/SubmitAPatch=
">Submitting a patch</a></li>
> -			<li><a href=3D"http://wiki.qemu-project.org/Contribute/ReportABug">=
Reporting a bug</a></li>
>  			<li><a href=3D"http://wiki.qemu-project.org/Contribute/FAQ">Contrib=
utor FAQ</a></li>
>  		</ul>
>  		<ul class=3D"style">
> diff --git a/contribute.md b/contribute.md
> index fb2238d..e052654 100644
> --- a/contribute.md
> +++ b/contribute.md
> @@ -3,7 +3,7 @@ title: Contribute to QEMU!
>  permalink: /contribute/
>  ---
> =20
> -* Report a bug: https://bugs.launchpad.net/qemu/<br>[How to report a b=
ug](http://wiki.qemu-project.org/Contribute/ReportABug)
> +* Report a bug: https://bugs.launchpad.net/qemu/<br>[How to report a b=
ug](report-a-bug/)

While you're at it, could you turn the launchpad URL into a clickable
URL, too? It is currently rendered as plain text.

>  * Clone the git repository: <br>`git clone git://git.qemu-project.org/=
qemu.git`
> =20
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> new file mode 100644
> index 0000000..f0fd67b
> --- /dev/null
> +++ b/contribute/report-a-bug.md
> @@ -0,0 +1,19 @@
> +---
> +title: Reporting a bug
> +permalink: /contribute/report-a-bug
> +---
> +
> +Bugs can be filed at our [https://bugs.launchpad.net/qemu/ bug tracker=
].
> +
> +When submitting a bug report, please try to do the following:
> +
> +* Make sure you're reporting the bug against the [latest release](/dow=
nload/#source).  If possible, please try to reproduce with the latest dev=
elopment tree too.

Please add also (since it still happens way too often):

* Please avoid to report bugs that you've found in the QEMU version
  that ships with your Linux distribution. If you've got a problem with
  the QEMU from your Linux distribution, use the bug tracker from your
  distro instead.

* Include the QEMU release version or the git commit hash into the
  description, so that it is later still clear in which version you
  have found the bug.

> +* Include the full command line used to launch the QEMU guest.
> +
> +* Reproduce the problem directly with a QEMU command-line.  Avoid fron=
tends and management stacks, to ensure that the bug is in QEMU itself and=
 not in a frontend.
> +
> +* Include as information about the guest (operating system, version, 3=
2/64-bit).
> +
> +* Do not contribute patches on the bug tracker; send patches to the ma=
iling list. Follow QEMU's [guidelines about submitting patches](http://wi=
ki.qemu.org/Contribute/SubmitAPatch).

Please also add something like this:

* Do NOT report security issues (or other bugs, too) as "private" bugs
  in the bug tracker. Non-public bugs tend to be ignored. See
  http://wiki.qemu.org/SecurityProcess for information about how to
  report security issues in a non-public way instead.

* If you encountered a problem with KVM in the kernel, use the kernel
  bug tracker instead (see http://www.linux-kvm.org/page/Bugs for
  details).

 Thanks,
  Thomas
