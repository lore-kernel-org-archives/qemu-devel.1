Received: from eggs.gnu.org ([2001:4830:134:3::10]:40237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPRDs-0003NB-Jh
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPRDr-0000Vz-Q5
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:26:24 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPRDr-0000V4-Jq
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:26:23 -0400
Received: by mail-wm0-x236.google.com with SMTP id 62so3437703wmw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 03:26:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dam54FXEK+7RjnxfO=zBuTat7sMe8yUgZD3AEbAtigg@mail.gmail.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
	<CAFEAcA9dam54FXEK+7RjnxfO=zBuTat7sMe8yUgZD3AEbAtigg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 11:26:02 +0100
Message-ID: <CAFEAcA9mybzLaitMYm=CTCfURYyh_2CAnPgrVrntjsWapMoJtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/61] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 June 2017 at 11:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> I also get a core dump in my linux-user smoke test:
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/ppc-linux-user/qemu-ppc
> -L ./gnemul/qemu-ppc ppc/ls -l dummyfile
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>
> though it's hard to see how the block layer patches would
> cause that.

...indeed I can repro that bit without your patches, so the
problem is elsewhere.

thanks
-- PMM
