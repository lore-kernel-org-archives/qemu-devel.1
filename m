Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds4UX-0001t5-WB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds4UT-0000zK-Up
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ds4UT-0000yF-Pv
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:01:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3967883AC
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:01:52 +0000 (UTC)
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
	<1505295366-25295-4-git-send-email-peterx@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <124e3483-9b87-8ffe-0283-3c7e9dc29eb7@redhat.com>
Date: Wed, 13 Sep 2017 12:01:42 +0200
MIME-Version: 1.0
In-Reply-To: <1505295366-25295-4-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] libqtest: add qmp_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13.09.2017 11:36, Peter Xu wrote:
> Since we have qmp_device_del(), pair them up.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/libqtest.c | 15 +++++++++++++++
>  tests/libqtest.h |  9 +++++++++
>  2 files changed, 24 insertions(+)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index a34d8c4..c7da962 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -925,6 +925,21 @@ QDict *qmp(const char *fmt, ...)
>      return response;
>  }
> =20
> +void qmp_device_add(const char *args)

I think it would be nicer to have a function with variable args here, so
that the callers do not have to do the g_strdup_printf() dance all over
the place. See e.g. my qtest_hot_plug_device() function in my patch
here: http://patchwork.ozlabs.org/patch/801487/

If you fix that, I don't mind if we finally go with my patch or with
yours... If we decide to go with my patch, it would be nice to get some
Reviewed-bys for it. I think I could then send a PULL request for it,
since I've got some other test related patches in my queue and we do not
have a real maintainer for the tests directory...

 Thomas
