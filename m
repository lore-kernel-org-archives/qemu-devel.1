Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B0C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA3C206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 16:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA3C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGQcJ-0006Xb-6z
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 12:07:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGQX0-0002gr-Py
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGQWy-00027k-KL
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGQWy-00025G-5M
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52C8B88318;
	Tue, 16 Apr 2019 16:01:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 815345C224;
	Tue, 16 Apr 2019 16:01:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 175A91138648; Tue, 16 Apr 2019 18:01:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190415141547.15444-1-berrange@redhat.com>
	<87a7gq75l6.fsf@dusky.pond.sub.org>
	<20190416090358.GF31311@redhat.com>
Date: Tue, 16 Apr 2019 18:01:46 +0200
In-Reply-To: <20190416090358.GF31311@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 16 Apr 2019 10:03:58 +0100")
Message-ID: <87zhoq3pn9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 16 Apr 2019 16:01:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416160146.z6-crlSWbBT9hR0GjDXPCUWlmzCaJbn8JjE4tmRDGAo@z>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Apr 16, 2019 at 09:49:09AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Localization is not a feature whose impact is limited to the UI
>> > frontends. Other parts of QEMU rely in localization.

Typo: rely on

>> Typically by accident :)
>>=20
>> >                                                      In particular the
>> > USB MTP driver needs to be able to convert filenames from the locale
>> > specified character set into UTF-16 / UCS-2 encoded wide characters.
>>=20
>> Oookay.  I guess that makes some sense.
>>=20
>> > setlocale() is only set from two of the UI frontends though, and worse,
>> > there is inconsistent behaviour with GTK setting LC_CTYPE to C.UTF-8,
>> > while ncurses honours whatever is set in the user's environment.
>> >
>> > This causes the USP MTP driver to behave differently depending on which
>> > UI frontend is activated.
>> >
>> > Furthermore, the curses settings are dangerous because LC_CTYPE will a=
ffect
>> > the is{upper,lower,alnum} functions which much QEMU code assumes to ha=
ve
>> > C locale sorting behaviour. This also breaks QMP if the env requests a
>> > non-UTF-8 locale, since QMP is defined to use UTF-8 encoding for JSON.
>>=20
>> Can you elaborate on how QMP breaks with a non-UTF-8 locale?  Ah, you do
>> in the comment you add to vl.c.
>>=20
>> > This problematic curses code was introduced in:
>> >
>> >   commit 2f8b7cd587558944532f587abb5203ce54badba9
>> >   Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
>> >   Date:   Mon Mar 11 14:51:27 2019 +0100
>> >
>> >     curses: add option to specify VGA font encoding
>> >
>> > This patch moves the GTK frontend setlocale() handling into the main()
>> > method. This ensures QMP and other QEMU code has a predictable C.UTF-8.
>> >
>> > Eventually QEMU should set LC_ALL, honouring the full user environment,
>> > but this needs various cleanups in QEMU code first.
>>=20
>> Eventually, we'll all be dead.
>>=20
>> >                                                     Hardcoding LC_CTYPE
>> > to C.UTF-8 is a partial regression vs the above curses commit, since it
>> > will break the curses wide character handling for non-UTF-8 locales but
>> > this is unavoidable until QEMU is cleaned up to cope with non-UTF-8
>> > locales fully.
>> >
>> > Setting of LC_MESSAGES is left in the GTK code since only the GTK
>> > frontend is using translation of strings. This lets us avoid the
>> > platform portability problem where LC_MESSAGES is not provided by
>> > locale.h on MinGW. GTK pulls it in indirectly from libintl.h via
>> > gi18n.h header, but we don't want to pull that into the global
>> > QEMU namespace.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >
>> > Changed in v2:
>> >
>> >  - Leave LC_MESSAGES setting in gtk code to avoid platform
>> >    portability problems.
>> >
>> >  ui/curses.c |  2 --
>> >  ui/gtk.c    | 32 +++++++++++---------------------
>> >  vl.c        | 40 ++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 51 insertions(+), 23 deletions(-)
>> >
>> > diff --git a/ui/curses.c b/ui/curses.c
>> > index cc6d6da684..403cd57913 100644
>> > --- a/ui/curses.c
>> > +++ b/ui/curses.c
>> > @@ -27,7 +27,6 @@
>> >  #include <sys/ioctl.h>
>> >  #include <termios.h>
>> >  #endif
>> > -#include <locale.h>
>> >  #include <wchar.h>
>> >  #include <langinfo.h>
>> >  #include <iconv.h>
>> > @@ -716,7 +715,6 @@ static void curses_display_init(DisplayState *ds, =
DisplayOptions *opts)
>> >      }
>> >  #endif
>> >=20=20
>> > -    setlocale(LC_CTYPE, "");
>> >      if (opts->u.curses.charset) {
>> >          font_charset =3D opts->u.curses.charset;
>> >      }
>> > diff --git a/ui/gtk.c b/ui/gtk.c
>> > index e96e15435a..e6a41c79ab 100644
>> > --- a/ui/gtk.c
>> > +++ b/ui/gtk.c
>> > @@ -2208,12 +2208,12 @@ static void gtk_display_init(DisplayState *ds,=
 DisplayOptions *opts)
