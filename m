Received: from eggs.gnu.org ([2001:4830:134:3::10]:39515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8gd-0004pk-Df
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8gY-00037y-ER
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:30:43 -0400
References: <20170913142036.2469-1-lvivier@redhat.com>
	<20170913142036.2469-4-lvivier@redhat.com>
	<20170913162709.3933352d.cohuck@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <32c345ab-ce02-fe29-1587-db863fb21209@redhat.com>
Date: Wed, 13 Sep 2017 16:30:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170913162709.3933352d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/4] dump: do not dump non-existent
 guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

On 13/09/2017 16:27, Cornelia Huck wrote:
> On Wed, 13 Sep 2017 16:20:35 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> It does not really make sense to dump memory that is not there.
>>
>> Moreover, that fixes a segmentation fault when calling dump-guest-memory
>> with no filter for a machine with no memory defined.
>>
>> New behaviour is:
>>
>> (qemu) dump-guest-memory /dev/null
>> dump: no guest memory to dump
>> (qemu) dump-guest-memory /dev/null 0 4096
>> dump: no guest memory to dump
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Tested-by: Laurent Vivier <lvivier@redhat.com>
>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>  dump.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
> 
> You need to supply your s-o-b as well, no?
> 

I was wondering... theoretically, yes, so:

Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks,
Laurent
