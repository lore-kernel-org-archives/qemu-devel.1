Received: from eggs.gnu.org ([2001:4830:134:3::10]:49286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciUQ3-0007er-Q5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciUQ2-0000yH-Qu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:09:27 -0500
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
	<20170225170758.427066-9-vsementsov@virtuozzo.com>
	<fec4aa12-6aaa-5e4e-3439-01578db31327@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6ea27ac5-4a4e-80f7-397b-5bf45753bd21@redhat.com>
Date: Mon, 27 Feb 2017 18:09:20 -0500
MIME-Version: 1.0
In-Reply-To: <fec4aa12-6aaa-5e4e-3439-01578db31327@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v16 08/22] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/27/2017 07:27 AM, Max Reitz wrote:
> On 25.02.2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
>> Add bitmap extension as specified in docs/specs/qcow2.txt.
>> For now, just mirror extension header into Qcow2 state and check
>> constraints. Also, calculate refcounts for qcow2 bitmaps, to not break
>> qemu-img check.
>>
>> For now, disable image resize if it has bitmaps. It will be fixed later.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  block/Makefile.objs    |   2 +-
>>  block/qcow2-bitmap.c   | 439 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  block/qcow2-refcount.c |   6 +
>>  block/qcow2.c          | 124 +++++++++++++-
>>  block/qcow2.h          |  27 +++
>>  5 files changed, 592 insertions(+), 6 deletions(-)
>>  create mode 100644 block/qcow2-bitmap.c
> 
> Somehow I have the feeling Kevin will find bad things in this patch, but
> since I have already approved of all of the previous patches this one is
> composed of and the changes on top of that look OK to me:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 

Pretty much the same sentiment as Max.

The patchset is now organized a bit strangely, but I did R-B all the
component pieces before, and the changes look fine.


Reviewed-by: John Snow <jsnow@redhat.com>
