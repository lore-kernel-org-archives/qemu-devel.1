Received: from eggs.gnu.org ([2001:4830:134:3::10]:44626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1em104-0007sc-7h
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1em101-0007BP-2w
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:37:44 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1em100-0007BJ-TX
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 12:37:41 -0500
Received: by mail-qk0-x244.google.com with SMTP id h129so7675031qke.8
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:37:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180213173429.19501-1-stefanha@redhat.com>
	<20180213173429.19501-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39bb633f-55ee-d8bd-d733-e819a0d01fde@amsat.org>
Date: Wed, 14 Feb 2018 14:37:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180213173429.19501-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 02/13/2018 02:34 PM, Stefan Hajnoczi wrote:
> From: Fam Zheng <famz@redhat.com>
> 
> git-publish [1] is a convenient tool to send patches and has been
> popular among QEMU developers.  Recently it has been made available in
> Fedora official repo thanks to Stefan's work.

Also Debian:
https://packages.debian.org/sid/git-publish

> 
> One nice feature of the tool is a per-project configuration with
> profiles, especially in which the cccmd option is a handy method to
> create the Cc list.
> 
> [1]: https://github.com/stefanha/git-publish
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-id: 20180205054725.25634-2-famz@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  .gitpublish | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 .gitpublish
> 
> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000000..ed48f6e52c
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,58 @@
> +#
> +# Common git-publish profiles that can be used to send patches to QEMU upstream.
> +#
> +# See https://github.com/stefanha/git-publish for more information
> +#
> +[gitpublishprofile "default"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "rfc"]
> +base = master
> +prefix = RFC PATCH
> +to = qemu-devel@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "stable"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-stable@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "trivial"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-trivial@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "block"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-block@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "arm"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-arm@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "s390"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-s390@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "ppc"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-ppc@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> 
