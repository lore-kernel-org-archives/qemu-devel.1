Received: from eggs.gnu.org ([209.51.188.92]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gou8C-0002qb-HT
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gou8A-0004KG-Jq
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:58:36 -0500
References: <20190114162605.5330-1-eblake@redhat.com>
	<20190114162605.5330-12-eblake@redhat.com>
	<20190130172734.GB892@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <eca08cfe-dc79-9356-5923-63d43c16d1db@redhat.com>
Date: Wed, 30 Jan 2019 12:58:19 -0500
MIME-Version: 1.0
In-Reply-To: <20190130172734.GB892@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 11/20] iotests: add iotest 236 for testing
 bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>



On 1/30/19 12:27 PM, Kevin Wolf wrote:
> Am 14.01.2019 um 17:25 hat Eric Blake geschrieben:
>> From: John Snow <jsnow@redhat.com>
>>
>> New interface, new smoke test.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20181221093529.23855-12-jsnow@redhat.com>
>> [eblake: fix last-minute change to echo text]
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> This test fails for me (with Python 3) because I get a different dict
> order.
> 
> Probably related to the OrderedDict that qmp_log() uses, so log() uses
> sort_keys=False and the unordered dicts that are contained in the outer
> OrderedDict stay unordered.
> 
> Kevin
> 

Gurg. Sorry, apparently Python is hard. Will fix.
