Received: from eggs.gnu.org ([2001:4830:134:3::10]:46659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceMpl-000305-Cg
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceMpk-00086K-Ce
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:14:57 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceMpk-000865-5r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:14:56 -0500
Received: by mail-wm0-x236.google.com with SMTP id c85so67455730wmi.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:14:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKoqiCg6ediSWHhdUQ92hOV1uPNcMuL6noSpnhDDhi76w@mail.gmail.com>
References: <CAFEAcA9GHWQCUrgYsT_Bnsy8_ZYP073_DWBcoRvX2Hg+F=_h5w@mail.gmail.com>
	<CAJ+F1CKoqiCg6ediSWHhdUQ92hOV1uPNcMuL6noSpnhDDhi76w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 14:14:34 +0000
Message-ID: <CAFEAcA-3=ZDCOeqiJBqH6aMSRB3DMH+v7N9-_3v70+SY86gC6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] problems with qapi2texi.py (use of @quotation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 16 February 2017 at 13:21, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> I am not so sure,
> https://www.gnu.org/software/texinfo/manual/texinfo/html_node/_0040quotat=
ion.html#index-quotation
>
> Explicitely mention that @quotation recongnizes Caution, Important, Note,
> Tip & Warning (and appropriately translates to docbook), and other argume=
nts
> are accepted.

True. On the other hand we don't use Caution Important Tip
or Warning, and we use a mix of Note (handled specially)
and Notes (not)...

thanks
-- PMM
