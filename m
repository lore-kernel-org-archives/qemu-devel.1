Received: from eggs.gnu.org ([2001:4830:134:3::10]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyECY-000063-PG
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyECT-0005yK-Tq
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:04:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cyECT-0005xX-P0
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AFBB6AADA
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 09:04:28 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170406154107.9178-1-dgilbert@redhat.com>
Date: Wed, 12 Apr 2017 11:04:26 +0200
In-Reply-To: <20170406154107.9178-1-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Thu, 6 Apr 2017 16:41:07 +0100")
Message-ID: <87lgr6m1yd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tests/check-qdict: Fix missing brackets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Gcc 7 (on Fedora 26) spotted odd use of integers instead of a
> boolean; it's got a point.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tests/check-qdict.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index 81162ee572..6f3fbcf9c1 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -559,7 +559,7 @@ static void qdict_join_test(void)
>          g_assert(qdict_size(dict1) == 2);
>          g_assert(qdict_size(dict2) == !overwrite);
>  
> -        g_assert(qdict_get_int(dict1, "foo") == overwrite ? 84 : 42);
> +        g_assert(qdict_get_int(dict1, "foo") == (overwrite ? 84 : 42));
>          g_assert(qdict_get_int(dict1, "bar") == 23);
>  
>          if (!overwrite) {

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Applied to qapi-next, thanks!
