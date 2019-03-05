Received: from eggs.gnu.org ([209.51.188.92]:55800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h19Tx-0000HD-1m
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h19Tw-0004uN-C1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:47:41 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h19Tw-0004mb-3V
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:47:40 -0500
Received: by mail-oi1-x243.google.com with SMTP id b4so6705286oif.6
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 04:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-10-peter.maydell@linaro.org>
	<7ec8917a-eabd-6a14-3c1f-38b1d429c900@redhat.com>
In-Reply-To: <7ec8917a-eabd-6a14-3c1f-38b1d429c900@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 12:47:27 +0000
Message-ID: <CAFEAcA-G8FN63M57JJt8K_0omq8kujABetsr31unCxxxno+MiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu, 28 Feb 2019 at 15:49, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 2/28/19 3:56 PM, Peter Maydell wrote:
> > +# Sphinx builds all its documentation at once in one invocation
> > +# and handles "don't rebuild things unless necessary" itself.
> > +# The '.doctrees' files are cached information to speed this up.
>
> Can you add .doctrees to .gitignore?

Since this was the only change request for this patchset,
I plan to send out a pullreq containing it, with this folded
into this patch:

diff --git a/.gitignore b/.gitignore
index b66b7725512..77522561b8e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+/.doctrees
 /config-devices.*
 /config-all-devices.*
 /config-all-disas.*

thanks
-- PMM
