Received: from eggs.gnu.org ([209.51.188.92]:39788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gy6j3-0005Km-QU
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 22:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1gy6j3-0005xh-42
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 22:14:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:54778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1gy6j1-0005t9-Qr
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 22:14:41 -0500
References: <155024186658.3618.3655538630796654144.malonedeb@wampee.canonical.com>
	<155056695230.4038.14679219329213440549.malone@wampee.canonical.com>
From: Like Xu <like.xu@linux.intel.com>
Message-ID: <43b77240-fd90-059c-ef03-1d8b87035929@linux.intel.com>
Date: Mon, 25 Feb 2019 11:14:29 +0800
MIME-Version: 1.0
In-Reply-To: <155056695230.4038.14679219329213440549.malone@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1816052] Re: qemu system emulator fails to
 start if no sound card is present on host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1816052 <1816052@bugs.launchpad.net>, qemu-devel@nongnu.org

On 2019/2/19 17:02, Gerd Hoffmann wrote:
> What happens if you remove "try-alsa" from the configure line?
> 

This issue could be fixed by passing "export QEMU_AUDIO_DRV=none" to 
shell env when alsa support form host kernel is unavailable.
