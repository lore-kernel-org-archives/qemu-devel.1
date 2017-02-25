Received: from eggs.gnu.org ([2001:4830:134:3::10]:33944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chevb-000246-OH
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1chevY-0001dx-Kl
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:10:35 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:40941 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1chevY-0001dD-8P
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:10:32 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-22-git-send-email-vsementsov@virtuozzo.com>
	<20170216142713.GH4869@noname.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f1e6cc27-28f7-d26a-84f4-838fac8b520d@virtuozzo.com>
Date: Sat, 25 Feb 2017 19:10:11 +0300
MIME-Version: 1.0
In-Reply-To: <20170216142713.GH4869@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 21/25] qcow2-bitmap: refcounts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

16.02.2017 17:27, Kevin Wolf wrote:
> Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Calculate refcounts for qcow2 bitmaps. It is needed for qcow2's qemu-img
>> check implementation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
> Maybe this should come earlier in the series so that qemu-img check
> doesn't corrupt them. Basically it's needed as soon as we add the
> autoclear flag as supported.

so, it should be merged into 07

>
> Anyway, the actual point I was going to make is that it would be good to
> have a qemu-iotests case which actually invokes qemu-img check on an
> image with dirty bitmaps. In general, the test case side of the series
> seems to be rather weak so far. Just keep in mind that I won't feel bad
> for breaking anything that isn't tested by a test case. So if you like
> to keep persistent bitmaps working in the long run, you'd better write
> tests and give me no chance to break anything without them failing.
>
> Kevin


-- 
Best regards,
Vladimir
