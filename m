Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdof-0002lx-P9
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdof-00037A-3i
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:55:45 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:40466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAdoe-00036y-UA
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:55:45 -0400
Received: by mail-ot0-x22e.google.com with SMTP id h8-v6so17764157otj.7
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:55:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ee46f061-3c5c-ee63-9723-18afa224c4f9@amsat.org>
References: <20180421211652.14794-1-f4bug@amsat.org>
	<CAFEAcA_mSu00gEHgmfdpcvtaqfn7X0wbkUX54TCUW_FG+iURWQ@mail.gmail.com>
	<20180423031639.GB19804@umbus.fritz.box>
	<a3fc65b6-d906-fbfa-0102-a5382b15df8e@amsat.org>
	<CAFEAcA8T=aDjRAxxRWOKJuhDJa1ROjQ43cvaTG5B44+=d9SVLQ@mail.gmail.com>
	<73a63694-d656-959c-cd68-a26c28fbbf72@amsat.org>
	<f937a232-fbb3-9b83-74fc-e19930dfbf9c@amsat.org>
	<CAFEAcA8prvR20De9houvPfTJ-k5dDVPo7=nu6Cs87cdqMPv-hw@mail.gmail.com>
	<ee46f061-3c5c-ee63-9723-18afa224c4f9@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 16:55:23 +0100
Message-ID: <CAFEAcA-V4wTgZGNTJm4DCrhej7a8MXt5dxxEJK9cLULqWwWVjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] loader: Fix misaligned member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, QEMU Developers <qemu-devel@nongnu.org>

On 23 April 2018 at 16:49, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> I think I never noticed ldq_he_p(), good to know.
>
> $ git grep -E '(ld|st)._he_'
> net/checksum.c:130:        stw_he_p(&tcp->th_sum, 0);
> net/checksum.c:151:        stw_he_p(&udp->uh_sum, 0);
> util/bufferiszero.c:47:        uint64_t t =3D ldq_he_p(buf);
> util/bufferiszero.c:61:        t |=3D ldq_he_p(buf + len - 8);
>
> Not many users...

Well, it's fairly rare to have something that you want
to load in host endianness that isn't also aligned as
much as the host requires for it. We only want it here
because libfdt doesn't provide a ldq_fdt or something
like it ought to.

thanks
-- PMM
