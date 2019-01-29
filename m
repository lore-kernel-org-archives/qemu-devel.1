Received: from eggs.gnu.org ([209.51.188.92]:50769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQSq-0006qm-GO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goQSp-0002QA-FB
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:17:56 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goQSp-0002Px-7k
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 05:17:55 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so17414064otk.3
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 02:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
	<20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
	<ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
	<CAFEAcA8-FiXLns3Aj42cFkpUE54gAU0SRAO=kmWojU4+QdVm1w@mail.gmail.com>
	<f5f2d687-11ba-52bd-159e-21a2d4cfa46e@redhat.com>
In-Reply-To: <f5f2d687-11ba-52bd-159e-21a2d4cfa46e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 10:17:43 +0000
Message-ID: <CAFEAcA90UdNRC2rc8rxb31cHMoC_YF6S5c8t_ufK7Ufysex_xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/display/milkymist-tmu2: Move
 inlined code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Tue, 29 Jan 2019 at 08:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 28/01/19 19:02, Peter Maydell wrote:
> >
> > I don't understand why the build/config-all-devices.mak versions of
> > the defines of CONFIG_FOO variables are so weird:
> >
> > CONFIG_ACPI:=$(findstring y,$(CONFIG_ACPI)y)
> >
> > ...are they really intended to be self-referential like that?
>
> Yes, config-all-devices.mak is basically on "OR" of all the
> config-devices.mak files.
>
> Are CONFIG_X11 and CONFIG_OPENGL defined at the time
> config-all-devices.mak is included?

They should be -- they're defined in config-host.mak, which
Makefile includes before config-all-devices.mak.

thanks
-- PMM
