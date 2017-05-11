Received: from eggs.gnu.org ([2001:4830:134:3::10]:58024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d8t3u-0008Oa-Ga
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d8t3t-00039n-Tz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:43:42 -0400
References: <20170504105444.8940-1-daniel.kucera@gmail.com>
	<20170508203556.GA22634@stefanha-x1.localdomain>
	<c51044c8-edf6-c0a2-e543-0d9be1a61b29@openvz.org>
	<fac1ae33-dc7e-b513-d694-c8f8c1555baa@redhat.com>
	<20170509165254.GA26793@stefanha-x1.localdomain>
	<fc8b563b-5fb5-0a65-c883-32191b3c93e7@openvz.org>
	<20170510150016.GB19962@stefanha-x1.localdomain>
	<bf77cd41-3ae7-629f-6690-34913c7d78f0@openvz.org>
	<CAKVPjOaTYVAz3ek4uMq-XRt9UyEaquN30t2wg2VsoDgaA7=EyQ@mail.gmail.com>
	<26a943da-3487-8d39-85fd-6e176af054e0@openvz.org>
	<20170511183549.GA20777@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <8e366dc1-6c51-5d97-33dd-7390bd762fe5@redhat.com>
Date: Thu, 11 May 2017 14:43:33 -0400
MIME-Version: 1.0
In-Reply-To: <20170511183549.GA20777@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] mirror: add sync mode incremental to
 drive-mirror and blockdev-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Denis V. Lunev" <den@openvz.org>
Cc: =?UTF-8?Q?Daniel_Ku=c4=8dera?= <daniel.kucera@gmail.com>, Kevin Wolf <kwolf@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



On 05/11/2017 02:35 PM, Stefan Hajnoczi wrote:
> Daniel's proposed patch isn't large or invasive.  The QMP interface is
> consistent with the backup block job's sync=bitmap mode, it's a logical
> extension.
> 
> If the concerns about the bitmap lifecycle are addressed and a test case
> is included then I don't see anything preventing this patch from being
> merged.
> 
I agree.

Daniel, I'm preoccupied with some other tasks at the moment, but I will
look over your patch again with an eye for how the bitmap data is
handled on failure cases. Once we agree on a design, we'll need some
basic tests (a success case, and one for each type of unique failure
path) and then we're good to go.

--js
