Received: from eggs.gnu.org ([2001:4830:134:3::10]:46136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcEN-0006nj-16
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJcEI-0004RX-DO
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:03:23 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:41513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJcEI-0004RL-7Z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:03:18 -0400
Received: by mail-oi0-x233.google.com with SMTP id 11-v6so6612640ois.8
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 03:03:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518091440.1559-3-alex.bennee@linaro.org>
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 11:02:56 +0100
Message-ID: <CAFEAcA_n-CQAXSX=tFci7Tk_AKOg1-+wawfYpLhor7NHqSxDpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 10:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following tests keep showing up in failed Travis runs:
>
>   - test-aio
>   - rcutorture
>   - tpm-crb-test
>   - tpm-tis-test
>
> I suspect it is load that causes the problems but they really need to
> be fixed properly.

Are the tpm-crb and tpm-tis failures fixed by this patch?
https://patchwork.ozlabs.org/patch/910298/

thanks
-- PMM
