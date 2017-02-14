Received: from eggs.gnu.org ([2001:4830:134:3::10]:47345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cde8R-0000QV-1b
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cde8Q-0001eW-3t
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:31:15 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cde8P-0001eD-Sr
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:31:14 -0500
Received: by mail-wr0-x22d.google.com with SMTP id c4so13384998wrd.2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 06:31:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170214100733.22280-3-alex.bennee@linaro.org>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 14:30:52 +0000
Message-ID: <CAFEAcA8cXXc3oABFzvZQaTjxtZTxjuzi+7NBxTfM86rfPqGcqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 14 February 2017 at 10:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> This provides a basic Debian install with access to the emdebian cross
> compilers. The debian-armhf-cross and debian-arm64-cross targets build
> on the basic Debian image to allow cross compiling to those targets.

Is there a particular reason for creating different docker images
for each cross target rather than just having one image with
all the cross compilers in it?

thanks
-- PMM
