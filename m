Received: from eggs.gnu.org ([2001:4830:134:3::10]:54817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHsT8-0006uN-2l
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gHsT2-0003Fl-EA
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:31:39 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gHsSw-0002Er-EH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:31:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id w7-v6so4520689wmc.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 08:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181029145709.26359-1-marcandre.lureau@redhat.com>
	<87d0rqqh0g.fsf@dusky.pond.sub.org>
In-Reply-To: <87d0rqqh0g.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 31 Oct 2018 19:31:12 +0400
Message-ID: <CAJ+F1CL3uL-TGqAg8-WcHTNOhvPFZzOdQDS4Pp3VfWN3DDd01A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: add qmp/missing-any-arg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi
On Wed, Oct 31, 2018 at 7:22 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > test_qmp_missing_any_arg() is about a bug in infrastructure used by
> > the QMP core, fixed in commit c489780203.  We covered the bug in
> > infrastructure unit tests (commit bce3035a44).  I wrote that test
> > earlier, to cover QMP level as well, the test could go into qmp-test.
>
> The last sentence is confusing.  What about replacing it by "Let's test
> it at the QMP level as well"?

sure, I assume you do that on commit thanks

>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/qmp-test.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> > index 6c419f6023..7517be4654 100644
> > --- a/tests/qmp-test.c
> > +++ b/tests/qmp-test.c
> > @@ -318,6 +318,19 @@ static void test_qmp_preconfig(void)
> >      qtest_quit(qs);
> >  }
> >
> > +static void test_qmp_missing_any_arg(void)
> > +{
> > +    QTestState *qts;
> > +    QDict *resp;
> > +
> > +    qts =3D qtest_init(common_args);
> > +    resp =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
> > +                     " { 'path': '/machine', 'property': 'rtc-time' } =
}");
> > +    g_assert_nonnull(resp);
> > +    qmp_assert_error_class(resp, "GenericError");
> > +    qtest_quit(qts);
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >      g_test_init(&argc, &argv, NULL);
> > @@ -325,6 +338,7 @@ int main(int argc, char *argv[])
> >      qtest_add_func("qmp/protocol", test_qmp_protocol);
> >      qtest_add_func("qmp/oob", test_qmp_oob);
> >      qtest_add_func("qmp/preconfig", test_qmp_preconfig);
> > +    qtest_add_func("qmp/missing-any-arg", test_qmp_missing_any_arg);
> >
> >      return g_test_run();
> >  }
>
> Patch looks good to me.
>


--=20
Marc-Andr=C3=A9 Lureau
