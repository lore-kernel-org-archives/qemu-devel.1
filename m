Received: from eggs.gnu.org ([2001:4830:134:3::10]:36156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUquH-0005ev-E7
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUquE-0008DT-Bd
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:52:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUquE-0008DD-6M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:52:30 -0400
References: <1499700760-4777-1-git-send-email-thuth@redhat.com>
	<1499700760-4777-6-git-send-email-thuth@redhat.com>
	<20170711095939.3470a289@dhcp-192-215.str.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d9a2dfc8-f45f-f297-7929-e457a666d608@redhat.com>
Date: Tue, 11 Jul 2017 10:52:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170711095939.3470a289@dhcp-192-215.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/10] pc-bios/s390-ccw: Move byteswap
 functions to a separate header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 11.07.2017 09:59, Cornelia Huck wrote:
> On Mon, 10 Jul 2017 17:32:35 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> We'll need them in code that is not related to bootmap.h, so
>> they should reside in an independent header.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  pc-bios/s390-ccw/bootmap.c |  1 +
>>  pc-bios/s390-ccw/bootmap.h | 26 --------------------------
>>  pc-bios/s390-ccw/bswap.h   | 25 +++++++++++++++++++++++++
>>  3 files changed, 26 insertions(+), 26 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/bswap.h
> 
>> diff --git a/pc-bios/s390-ccw/bswap.h b/pc-bios/s390-ccw/bswap.h
>> new file mode 100644
>> index 0000000..45b5ef4
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/bswap.h
> 
> Add a copyright/licence text?

The original file include/qemu/bswap.h (where this code comes from) also
does not have a copyright statement, so I was not sure which one to add
here. I think that simply means that the default applies here...
But I can certainly also add the default GPLv2+ statement if you think
that we need it here...

 Thomas
