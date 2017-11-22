Received: from eggs.gnu.org ([2001:4830:134:3::10]:34256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHXD7-0005ah-W3
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eHXD7-0006Bx-7D
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:45:14 -0500
References: <20171122001656.12996-1-jsnow@redhat.com>
	<1cc87e18-67f9-2ec5-a2a6-78e93dfbe462@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0aced134-ec01-2643-ca2a-ead5f965bdae@redhat.com>
Date: Wed, 22 Nov 2017 10:45:04 -0500
MIME-Version: 1.0
In-Reply-To: <1cc87e18-67f9-2ec5-a2a6-78e93dfbe462@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 075 and 078
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com



On 11/21/2017 09:07 PM, Eric Blake wrote:
> On 11/21/2017 06:16 PM, John Snow wrote:
>> Both of these tests are for formats which now stipulate that they are
>> read-only. Adjust the tests to match.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/qemu-iotests/075 | 18 +++++++++---------
>>  tests/qemu-iotests/078 | 14 +++++++-------
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Safe for 2.11, although now that -rc2 is out, it's also okay if this
> slips into 2.12.
> 

Yes, I just wanted to address the test suite prior to release. Whether
or not other people agree on that being important is another matter :)

Thanks
--js
