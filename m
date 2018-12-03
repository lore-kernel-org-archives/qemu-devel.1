Received: from eggs.gnu.org ([2001:4830:134:3::10]:39922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTtgR-0002lQ-DP
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gTtgN-0000UR-SJ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:15:07 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gTtgN-0000Qr-IT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 14:15:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id f81so4459133wmd.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 11:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20181203164105.29858-1-berrange@redhat.com>
In-Reply-To: <20181203164105.29858-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Dec 2018 23:14:48 +0400
Message-ID: <CAJ+F1CLr=JgtRqc6rC6N2Xe+YOchNkzryV4NB+sU-BWAUzPOsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Import historical documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

Hi

On Mon, Dec 3, 2018 at 9:23 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> The files included are taken from formal builds of previous versions
> of QEMU, going back to 2.0.0
>
>   - qemu-doc.html
>   - qemu-qmp-ref.html
>   - qemu-ga-ref.html
>
> To import them all content outside of <body></body> is stripped and
> replaced by a trivial jekyll header. This causes the rendered docs
> to get consistent styling and navbar heading.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Nice! Except the minor link issue of 2.11,

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>
> This patch shows what it would be like if we just copied the
> pre-rendered QEMU docs into qemu-web for each major release....
>
> ...it would be large. 2.0.0 was only 300 KB in size, but latest
> 3.0.0 release has 1.3 MB of docs. So we'd be adding about 4 MB
> of docs to qemu-web each year if we committed them.
>
> This feels undesirable as a strategy.

Isn't git storage/packing smart enough?

$ du -sch reference/*/*.html
8.9M    total
$ du -sh .git
1.5M    .git

It's doing a good job.

>
> I trimmed this mail to cut out the .html files to avoid spamming
> the list. If you want to see the full commit it is here:
>
>    https://github.com/berrange/qemu-web/commit/c5f6d0f8664d7edd016f469f07=
09caec8360f783
>
> At least in terms of the end result for users, I think it is
> positive.
>
> Other ideas
>
>  1. Upload built docs to a lookaside directory on the download
>     site when making a release, then have a jekyll plugin to
>     pull them in. Extra work for the person making releases
>     principally.
>
>  2. Have a jekyll plugin that uses docker env to build each
>     release docs from pristine tarballs. Would need caching
>     to avoid burning CPU cycles in each web update. Reliably
>     building older QEMU versions gets increasingly troublesome
>
>  assets/css/style.css               |    14 +
>  documentation.md                   |    78 +-
>  reference/2.0.0/qemu-doc.html      |  7323 +++++++++
>  reference/2.1.0/qemu-doc.html      |  7567 ++++++++++
>  reference/2.10.0/qemu-doc.html     | 10026 +++++++++++++
>  reference/2.10.0/qemu-ga-ref.html  |  1947 +++
>  reference/2.10.0/qemu-qmp-ref.html | 18766 +++++++++++++++++++++++
>  reference/2.11.0/qemu-doc.html     | 10128 +++++++++++++
>  reference/2.11.0/qemu-ga-ref.html  |  1993 +++
>  reference/2.11.0/qemu-qmp-ref.html | 19171 ++++++++++++++++++++++++
>  reference/2.12.0/qemu-doc.html     | 10555 +++++++++++++
>  reference/2.12.0/qemu-ga-ref.html  |  1931 +++
>  reference/2.12.0/qemu-qmp-ref.html | 20616 +++++++++++++++++++++++++
>  reference/2.2.0/qemu-doc.html      |  7622 ++++++++++
>  reference/2.3.0/qemu-doc.html      |  7692 ++++++++++
>  reference/2.4.0/qemu-doc.html      |  7812 ++++++++++
>  reference/2.5.0/qemu-doc.html      |  8300 +++++++++++
>  reference/2.6.0/qemu-doc.html      |  8647 +++++++++++
>  reference/2.7.0/qemu-doc.html      |  8771 +++++++++++
>  reference/2.8.0/qemu-doc.html      |  9097 ++++++++++++
>  reference/2.9.0/qemu-doc.html      |  9209 ++++++++++++
>  reference/2.9.0/qemu-ga-ref.html   |  1693 +++
>  reference/2.9.0/qemu-qmp-ref.html  | 18082 ++++++++++++++++++++++
>  reference/3.0.0/qemu-doc.html      | 10810 ++++++++++++++
>  reference/3.0.0/qemu-ga-ref.html   |  1939 +++
>  reference/3.0.0/qemu-qmp-ref.html  | 21458 +++++++++++++++++++++++++++
>  26 files changed, 231246 insertions(+), 1 deletion(-)
>  create mode 100644 reference/2.0.0/qemu-doc.html
>  create mode 100644 reference/2.1.0/qemu-doc.html
>  create mode 100644 reference/2.10.0/qemu-doc.html
>  create mode 100644 reference/2.10.0/qemu-ga-ref.html
>  create mode 100644 reference/2.10.0/qemu-qmp-ref.html
>  create mode 100644 reference/2.11.0/qemu-doc.html
>  create mode 100644 reference/2.11.0/qemu-ga-ref.html
>  create mode 100644 reference/2.11.0/qemu-qmp-ref.html
>  create mode 100644 reference/2.12.0/qemu-doc.html
>  create mode 100644 reference/2.12.0/qemu-ga-ref.html
>  create mode 100644 reference/2.12.0/qemu-qmp-ref.html
>  create mode 100644 reference/2.2.0/qemu-doc.html
>  create mode 100644 reference/2.3.0/qemu-doc.html
>  create mode 100644 reference/2.4.0/qemu-doc.html
>  create mode 100644 reference/2.5.0/qemu-doc.html
>  create mode 100644 reference/2.6.0/qemu-doc.html
>  create mode 100644 reference/2.7.0/qemu-doc.html
>  create mode 100644 reference/2.8.0/qemu-doc.html
>  create mode 100644 reference/2.9.0/qemu-doc.html
>  create mode 100644 reference/2.9.0/qemu-ga-ref.html
>  create mode 100644 reference/2.9.0/qemu-qmp-ref.html
>  create mode 100644 reference/3.0.0/qemu-doc.html
>  create mode 100644 reference/3.0.0/qemu-ga-ref.html
>  create mode 100644 reference/3.0.0/qemu-qmp-ref.html
> diff --git a/assets/css/style.css b/assets/css/style.css
> index b828887..b1d7339 100644
> --- a/assets/css/style.css
> +++ b/assets/css/style.css
> @@ -590,3 +590,17 @@
>         {
>                 margin-top: 1.5em;
>         }
> +
> +       #refdoc  {
> +           border-spacing: 4px;
> +       }
> +       #refdoc td {
> +           background: rgb(240,240,240);
> +           padding: 6px;
> +           margin: 6px;
> +       }
> +       #refdoc th {
> +           background: rgb(220,220,220);
> +           padding: 6px;
> +           text-align: right;
> +       }
> diff --git a/documentation.md b/documentation.md
> index f4ef9f4..571259d 100644
> --- a/documentation.md
> +++ b/documentation.md
> @@ -3,7 +3,11 @@ title: QEMU documentation
>  permalink: /documentation/
>  ---
>
> -The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be re=
ad online, courtesy of Stefan Weil.
> +## Reference guides
> +
> +The table below provides copies of the formal documentation associated
> +with each release of QEMU.
> +
>  More documentation is found in the <a href=3D"https://git.qemu.org/?p=3D=
qemu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
>  directory of the QEMU git tree.
>
> @@ -11,3 +15,75 @@ The [QEMU wiki](https://wiki.qemu.org) contains more
>  [user documentation](https://wiki.qemu.org/Category:User_documentation) =
and
>  [developer documentation](https://wiki.qemu.org/Category:Developer_docum=
entation)
>  that has not been integrated into the QEMU git tree.
> +
> +<table id=3D"refdoc">
> +<tbody>
> +<tr>
> +<th>3.0.0</th>
> +<td><a href=3D"/reference/3.0.0/qemu-doc.html">User guide</a></td>
> +<td><a href=3D"/reference/3.0.0/qemu-qmp-ref.html">QMP ref</a></td>
> +<td><a href=3D"/reference/3.0.0/qemu-ga-ref.html">GA ref</a></td>
> +</tr>
> +<tr>
> +<th>2.12.0</th>
> +<td><a href=3D"/reference/2.12.0/qemu-doc.html">User guide</a></td>
> +<td><a href=3D"/reference/2.12.0/qemu-qmp-ref.html">QMP ref</a></td>
> +<td><a href=3D"/reference/2.12.0/qemu-ga-ref.html">GA ref</a></td>
> +</tr>
> +<tr>
> +<th>2.11.0</th>
> +<td><a href=3D"/reference/2.11.0/qemu-doc.html">User guide</a></td>
> +<td><a href=3D"/reference/2.11.0/qemu-qmp-ref.html">QMP ref</a></td>
> +<td><a href=3D"/reference/2.11.0/qemu-ga-ref.html">GA ref</a></td>
> +</tr>
> +<tr>
> +<th>2.10.0</th>
> +<td><a href=3D"/reference/2.10.0/qemu-doc.html">User guide</a></td>
> +<td><a href=3D"/reference/2.10.0/qemu-qmp-ref.html">QMP ref</a></td>
> +<td><a href=3D"/reference/2.10.0/qemu-ga-ref.html">GA ref</a></td>
> +</tr>
> +<tr>
> +<th>2.9.0</th>
> +<td><a href=3D"/reference/2.9.0/qemu-doc.html">User guide</a></td>
> +<td><a href=3D"/reference/2.9.0/qemu-qmp-ref.html">QMP ref</a></td>
> +<td><a href=3D"/reference/2.9.0/qemu-ga-ref.html">GA ref</a></td>
> +</tr>
> +<tr>
> +<th>2.8.0</th>
> +<td><a href=3D"/reference/2.11.0/qemu-doc.html">User guide</a></td>

2.11 ?

> +</tr>
> +<tr>
> +<th>2.7.0</th>
> +<td><a href=3D"/reference/2.7.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +<tr>
> +<th>2.6.0</th>
> +<td><a href=3D"/reference/2.6.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +<tr>
> +<th>2.5.0</th>
> +<td><a href=3D"/reference/2.5.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +<tr>
> +<th>2.4.0</th>
> +<td><a href=3D"/reference/2.4.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +<tr>
> +<th>2.3.0</th>
> +<td><a href=3D"/reference/2.3.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +<tr>
> +<th>2.2.0</th>
> +<td><a href=3D"/reference/2.2.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +<tr>
> +<th>2.1.0</th>
> +<td><a href=3D"/reference/2.1.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +<tr>
> +<th>2.0.0</th>
> +<td><a href=3D"/reference/2.0.0/qemu-doc.html">User guide</a></td>
> +</tr>
> +</tbody>
> +</table>
> +
> diff --git a/reference/3.0.0/qemu-doc.html b/reference/3.0.0/qemu-doc.htm=
l
> new file mode 100644
> index 0000000..e7abe8f
> --- /dev/null
> +++ b/reference/3.0.0/qemu-doc.html
> @@ -0,0 +1,18 @@
> +---
> +permalink: reference/3.0.0/qemu-doc.html
> +---
> +<h1 class=3D"settitle" align=3D"center">QEMU version 3.0.0 User Document=
ation</h1>
> +
> +
> +
> +
> +
> +<a name=3D"Top"></a>
> +<a name=3D"SEC_Top"></a>
> +
> +
> +<a name=3D"SEC_Contents"></a>
> +<h2 class=3D"contents-heading">Table of Contents</h2>
> +
> +<div class=3D"contents">
> +
>
> [...snip...]
>


--=20
Marc-Andr=C3=A9 Lureau
