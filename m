Received: from eggs.gnu.org ([2001:4830:134:3::10]:34190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfBN7-0004iG-Ub
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dfBN3-00043k-0T
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:45:02 -0400
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-4-jsnow@redhat.com>
	<45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1b8cd52e-c12d-533d-a01c-a5602b5bc942@redhat.com>
Date: Tue, 8 Aug 2017 16:44:51 -0400
MIME-Version: 1.0
In-Reply-To: <45a96c91-8261-d1f7-e312-3d872051e7d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org



On 08/08/2017 04:30 PM, Eric Blake wrote:
> On 08/08/2017 01:33 PM, John Snow wrote:
>> To be used sparingly, but still interesting in the case of small
>> firmwares designed to reproduce bugs in QEMU IDE.
> 
> Is that because the trace would fire so frequently in normal usage that
> it will drown the user in noise?
> 

Yeah, and it's of little use for a real guest due to the volume and
relative unimportance of what that data actually is

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/core.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
