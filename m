Received: from eggs.gnu.org ([2001:4830:134:3::10]:43613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gUn4B-0007Xi-92
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gUn4A-0000Wt-7R
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:23:19 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gUn49-0000Tv-FP
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:23:17 -0500
Received: by mail-wr1-x429.google.com with SMTP id v13so22002219wrw.5
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 22:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181205203737.9011-6-marcandre.lureau@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 6 Dec 2018 14:23:04 +0800
Message-ID: <CAK3tnvLS-jvrS1oma7MWbg4S9rjLjYuAEdXc=EOCx99KLLLZZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 5/7] colo: check chardev can
 switch context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Dec 6, 2018 at 4:38 AM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> COLO uses a worker context (iothread) to drive the chardev. All
> backends are not able to switch the context, let's report an error in
> this case.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>


> ---
>  net/colo-compare.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index a39191d522..9156ab3349 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -957,6 +957,12 @@ static int find_and_check_chardev(Chardev **chr,
>          return 1;
>      }
>
> +    if (!qemu_chr_has_feature(*chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
> +        error_setg(errp, "chardev \"%s\" cannot switch context",
> +                   chr_name);
> +        return 1;
> +    }
> +
>      return 0;
>  }
>
> --
> 2.20.0.rc1
>
>
