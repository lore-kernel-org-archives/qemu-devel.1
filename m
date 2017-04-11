Received: from eggs.gnu.org ([2001:4830:134:3::10]:60058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxxOZ-0007Px-C1
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxxOY-00065D-Dl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:07:51 -0400
References: <20170411145050.31290-1-mreitz@redhat.com>
	<20170411145849.GO4516@noname.str.redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <ec159701-4d77-7dfa-2909-b544391cf513@redhat.com>
Date: Tue, 11 Apr 2017 17:07:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170411145849.GO4516@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block/io: Comment out permission
 assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On 11/04/2017 16:58, Kevin Wolf wrote:
> Am 11.04.2017 um 16:50 hat Max Reitz geschrieben:
>> In case of block migration, there may be writes to BlockBackends that do
>> not have the write permission taken. Before this issue is fixed (which
>> is not going to happen in 2.9), we therefore cannot assert that this is
>> the case.
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> 
> I tested block migration (migrate -b). Leaving postcopy migration, which
> is apparently also broken, to Laurent.
> 
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Tested-by: Kevin Wolf <kwolf@redhat.com>
> 

With postcopy migration

Tested-by: Laurent Vivier <lvivier@redhat.com>
