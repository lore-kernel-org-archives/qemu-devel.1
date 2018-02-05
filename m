Received: from eggs.gnu.org ([2001:4830:134:3::10]:57709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eidhL-0004qx-NN
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eidhK-00071E-FT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:08:27 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:51451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eidhK-00070T-8e
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 05:08:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id r71so25042994wmd.1
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 02:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205054725.25634-3-famz@redhat.com>
References: <20180205054725.25634-1-famz@redhat.com>
	<20180205054725.25634-3-famz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 5 Feb 2018 11:08:24 +0100
Message-ID: <CAJ+F1CKUWStNiz2rO94QquC=yDFxNEeaemJBh-jN4Zci2sZ+ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] README: Document 'git-publish'
 workflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Feb 5, 2018 at 6:47 AM, Fam Zheng <famz@redhat.com> wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>

Looks good, thanks,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  README | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/README b/README
> index b92a07a61a..d1a944ce20 100644
> --- a/README
> +++ b/README
> @@ -56,7 +56,7 @@ The QEMU source code is maintained under the GIT versio=
n control system.
>
>     git clone git://git.qemu.org/qemu.git
>
> -When submitting patches, the preferred approach is to use 'git
> +When submitting patches, one common approach is to use 'git
>  format-patch' and/or 'git send-email' to format & send the mail to the
>  qemu-devel@nongnu.org mailing list. All patches submitted must contain
>  a 'Signed-off-by' line from the author. Patches should follow the
> @@ -68,6 +68,34 @@ the QEMU website
>    https://qemu.org/Contribute/SubmitAPatch
>    https://qemu.org/Contribute/TrivialPatches
>
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
>
>  Bug reporting
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.14.3
>



--=20
Marc-Andr=C3=A9 Lureau
