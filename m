Received: from eggs.gnu.org ([2001:4830:134:3::10]:33679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fp9B0-0002ux-Kr
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fp9Az-00012V-94
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:30:14 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fp9Ay-00012A-Tb
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:30:13 -0400
Received: by mail-oi0-x244.google.com with SMTP id j205-v6so26128393oib.4
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 02:30:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180813091828.GI22904@redhat.com>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
	<20180813090705.GH22904@redhat.com> <20180813091828.GI22904@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Aug 2018 10:29:51 +0100
Message-ID: <CAFEAcA9R-Nojb4mDG2t1Skwq51rUxwNm+_N4yE6Put-RA9By2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] tweaks for QEMU's C standard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 August 2018 at 10:18, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> Also, we should ensure the min required GCC version via biuld time
> check of some kind. eg something like
>
> #if !(__GNUC_PREREQ(4, 4) || defined(__clang__))
> # error "QEMU requires GCC >=3D 4.4, or CLang"
> #endif

Our current minimum is 4.1, I think (per commit fa54abb8c298f),
though we could bump that if there's utility in doing so.

Overall I think we should prefer to avoid specific gcc
version checks wherever we can. clang supports a useful
set of tests like __has_feature and __has_attribute;
gcc supports some of these (eg __has_attribute from gcc 5).

Random aside: I just stumbled across a comment in configure
about a workaround for a gcc 4.6.x bug which says "We should
be able to delete this at the end of 2013" :-)

thanks
-- PMM
