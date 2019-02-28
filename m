Received: from eggs.gnu.org ([209.51.188.92]:49904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOXc-0001Eh-Qr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzOXb-0008JS-W8
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:28:12 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:41455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzOXb-0008Im-Mj
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:28:11 -0500
Received: by mail-ot1-x32a.google.com with SMTP id t7so18166063otk.8
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 08:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20190228145624.24885-1-peter.maydell@linaro.org>
	<20190228145624.24885-4-peter.maydell@linaro.org>
	<074eb05d-762d-97ae-a3fe-4f009382e83d@redhat.com>
In-Reply-To: <074eb05d-762d-97ae-a3fe-4f009382e83d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 16:27:58 +0000
Message-ID: <CAFEAcA-zfX1YonW8CfHnR0VwB7ervz=eryuAvzN-y9NdcOuGww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/11] docs: Commit initial files from
 sphinx-quickstart
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu, 28 Feb 2019 at 16:01, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 2/28/19 3:56 PM, Peter Maydell wrote:
> > Commit the initial Sphinx conf.py and skeleton index.rst as
> > generated with sphinx-quickstart. We'll update these to
> > add QEMU-specific tweaks in subsequent commits.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  docs/conf.py   | 168 +++++++++++++++++++++++++++++++++++++++++++++++++
>
> Can you add a "rST documentation" section in MAINTAINERS?

We don't have documentation listed in a separate section --
individual doc files get listed under the section of the
code they're documenting, because the maintainers are
different for each doc.

I was thinking about maybe having a section for the
Sphinx doc build infrastructure itself, but wasn't
sure what it should list.

thanks
-- PMM
