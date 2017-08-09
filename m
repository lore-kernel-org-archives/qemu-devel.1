Received: from eggs.gnu.org ([2001:4830:134:3::10]:59354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfShD-0008KA-5U
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dfSh7-0004UQ-76
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:14:55 -0400
References: <20170728115131.31725-1-otubo@redhat.com>
	<a6feb869-e73e-ffd3-278e-23fef4ae6a0c@msgid.tls.msk.ru>
	<20170807141604.GA14212@bluepex.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <cdf1189d-f52c-6a2c-eabb-6923c383ca0e@msgid.tls.msk.ru>
Date: Wed, 9 Aug 2017 18:14:48 +0300
MIME-Version: 1.0
In-Reply-To: <20170807141604.GA14212@bluepex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] unicore32: abort when entering "x 0" on
 the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org, thuth@redhat.com, gxt@mprc.pku.edu.cn, qemu-devel@nongnu.org

07.08.2017 17:16, Eduardo Otubo wrote:
> On Mon, Jul 31, 2017 at 01:17:03PM +0300, Michael Tokarev wrote:
>> 28.07.2017 14:51, Eduardo Otubo wrote:
>>> Starting Qemu with "qemu-system-unicore32 -M puv3,accel=qtest -S -nographic"
>>> and entering "x 0 " at the monitor prompt leads to abort():
>>
>> Applied to -trivial, thanks!
> 
> Hi Michael, you missed this patch in the latest pull request. Care to
> take it on the next one? I'm planning to send some other small fixes
> until this Friday.

Yeah, for some reason it slipped out. I'm picking it up again.
Thanks,

/mjt
