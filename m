Received: from eggs.gnu.org ([209.51.188.92]:50654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmxyY-0004Vq-7I
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmxod-0003hU-8P
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:30:24 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmxod-0003gy-3b
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:30:23 -0500
Received: by mail-ot1-x32b.google.com with SMTP id i20so7977237otl.0
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 01:30:22 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
	<0e9cc6c1-010b-9f6d-b6b4-dc1757880463@redhat.com>
In-Reply-To: <0e9cc6c1-010b-9f6d-b6b4-dc1757880463@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jan 2019 09:30:10 +0000
Message-ID: <CAFEAcA-stgWuym4HYw9v4cYPytj_rz0YF9oiSpz9V1p8bzaEYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] building rst docs with sphinx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 24 Jan 2019 at 21:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 1/24/19 7:56 PM, Peter Maydell wrote:
> > I had another look this afternoon at building our rST docs
> > with sphinx-build. In particular, we currently have some
> > docs in rst format, but we're not building them into HTML
> > or shipping them. (Predictably, this means a few errors and
> > warnings have crept in...)
>
> Are you talking about the files in docs/ such docs/devel/testing.rst?

I mean the .rst files in docs/. (I do want to do some autogen
as well -- we're planning to use the Linux kernel's kerneldoc
sphinx plugin for this, and I have some prototype patches to
plumb that in -- but since that will all be "developer"
docs I'd like to get the basic framework of manuals sorted
before adding that in.)

thanks
-- PMM
