Received: from eggs.gnu.org ([2001:4830:134:3::10]:47035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1gV7yt-0003NB-E4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1gV7yn-0002CC-EK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:43:13 -0500
MIME-Version: 1.0
References: <CAHmME9qhe0ZemTkc2jkEO=_hu6PhvKUKGHC9QYTj2j+QHhNf8g@mail.gmail.com>
	<CAFEAcA8fYaKTZkLR8Ja3P590bSWy1cu61-gSxyf6+wXCfCLoxA@mail.gmail.com>
In-Reply-To: <CAFEAcA8fYaKTZkLR8Ja3P590bSWy1cu61-gSxyf6+wXCfCLoxA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 7 Dec 2018 05:42:53 +0100
Message-ID: <CAHmME9qQo4XfRgZUZDt3xbx=5KmRoYbO3N0+3m9gdKi9hvnZQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] more serial ports on arm?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, Nov 20, 2018 at 11:08 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> It's still stuck, because unconditionally adding a second serial
> port to the virt board breaks some commonly used existing guest
> code (UEFI + Linux), and it's not clear to me what the best
> command line UI is for allowing the user to request the second
> serial port.

Can the UI be the same more or less as for x86? Specify a second
-serial, and then the machine gets one added? If it's in secure mode,
then it's added as serial 3 instead of 2, to remain backwards
compatible.
