Received: from eggs.gnu.org ([2001:4830:134:3::10]:39448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJnY-0003iK-R6
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJnY-0006IX-3n
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:06:28 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJnX-0006IH-Tl
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:06:28 -0400
Received: by mail-wm0-x229.google.com with SMTP id m125so23485788wmm.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:06:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-10-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-10-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:06:06 +0100
Message-ID: <CAFEAcA_CRvDAfLoEV6a4rH2iiTL=RfXYC5g88MQ9kV3sZ4yXRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 09/13] risu: add simple trace and
 replay support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> This adds a very dumb and easily breakable trace and replay support. In
> --master mode the various risu ops trigger a write of register/memory
> state into a binary file which can be played back to an apprentice.
> Currently there is no validation of the image source so feeding the
> wrong image will fail straight away.
>
> The trace files will get very big for any appreciable sized test file
> and this will be addressed in later patches.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
