Received: from eggs.gnu.org ([2001:4830:134:3::10]:60627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esrUW-0006ve-6A
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esrUT-0005gc-JB
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 09:53:28 -0500
References: <152024589806.7327.9844777027357521578.malonedeb@gac.canonical.com>
	<083d2e7c-5ada-88c9-bf50-0c68e7c19136@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c0d0caa1-992a-7df6-67bb-e7d639f18049@redhat.com>
Date: Mon, 5 Mar 2018 15:53:21 +0100
MIME-Version: 1.0
In-Reply-To: <083d2e7c-5ada-88c9-bf50-0c68e7c19136@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1753437] [NEW]
 qemu/pc-bios/s390-ccw/libc.c:82: bad test ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Bug 1753437 <1753437@bugs.launchpad.net>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>

On 05.03.2018 12:22, Christian Borntraeger wrote:
> Adding qemu-s390x.
> 
> On 03/05/2018 11:31 AM, dcb wrote:
>> Public bug reported:
>>
>> qemu/pc-bios/s390-ccw/libc.c:82]: (style) Unsigned variable 'num_idx'
>> can't be negative so it is unnecessary to test it.
>>
>> Source code is
>>
>>
>>     while (num_idx >= 0) {
>>
>> but
>>
>>     size_t num_idx = 1; /* account for NUL */
>>
>> So there is no escape from the while loop.

Actually we're defining size_t like this in the s390-ccw bios:

typedef long               size_t;

So the while loop is not endless.

But yes, this is ugly, we should fix the function and re-define size_t
to be unsigned instead...

 Thomas
