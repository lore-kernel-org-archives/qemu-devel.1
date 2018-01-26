Received: from eggs.gnu.org ([2001:4830:134:3::10]:57306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ef0eP-0007Py-Ci
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ef0eK-0001wu-2i
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:50:25 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-8-git-send-email-walling@linux.vnet.ibm.com>
	<6d81c288-2b93-35b4-fb27-24276342089d@redhat.com>
	<994e3f5e-24e1-834a-5519-775a819d73c8@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1fb0b863-0b5b-120e-7f19-093ecdb3a93c@redhat.com>
Date: Fri, 26 Jan 2018 10:50:12 +0100
MIME-Version: 1.0
In-Reply-To: <994e3f5e-24e1-834a-5519-775a819d73c8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 07/10] s390-ccw: read
 stage2 boot loader data to find menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, borntraeger@de.ibm.com, alifm@linux.vnet.ibm.com, david@redhat.com, cohuck@redhat.com

On 25.01.2018 16:49, Collin L. Walling wrote:
> On 01/25/2018 10:25 AM, Thomas Huth wrote:
>> On 23.01.2018 19:26, Collin L. Walling wrote:
>>> Read the stage2 boot loader data block-by-block. We scan the
>>> current block for the string "zIPL" to detect the start of the
>>> boot menu banner. We then load the adjacent blocks (previous
>>> block and next block) to account for the possibility of menu
>>> data spanning multiple blocks.
>>>
>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 pc-bios/s390-ccw/bootmap.c | 94
>>> +++++++++++++++++++++++++++++++++++++++++++---
>>> =C2=A0 pc-bios/s390-ccw/bootmap.h |=C2=A0 1 +
>>> =C2=A0 pc-bios/s390-ccw/menu.c=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++
>>> =C2=A0 pc-bios/s390-ccw/menu.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>> =C2=A0 4 files changed, 96 insertions(+), 5 deletions(-)
>> Looks good to me now!
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
> Thanks! The only change I plan on is moving the Stage1b struct declarat=
ion
> to this patch, as per your suggestion on another patch review.

Sure, feel free to keep my R-b in that case, too.

 Thomas
