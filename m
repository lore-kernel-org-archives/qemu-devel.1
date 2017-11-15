Received: from eggs.gnu.org ([2001:4830:134:3::10]:54234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eF57S-0006Hn-Ps
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eF57S-0006yI-3H
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 16:21:14 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
Date: Wed, 15 Nov 2017 16:20:59 -0500
MIME-Version: 1.0
In-Reply-To: <20171113162053.58795-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com



On 11/13/2017 11:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
> 
> There are three qmp commands, needed to implement external backup API.
> 
> Using these three commands, client may do all needed bitmap management by
> hand:
> 
> on backup start we need to do a transaction:
>  {disable old bitmap, create new bitmap}
> 
> on backup success:
>  drop old bitmap
> 
> on backup fail:
>  enable old bitmap
>  merge new bitmap to old bitmap
>  drop new bitmap
> 

Can you give me an example of how you expect these commands to be used,
and why they're required?

I'm a little weary about how error-prone these commands might be and the
potential for incorrect usage seems... high. Why do we require them?
