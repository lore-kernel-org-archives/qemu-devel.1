Received: from eggs.gnu.org ([2001:4830:134:3::10]:54305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duNHQ-0005K0-NI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duNHP-0006KS-W6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:29:56 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:49288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duNHP-0006Iu-QJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:29:55 -0400
Received: by mail-wm0-x22a.google.com with SMTP id e71so1231021wmg.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:29:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150584473563.66.13015229253961964078@69b6ddf88678>
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<150584473563.66.13015229253961964078@69b6ddf88678>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 19:29:33 +0100
Message-ID: <CAFEAcA-vvabz8ac_BTPYUq=0pLrbSD4SYbYeeGZUEmF_5ME=Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/19] ARMv8M: support security extn in the
 NVIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 19 September 2017 at 19:12,  <no-reply@patchew.org> wrote:
> This series failed build test on s390x host. Please find the details belo=
w.

patchew has as usual produced an email with three miles of
uninteresting output hiding the actual problem, but:

/var/tmp/patchew-tester-tmp-jpi3jgs6/src/hw/intc/armv7m_nvic.c:1742:33:
error: =E2=80=98vmstate_nvic_security=E2=80=99 defined but not used
[-Werror=3Dunused-const-variable=3D]
 static const VMStateDescription vmstate_nvic_security =3D {
                                 ^~~~~~~~~~~~~~~~~~~~~

I've forgotten to add the vmstate subsection to the
main vmstate again...

thanks
-- PMM
