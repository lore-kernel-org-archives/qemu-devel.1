Received: from eggs.gnu.org ([2001:4830:134:3::10]:50104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceOkr-00075F-Rf
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:18:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceOkn-0007qp-SD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:18:01 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceOkn-0007qR-Gd
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:17:57 -0500
References: <20170216143816.2384-1-laurent@vivier.eu>
	<CAFEAcA8MXwZcp3uBwHfQRLUJvvK7pxhOEnoaVTqkpw_DzhBAtA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e9b5c51b-9393-4c79-e2ab-a046763ec274@vivier.eu>
Date: Thu, 16 Feb 2017 17:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MXwZcp3uBwHfQRLUJvvK7pxhOEnoaVTqkpw_DzhBAtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 00/14] Linux user for upstream patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Le 16/02/2017 à 17:06, Peter Maydell a écrit :
> On 16 February 2017 at 14:38, Laurent Vivier <laurent@vivier.eu> wrote:
>> The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:
>>
>>   Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)
>>
>> are available in the git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-upstream-pull-request
>>
>> for you to fetch changes up to 21992cb6794a5f8edb0cee01bdfe0b03d0438dac:
>>
>>   linux-user: Add FICLONE and FICLONERANGE ioctls (2017-02-16 15:29:30 +0100)
>>
>> ----------------------------------------------------------------
>> To help Riku in his maintainer role of linux-user, I've proposed
>> to help him to manage this pull request.
>>
>> This series is based on his branch linux-user-for-upstream at:
>>
>>     https://git.linaro.org/people/riku.voipio/qemu.git
>>
>> I have added some reviewed patches from the mailing list since
>> the last pull request.
>>
>> I have tested this series by creating some containers:
>>
>> ppc64   fedora-21
>> ppc     debian-8
>> aarch64 centos-7.2
>>
>> All these containers can boot and run as expected
>> (create an user, log in as this user, install packages with yum/dnf/apt-get
>> using sudo)
>>
>> I have tested the LTP-20170116 in the ppc container (big-endian 32bit)
>> on an x86_64 host (little-endian 64bit). The result is:
>>
>> Total Tests: 1111
>> Total Skipped Tests: 174
>> Total Failures: 68
>> Kernel Version: 4.9.5-200.fc25.x86_64
>> Machine Architecture: ppc
>> Hostname: debian-8-ppc
>>
>> v2:
>>     Fix John Paul Adrian Glaubitz author name
>> ----------------------------------------------------------------
> 
> Sorry, I applied v1 before I noticed you'd done this respin :-(

It's fine: the tag was the same, and it seems you've applied it after
I've pushed the v2 to the repo.

The author name is correct:

    Author: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Laurent
