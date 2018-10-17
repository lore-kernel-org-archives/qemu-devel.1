Received: from eggs.gnu.org ([2001:4830:134:3::10]:47199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCb0h-0001dJ-2j
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCb0d-0004gT-2f
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:52:31 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:52111)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCb0c-0004dC-Ev
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:52:27 -0400
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
	<17897835-a1b1-12bd-a0ef-f39d900b59ce@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <5f8166a6-0bd3-74d9-3908-49641d81abf2@cmss.chinamobile.com>
Date: Wed, 17 Oct 2018 09:52:16 +0800
MIME-Version: 1.0
In-Reply-To: <17897835-a1b1-12bd-a0ef-f39d900b59ce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] archive-source.sh: Modern
 shellscripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hi, Eric

On 10/15/18 11:44 PM, Eric Blake wrote:
> On 10/15/18 1:51 AM, Mao Zhongyi wrote:
>> Various shell files contain a mix between obsolete `` and
>> modern $(); use of `` is only required when using /bin/sh
>> on Solaris. It would be nice to convert to using $()
>> everywhere, or at least in all bash scripts, as well as in
>> all scripts that are known to not be run on Solaris.
> 
> Did you have a particular program you used to find these, or just grep?

Just grep in scripts dir, I also entered the file to make sure I didn't 
missing anything. In addition, I will send a separated patch to replace 
all obsolete `` in the source tree.

> 
> Also, when sending a series, don't forget a 0/3 cover letter.
>

OK, I see. :)
  Thanks,
Mao

>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   scripts/archive-source.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
