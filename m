Received: from eggs.gnu.org ([2001:4830:134:3::10]:32902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gHvVr-0004gJ-Fa
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gHvVl-0002tC-Pm
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:46:43 -0400
Received: from mout02.posteo.de ([185.67.36.66]:49357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1gHvVj-0002ou-Sc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:46:37 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id 8AAFD2400FB
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 19:46:33 +0100 (CET)
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
	<7fc49925-36ff-bd9a-0cd7-e5f8d4bb3672@roeck-us.net>
	<CAFEAcA-UF+SyXvcU+NGZsbqBF2qg+s_x4HPU7yvf7B2G-=HPOg@mail.gmail.com>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <6861d4a0-c48d-9d48-726b-a1801012b757@posteo.de>
Date: Wed, 31 Oct 2018 18:46:29 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UF+SyXvcU+NGZsbqBF2qg+s_x4HPU7yvf7B2G-=HPOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Deprecate the "collie" machine and
 Strongarm devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 2018-10-29 13:24, Peter Maydell wrote:
> On 27 October 2018 at 12:04, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 10/26/18 3:12 AM, Peter Maydell wrote:
>>> Hi Guenter; there's a proposal here to deprecate (and eventually
>>> remove) the 'collie' board (strongarm) from QEMU. Is that one of
>>> the ones you're currently using in your automated testing of Linux
>>> kernels on QEMU?
>>>
>>
>> Yes. I can run the test with older versions of qemu, so it is ok for me
>> if it is removed (as long as that removal is not backported).
> 
> Mmm, but if we have an active user who's testing them then they
> probably shouldn't be in the frontline of boards to remove.

Yes, I agree. I based my patch on the assumption that the board was
incomplete and not really usable (as mentioned in the patch
description), but if it is still usable to some degree, then please
disregard my patch.

 Thomas
