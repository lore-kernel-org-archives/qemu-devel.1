Received: from eggs.gnu.org ([2001:4830:134:3::10]:36381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg9MQ-0001mH-DY
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dg9MP-0004H4-9U
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:48:18 -0400
Date: Fri, 11 Aug 2017 14:48:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170811124803.GF4162@localhost.localdomain>
References: <20170809151757.15743-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170809151757.15743-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com

Am 09.08.2017 um 17:17 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 185 can sometimes produce wrong output like this:
> 
> =========================================
> 185 2s ... - output mismatch (see 185.out.bad)
> --- /work/src/qemu/master/tests/qemu-iotests/185.out    2017-07-14 \
>     15:14:29.520343805 +0300
> +++ 185.out.bad 2017-08-07 16:51:02.231922900 +0300
> @@ -37,7 +37,7 @@

For next time: This commit message really confuses 'git am' because it
thinks that this is already the real patch. Indenting a quoted diff
makes it much happier, so that's what I did instead of the '===' lines.

>  {"return": {}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>      "event": "SHUTDOWN", "data": {"guest": false}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>     "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>         "len": 4194304, "offset": 4194304, "speed": 65536, "type": \
>             "mirror"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, \
>     "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", \
>         "len": 0, "offset": 0, "speed": 65536, "type": "mirror"}}
> 
>  === Start backup job and exit qemu ===
> 
> Failures: 185
> Failed 1 of 1 tests
> =========================================
> 
> This is because quite happens before first mirror request is done
> (and, in specified case, even before block-job len field is set).
> To prevent it let's just add a sleep for 0.3 seconds before quite.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks, touched up the commit message according to your discussion with
Eric and applied to the block branch.

Kevin
