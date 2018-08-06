Received: from eggs.gnu.org ([2001:4830:134:3::10]:52995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmb3V-0007CS-GK
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmb3U-0002HP-Kh
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:39:57 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:40263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmb3U-0002H0-FB
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:39:56 -0400
Received: by mail-oi0-x232.google.com with SMTP id w126-v6so20757035oie.7
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 01:39:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1808051732420.22072@zero.eik.bme.hu>
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
	<alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
	<CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
	<alpine.BSF.2.21.1808051732420.22072@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 09:39:35 +0100
Message-ID: <CAFEAcA-vcEDJww3kLXEr=C93M2z9KnB502=erakDgpvoojp0Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On 5 August 2018 at 16:38, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Now that it looks like we'll have an rc4 due to other fixes can these be
> included as well despite not being regressions? These may not have been
> serious enough to fix when we wouldn't have rc4 otherwise but holding on to
> broken implementation just because they were also broken in the previous
> release does not make sense if we'll have another rc anyway.

I'm considering it, yes, but it increases risk, so it is not
a completely trivial decision. (All changes later in the release
cycle increase the risk of something unexpected breaking as a result
of the change.)

thanks
-- PMM
