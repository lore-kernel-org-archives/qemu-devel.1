Received: from eggs.gnu.org ([2001:4830:134:3::10]:56627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctu0P-0003l7-Dc
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctu0O-0001FX-L4
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:42:09 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctu0O-0001EZ-D5
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 06:42:08 -0400
Received: by mail-wr0-x234.google.com with SMTP id l43so101396609wre.1
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 03:42:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490932869-31217-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490932869-31217-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 11:41:46 +0100
Message-ID: <CAFEAcA8eVkUk1C8-opQ3hp1e3sWqDTU-HV3TWfQxe2iEdaBXOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/2] qemu-ga patch queue for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 March 2017 at 05:01, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit df9046363220e57d45818312759b954c033c58ab:
>
>   Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2017-03-30-tag
>
> for you to fetch changes up to 4eaf72029446ba693c63429475ce46348f65bf01:
>
>   qga: Make qemu-ga compile statically for Windows (2017-03-30 21:47:25 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for 2.9
>
> * fix make check failure of guest-get-fsinfo when nested virtual block
>   device partitions are mounted in the test environment
> * fix static compilation for mingw builds
>
> ----------------------------------------------------------------
> Michael Roth (1):
>       qga: don't fail if mount doesn't have slave devices
>
> Sameeh Jubran (1):
>       qga: Make qemu-ga compile statically for Windows
>
>  configure            | 7 +++++++
>  qga/commands-posix.c | 4 +++-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
