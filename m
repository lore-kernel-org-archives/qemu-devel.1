Received: from eggs.gnu.org ([2001:4830:134:3::10]:33808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1EcL-0007do-By
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1EcI-0006KL-Mg
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:07:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d1EcI-0006JF-Gm
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:07:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 676056330D
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 16:07:33 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170413160952.29918-1-mreitz@redhat.com>
Date: Thu, 20 Apr 2017 18:07:29 +0200
In-Reply-To: <20170413160952.29918-1-mreitz@redhat.com> (Max Reitz's message
	of "Thu, 13 Apr 2017 18:09:52 +0200")
Message-ID: <87vapz83lq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] util/error: Fix leak in error_vprepend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  util/error.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/error.c b/util/error.c
> index 9c40b1f458..020b86b9f0 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -134,6 +134,7 @@ void error_vprepend(Error **errp, const char *fmt, va_list ap)
>      newmsg = g_string_new(NULL);
>      g_string_vprintf(newmsg, fmt, ap);
>      g_string_append(newmsg, (*errp)->msg);
> +    g_free((*errp)->msg);
>      (*errp)->msg = g_string_free(newmsg, 0);
>  }

Applied to error-next, thanks!
