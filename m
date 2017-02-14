Received: from eggs.gnu.org ([2001:4830:134:3::10]:38000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdejX-0006mI-Py
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdejS-000809-Nk
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:09:35 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdejS-0007xR-GF
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 10:09:30 -0500
Received: by mail-wr0-x22b.google.com with SMTP id i10so172275701wrb.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:09:28 -0800 (PST)
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-3-alex.bennee@linaro.org>
	<CAFEAcA8cXXc3oABFzvZQaTjxtZTxjuzi+7NBxTfM86rfPqGcqw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8cXXc3oABFzvZQaTjxtZTxjuzi+7NBxTfM86rfPqGcqw@mail.gmail.com>
Date: Tue, 14 Feb 2017 15:09:46 +0000
Message-ID: <87fujgvmf9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] new: debian docker targets for
 cross-compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 14 February 2017 at 10:07, Alex Bennée <alex.bennee@linaro.org> wrote:
>> This provides a basic Debian install with access to the emdebian cross
>> compilers. The debian-armhf-cross and debian-arm64-cross targets build
>> on the basic Debian image to allow cross compiling to those targets.
>
> Is there a particular reason for creating different docker images
> for each cross target rather than just having one image with
> all the cross compilers in it?

Mainly the clashing of build-dependencies. Debian's multi-arch is pretty
good but you still can't generally have two arches worth of complex
dependencies installed at once.

I did originally have one base docker image with all the compilers and
intended to do the dependencies step as part of test-build. However when
running as builders the docker images don't actually have network
ability so couldn't download them.

--
Alex Bennée
