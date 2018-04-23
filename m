Received: from eggs.gnu.org ([2001:4830:134:3::10]:41176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAaFY-0007UR-Gh
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAaFV-0000zz-SR
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:07:16 -0400
References: <1523864720-4680-1-git-send-email-thuth@redhat.com>
	<20180423120831.11cc785f.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <602d8411-1137-0499-17bf-a0b08e7a41fb@redhat.com>
Date: Mon, 23 Apr 2018 14:07:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180423120831.11cc785f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.13] pc-bios/s390-ccw: size_t
 should be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 23.04.2018 12:08, Cornelia Huck wrote:
> On Mon, 16 Apr 2018 09:45:20 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> "size_t" should be an unsigned type according to the C standard.
>> Thus we should also use this convention in the s390-ccw firmware to avoid
>> confusion. I checked the sources, and apart from one spot in libc.c, the
>> code should all be fine with this change.
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Use long instead of ssize_t in uitoa()
>>
>>  pc-bios/s390-ccw/libc.c | 2 +-
>>  pc-bios/s390-ccw/libc.h | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
> I assume you'll queue this one yourself?

Yes, I'll queue it with the other pending s390-ccw bios patches.

 Thomas
