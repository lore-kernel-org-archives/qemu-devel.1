Received: from eggs.gnu.org ([2001:4830:134:3::10]:53100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccECn-0004Yb-Ny
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccECm-0006Xb-Ve
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:37:53 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccECm-0006XQ-Os
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:37:52 -0500
Received: by mail-wm0-x235.google.com with SMTP id r141so53219444wmg.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 08:37:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486739699-1076-1-git-send-email-thuth@redhat.com>
References: <1486739699-1076-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 16:37:31 +0000
Message-ID: <CAFEAcA8GHjg6mmfHQm56rLA0outk=CKg-c0bpE4c575KVTkr5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] tests/prom-env: Ease time-out problems
 on slow hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 10 February 2017 at 15:14, Thomas Huth <thuth@redhat.com> wrote:
> Peter Maydell recently ran into time-out problems with the
> prom-env test on a rather slow ARM board. To tackle this issue,
> we can speed up the test by running QEMU with "-nodefaults" for
> the pseries machine, so that SLOF has less devices to scan during
> boot, and by using the "nvramrc" environment variable instead of
> "boot-command", since this variable is evaluated earlier in the
> boot process.
> And to be really sure that we do not face such time out problems
> again, let's also increase the time out value from 100s to 120s
> instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use "-nodefaults" only for the pseries machine, since the
>      sparc machines have a built-in ethernet controller and spill
>      out a warning otherwise.
>
>  tests/prom-env-test.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Applied to master, thanks.

-- PMM
