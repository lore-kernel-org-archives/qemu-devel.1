Received: from eggs.gnu.org ([2001:4830:134:3::10]:38390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gGMON-0001xc-1d
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gGMOJ-00058p-Qu
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:04:30 -0400
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7fc49925-36ff-bd9a-0cd7-e5f8d4bb3672@roeck-us.net>
Date: Sat, 27 Oct 2018 04:04:23 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 10/26/18 3:12 AM, Peter Maydell wrote:
> On 26 October 2018 at 11:06, Thomas Huth <thuth@redhat.com> wrote:
>> These files lack an entry in the MAINTAINERS file, and according to
>> the initial commits, the board and devices are incomplete. Since there
>> have hardly been any commits in the past to really improve them, we
>> should consider to mark them as deprecated now.
>>
>> Thomas Huth (2):
>>    hw/arm: Deprecate the "collie" board
>>    arm: Deprecate the Strongarm sa1100 and sa1110 processors
> 
> Hi Guenter; there's a proposal here to deprecate (and eventually
> remove) the 'collie' board (strongarm) from QEMU. Is that one of
> the ones you're currently using in your automated testing of Linux
> kernels on QEMU?
> 

Yes. I can run the test with older versions of qemu, so it is ok for me
if it is removed (as long as that removal is not backported).

Guenter
