Received: from eggs.gnu.org ([2001:4830:134:3::10]:45632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cfl5Q-0007nv-FU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cfl5P-0004xH-EF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:20:52 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:42992 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cfl5P-0004wd-26
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:20:51 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-26-git-send-email-vsementsov@virtuozzo.com>
	<20170216142144.GG4869@noname.redhat.com>
	<e572baaf-f726-ee89-ae33-b8e2d99125e5@virtuozzo.com>
	<86274ce0-34df-1f60-0f9d-41327153bdc8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <94aeec54-681e-f7cf-2c47-98820d1f78cb@virtuozzo.com>
Date: Mon, 20 Feb 2017 13:20:37 +0300
MIME-Version: 1.0
In-Reply-To: <86274ce0-34df-1f60-0f9d-41327153bdc8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v15 25/25] qcow2-bitmap: improve
 check_constraints_on_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

17.02.2017 18:48, Eric Blake wrote:
> On 02/17/2017 04:18 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 16.02.2017 17:21, Kevin Wolf wrote:
>>> Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Add detailed error messages.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Why not merge this patch into the one that originally introduced the
>>> function?
>> Just to not create extra work for reviewers
> It's extra work for reviewers if you don't rebase obvious fixes where
> they belong - a new reviewer may flag the issue in the earlier patch
> only to find out later in the series that you've already fixed it.
> Avoiding needless code churn is part of what rebasing is all about - you
> want each step of the series to be self-contained and as correct as
> possible, by adding in the fixes at the point where they make sense,
> rather than at the end of the series.
>

Ok, I'll rebase, It's not a problem.


-- 
Best regards,
Vladimir