>> >=20=20
>> >      s->free_scale =3D FALSE;
>> >=20=20
>> > -    /* Mostly LC_MESSAGES only. See early_gtk_display_init() for deta=
ils. For
>> > -     * LC_CTYPE, we need to make sure that non-ASCII characters are c=
onsidered
>> > -     * printable, but without changing any of the character classes t=
o make
>> > -     * sure that we don't accidentally break implicit assumptions.  */
>> > +    /*
>> > +     * See comment in main() for why it has only setup LC_CTYPE,
>> > +     * as opposed to LC_ALL. Given that we need to enable
>> > +     * LC_MESSAGES too for menu translations.
>> > +     */
>> >      setlocale(LC_MESSAGES, "");
>> > -    setlocale(LC_CTYPE, "C.UTF-8");
>> >      bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
>> >      textdomain("qemu");
>> >=20=20
>> > @@ -2262,22 +2262,12 @@ static void gtk_display_init(DisplayState *ds,=
 DisplayOptions *opts)
>> >=20=20
>> >  static void early_gtk_display_init(DisplayOptions *opts)
>> >  {
>> > -    /* The QEMU code relies on the assumption that it's always run in
>> > -     * the C locale. Therefore it is not prepared to deal with
>> > -     * operations that produce different results depending on the
>> > -     * locale, such as printf's formatting of decimal numbers, and
>> > -     * possibly others.
>> > -     *
>> > -     * Since GTK+ calls setlocale() by default -importing the locale
>> > -     * settings from the environment- we must prevent it from doing so
>> > -     * using gtk_disable_setlocale().
>> > -     *
>> > -     * QEMU's GTK+ UI, however, _does_ have translations for some of
>> > -     * the menu items. As a trade-off between a functionally correct
>> > -     * QEMU and a fully internationalized UI we support importing
>> > -     * LC_MESSAGES from the environment (see the setlocale() call
>> > -     * earlier in this file). This allows us to display translated
>> > -     * messages leaving everything else untouched.
>> > +    /*
>> > +     * GTK calls setlocale() by default, importing the locale
>> > +     * settings from the environment. QEMU's main() method will
>> > +     * have set LC_MESSAGES and LC_CTYPE to allow GTK to display
>> > +     * translated messages, including use of wide characters. We
>> > +     * must not allow GTK to change other aspects of the locale.
>> >       */
>> >      gtk_disable_setlocale();
>> >      gtkinit =3D gtk_init_check(NULL, NULL);
>> > diff --git a/vl.c b/vl.c
>> > index c696ad2a13..87a55cddb3 100644
>> > --- a/vl.c
>> > +++ b/vl.c
>> > @@ -49,6 +49,7 @@ int main(int argc, char **argv)
>> >  #define main qemu_main
>> >  #endif /* CONFIG_COCOA */
>> >=20=20
>> > +#include <locale.h>
>> >=20=20
>> >  #include "qemu/error-report.h"
>> >  #include "qemu/sockets.h"
>> > @@ -3022,6 +3023,45 @@ int main(int argc, char **argv, char **envp)
>> >      char *dir, **dirs;
>> >      BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_=
queue);
>> >=20=20
>> > +    /*
>> > +     * Ideally we would set LC_ALL, but QEMU currently isn't able to =
cope
>> > +     * with arbitrary localization settings. In particular there are =
two
>> > +     * known problems
>> > +     *
>> > +     *   - The QMP monitor needs to use the C locale rules for numeric
>> > +     *     formatting. This would need a double/int -> string formatt=
er
>> > +     *     that is locale independant.
>>=20
>> Aha.
>>=20
>> Reminds me of the story of a FORTRAN compiler that rejected only
>> far-away customers' programs...
>>=20
>> > +     *
>> > +     *   - The QMP monitor needs to encode all data as UTF-8. This ne=
eds
>> > +     *     to be updated to use iconv(3) to explicitly convert the cu=
rrent
>> > +     *     locale's charset into utf-8
>>=20
>> Really?  What locale-dependent text gets sent to QMP?
>
> The main thing I can see would be filenames.
>
> Though having said it is UTF-8 on looking more closely I think QEMU is
> probably 8-bit clean in its handling, so will just be blindly passing
> whatever filename string it get from libvirt straight on to the kernel
> with no interpretation.

Sounds good to me.

> Libvirt has enabled UTF-8 validation in its JSON library when encoding
> data it sends to QEMU, so any data libvirt is sending will be a valid
> UTF-8 byte sequence at least. Libvirt doesn't axctually do any charset
> conversion though, so if libvirt runs in a non-UTF8 locale it will
> likely trip over this UTF-8 validation.

QMP input must be encoded in UTF-8.  Converting from other encodings to
UTF-8 is the QMP client's problem.

The more interesting direction is the one I inquired about: QMP output.
If locale-dependent text gets sent to QMP, converting it to UTF-8 is
QEMU's problem.

On closer look, anything but JSON string contents is plain ASCII by
construction.  JSON string contents gets assembled in to_json() case
QTYPE_QSTRING.  It expects QString to use UTF-8[*].  You can have any
locale as long as it uses ASCII or UTF-8.

>> > +     *
>> > +     *   - Lots of codes uses is{upper,lower,alnum,...} functions, ex=
pecting
>> > +     *     C locale sorting behaviour. Most QEMU usage should likely =
be
>> > +     *     changed to g_ascii_is{upper,lower,alnum...} to match code
>> > +     *     assumptions, without being broken by locale settnigs.
>> > +     *
>> > +     * We do still have two requirements
>> > +     *
>> > +     *   - Ability to correct display translated text according to the
>> > +     *     user's locale
>> > +     *
>> > +     *   - Ability to handle multibyte characters, ideally according =
to
>> > +     *     user's locale specified character set. This affects ability
>> > +     *     of usb-mtp to correctly convert filenames to UCS16 and cur=
ses
>> > +     *     & GTK frontends wide character display.
>> > +     *
>> > +     * The second requirement would need LC_CTYPE to be honoured, but
>> > +     * this conflicts with the 2nd & 3rd problems listed earlier. For
>> > +     * now we make a tradeoff, trying to set an explicit UTF-8 localee
>> > +     *
>> > +     * Note we can't set LC_MESSAGES here, since mingw doesn't define
>> > +     * this constant in locale.h Fortunately we only need it for the
>> > +     * GTK frontend and that uses gi18n.h which pulls in a definition
>> > +     * of LC_MESSAGES.
>> > +     */
>> > +    setlocale(LC_CTYPE, "C.UTF-8");
>> > +
>> >      module_call_init(MODULE_INIT_TRACE);
>> >=20=20
>> >      qemu_init_cpu_list();
>>=20
>> We should've stayed out of the GUI business.
>
> This isn't only a GUI problem as above, it affects USB MTP.

I believe setlocale() in QEMU is basically wrong.  Finding all the
places that rely on the current locale when they shouldn't and
converting them to locale-independent alternatives is a huge amount of
work.  Even if we managed to complete it, it wouldn't stay complete.

Instead, find the places that have reason to use the locale, and fix
them to uselocale().



[*] Actually modified UTF-8, but I don't think we rely on the "modified"
part.

