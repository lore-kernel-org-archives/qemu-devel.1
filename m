Received: from eggs.gnu.org ([2001:4830:134:3::10]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0pwK-0006pj-DG
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 10:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0pwJ-0001tN-Gu
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 10:18:52 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:48092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0pwJ-0001rt-9Z
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 10:18:51 -0400
Received: by mail-wm0-x229.google.com with SMTP id t69so12822037wmt.2
	for <qemu-devel@nongnu.org>; Sat, 07 Oct 2017 07:18:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Oct 2017 15:18:29 +0100
Message-ID: <CAFEAcA_ua3Y=OC_HDq98st-8+7ZScmYXU0Sj=XUgfTm4POY0iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/88] use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 October 2017 at 00:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Hi,
>
> This is a follow-up of Marc-Andr=C3=A9's clang-tidy series [1].
> While chatting we realized we were trying to reach the same goal, Marc-An=
dr=C3=A9
> using clang-tidy and me using spatch; so he let me finish his series appl=
ying
> my changes over his.
> I also included Jan's patch which fits well.
>
> Summary:
> - 1 bugfix (memory leak)
> - few optimizations (avoid to zeroise when all memory is assigned)
> - bunch of mechanical refactors

88 patches is way too many for a single series, even if it is
mostly mechanical.

thanks
-- PMM
