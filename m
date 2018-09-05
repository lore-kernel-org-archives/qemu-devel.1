Received: from eggs.gnu.org ([2001:4830:134:3::10]:59661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1fxXKh-0007w3-Fu
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1fxXKg-0008JD-PN
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:54:55 -0400
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:9340
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1fxXKg-0007t7-HL
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:54:54 -0400
References: <20180824012126.22721-1-famz@redhat.com>
	<8d039be4-486e-e017-88ca-5cb6ebd89519@comstyle.com>
	<20180827090551.4lhug2yvghirb3si@sirius.home.kraxel.org>
From: Brad Smith <brad@comstyle.com>
Message-ID: <ca37c453-e198-9ea7-2bed-9b38a17e5170@comstyle.com>
Date: Wed, 5 Sep 2018 08:54:39 -0400
MIME-Version: 1.0
In-Reply-To: <20180827090551.4lhug2yvghirb3si@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 8/27/2018 5:05 AM, Gerd Hoffmann wrote:

> On Fri, Aug 24, 2018 at 10:36:30AM -0400, Brad Smith wrote:
>> I very much appreciate the effort to bump up to 6.3 as I was going
>> to suggest doing that at some point. But bumping up to 6.3 at the
>> moment will fail with the configure script. We've switched from GCC 4.2
>> to Clang. The TLS check will fail with Clang's emulated TLS. We've
>> had a local patch for awhile to fix the test but I don't think it is
>> appropriate to upstream as is.
> Hmm, /me looks a bit surprised.
> Seems to work fine for me ...

I am quite surprised as well. Something has changed since we first 
brought in Clang
and this patch no longer seems to be necessary. I just removed it from 
our ports tree.
