Received: from eggs.gnu.org ([209.51.188.92]:60569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1h3VTH-0003dz-1K
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1h3VKe-0001xG-GA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:31:49 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:38596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1h3VKe-0001wx-51
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 20:31:48 -0400
Received: by mail-ot1-x330.google.com with SMTP id m1so944145otf.5
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 17:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190310113408.59912-1-liq3ea@163.com>
	<43275bae-952c-c044-0525-5e6592dbe58d@redhat.com>
In-Reply-To: <43275bae-952c-c044-0525-5e6592dbe58d@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 12 Mar 2019 08:31:10 +0800
Message-ID: <CAKXe6SJiQ7uOq+cmfRLRocnebmqXhFBqGfCNvbR1Ugj3fYanug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: test-bdrv-graph-mod: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, vsementsov@virtuozzo.com, kwolf@redhat.com, Qemu Developers <qemu-devel@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B43=E6=
=9C=8810=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:34=E5=86=99=E9=81=
=93=EF=BC=9A

> On 3/10/19 12:34 PM, Li Qiang wrote:
> > Fixes: 2dbfadf
>
>   ^ Please keep tags together (with Signed-off-by, ...)
>
> > Spotted by ASAN when 'make check'.
>
> I'm not native English speaker but I'd say:
>
>

Thanks your advice.
Hope the maintainer will do this minor adjustment.

Thanks,
Li Qiang




> Spotted by ASAN [with] 'make check'.
>
> or
>
> Spotted by ASAN [while running] 'make check'.
>
> Here goes:
>
> "Fixes: 2dbfadf"
>
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/test-bdrv-graph-mod.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
> > index 458dfa6661..8bf0fe735d 100644
> > --- a/tests/test-bdrv-graph-mod.c
> > +++ b/tests/test-bdrv-graph-mod.c
> > @@ -117,6 +117,7 @@ static void test_update_perm_tree(void)
> >
> >      bdrv_unref(bs);
> >      blk_unref(root);
> > +    error_free(local_err);
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> >  }
> >
> >  /*
> >
>
