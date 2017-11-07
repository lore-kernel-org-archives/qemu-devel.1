Received: from eggs.gnu.org ([2001:4830:134:3::10]:40405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC5kI-0001AY-PZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC5kH-0001hd-MF
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:24:58 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:47979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC5kH-0001hD-FL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:24:57 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r196so4541785wmf.2
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:24:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1997067362.187762.1510068032954.JavaMail.zimbra@xes-inc.com>
References: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
	<c97adeea-32ee-269c-2a88-b011e8a294fa@vivier.eu>
	<1997067362.187762.1510068032954.JavaMail.zimbra@xes-inc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 15:24:35 +0000
Message-ID: <CAFEAcA_keEj29AzE9BbnRqXORuwSdSQ4M=0hoUfzPdHwiiWBrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support explicit targets for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel <qemu-devel@nongnu.org>

On 7 November 2017 at 15:20, Aaron Sierra <asierra@xes-inc.com> wrote:
> I had that thought, too, as being the cleanest and simplest to implement,
> but it didn't work out as a practical solution. Having execution depend
> on the name of the file would require a lot of tuning of magics, masks,
> and interpreters in /proc/sys/fs/binfmt_misc to get the behavior that I
> depend on. It would require one entry per binary.
>
> With the implementation that I've proposed, I only need two fairly generic
> entries (ppc and ppc64) stock from Ubuntu's qemu-user-static package.
> With Docker it's trivial to bind <any_path>/qemu-ppc.e500mc to
> /usr/bin/qemu-ppc-static within the container. Which gives me complete
> control over how the container is emulated.

If you don't need the binfmt-invokes-the-right-QEMU magic to work
out of the box, why can't you just use a wrapper script here?

thanks
-- PMM
