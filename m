Received: from eggs.gnu.org ([2001:4830:134:3::10]:59228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cbGMG-0004rJ-Sg
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cbGMD-0004YA-Pt
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:43:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cbGMD-0004Y0-GM
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:43:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v180hYtk100841
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 19:43:35 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28fr07t4c8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 19:43:31 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 7 Feb 2017 17:43:28 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20170207155956.21573-1-pbonzini@redhat.com>
In-Reply-To: <20170207155956.21573-1-pbonzini@redhat.com>
Date: Tue, 07 Feb 2017 18:43:18 -0600
Message-Id: <148651459898.3978.14777421131469511630@loki>
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Quoting Paolo Bonzini (2017-02-07 09:59:56)
> I have converted all .gz and .bz2 files to .xz on download.qemu.org
> and this patch would change the links in the website.  This would save
> about 5 GB of bandwidth every day (about 20% savings).
> =

> xz should be available for all platforms.  Besides providing better
> compression ratios, decompression of .xz files is about twice as fast

> compared to bzip2.  Compression instead is about 5.5 times slower.

I suppose that's a fair enough trade. :)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  _download/source.html   | 4 ++--
>  _includes/releases.html | 4 ++--

Somewhat related: I think _data/releases.yml needs to be updated as it's
still referencing 2.7.0 instead of 2.7.1. Would one just start updating
that file with each new release, or is there some other process?

>  2 files changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/_download/source.html b/_download/source.html
> index 1ac8f4f..d090a5e 100644
> --- a/_download/source.html
> +++ b/_download/source.html
> @@ -15,8 +15,8 @@
> =

>         {% for release in site.data.releases offset: 0 limit: 1 %}
>         <p>To download and build QEMU {{release.branch}}.{{release.patch}=
}:</p>
> -<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{rel=
ease.patch}}.tar.bz2
> -tar xvjf qemu-{{release.branch}}.{{release.patch}}.tar.bz2
> +<pre>wget http://download.qemu-project.org/qemu-{{release.branch}}.{{rel=
ease.patch}}.tar.xz
> +tar xvJf qemu-{{release.branch}}.{{release.patch}}.tar.xz
>  cd qemu-{{release.branch}}.{{release.patch}}
>  ./configure
>  make
> diff --git a/_includes/releases.html b/_includes/releases.html
> index 2caab8d..226c719 100644
> --- a/_includes/releases.html
> +++ b/_includes/releases.html
> @@ -1,9 +1,9 @@
>  <ul>
>  {% for release in site.data.releases offset: 0 limit: 4 %}
>  <li><strong><a
> -  href=3D"http://download.qemu-project.org/qemu-{{release.branch}}.{{rel=
ease.patch}}.tar.bz2">{{release.branch}}.{{release.patch}}</a></strong>
> +  href=3D"http://download.qemu-project.org/qemu-{{release.branch}}.{{rel=
ease.patch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
>    {{release.date}}<br><a
> -  href=3D"http://download.qemu-project.org/qemu-{{release.branch}}.{{rel=
ease.patch}}.tar.bz2.sig">signature</a> &mdash; <a
> +  href=3D"http://download.qemu-project.org/qemu-{{release.branch}}.{{rel=
ease.patch}}.tar.xz.sig">signature</a> &mdash; <a
>    href=3D"http://wiki.qemu-project.org/ChangeLog/{{release.branch}}">cha=
nges</a></li>
>  {% endfor %}
>  </ul>
> -- =

> 2.9.3
> =

>=20
