Received: from eggs.gnu.org ([209.51.188.92]:58323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gqwEr-0005Rv-Dl
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gqwEq-00068R-38
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:37:53 -0500
MIME-Version: 1.0
References: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
In-Reply-To: <ae28cefe-84fb-6c4e-0452-55b717726b2b@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 5 Feb 2019 09:37:39 +0100
Message-ID: <CABLmASEAbmGRohbvZag0jWYqvxys=dUiKeTJyN2=CYE+X1JAXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] 2x-3x tcg performance regression on
 ppc64 (maybe others)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Fri, Feb 1, 2019 at 11:54 PM Cleber Rosa <crosa@redhat.com> wrote:

> While working on the "boot_linux_console.py" tests, after a given
> rebase, I noticed that the ppc64 specific test began timing out.  The
> original timeout set to the test was 60 seconds, and it "always" had
> room to spare when running either on my system, or on Travis CI.
>
> Hi,

As reported on IRC on 31-01, performance loss also occurs with
qemu-system-ppc:
"I noticed a substantial performance loss (~35% in processor benchmark) in
qemu-system-ppc running Mac OS 9.2. Bisecting shows that
https://github.com/qemu/qemu/commit/f7b78602fdc6c6e4befc90159da8e93900b4bcb1
introduces the issue. Reverting brings performance back."

For a benchmark screen shot see:
https://surfdrive.surf.nl/files/index.php/s/M1o9rcNCt3QQ3I7

Best,
Howard
