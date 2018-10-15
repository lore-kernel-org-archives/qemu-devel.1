Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBxLS-0001mp-KW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBxLL-0000NR-0u
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:31:16 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:28592)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBxLK-0000MV-CV
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 03:31:10 -0400
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
	<1e02eee6-de17-6da9-f7bb-4e12fc0b5cc6@redhat.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <0efa8745-b7bf-4459-98b3-99b7b2795d30@cmss.chinamobile.com>
Date: Mon, 15 Oct 2018 15:31:06 +0800
MIME-Version: 1.0
In-Reply-To: <1e02eee6-de17-6da9-f7bb-4e12fc0b5cc6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Fam Zheng <famz@redhat.com>



On 10/15/18 3:07 PM, Thomas Huth wrote:
> On 2018-10-15 08:51, Mao Zhongyi wrote:
>> Various shell files contain a mix between obsolete `` and
>> modern $(); use of `` is only required when using /bin/sh
>> on Solaris. It would be nice to convert to using $()
>> everywhere, or at least in all bash scripts, as well as in
>> all scripts that are known to not be run on Solaris.
> 
> FWIW, I think we do not have to worry about Solaris' /bin/sh here
> anymore. Somebody tried to compile on Solaris a couple of weeks ago, and
> found out that you need a proper POSIX-compliant shell for compiling
> QEMU, so /bin/sh can not be used here anymore anyway.

Thanks for your quick review and clarification. I got it.
In addition, I fount that I didn't  completely replace `` in
git-submodule.sh, so I plan to resend it later.

Thanks,
Mao

> 
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   scripts/archive-source.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
>> index 4e63774f9a..62bd22578b 100755
>> --- a/scripts/archive-source.sh
>> +++ b/scripts/archive-source.sh
>> @@ -18,7 +18,7 @@ if test $# -lt 1; then
>>       error "Usage: $0 <output tarball>"
>>   fi
>>   
>> -tar_file=`realpath "$1"`
>> +tar_file=$(realpath "$1")
>>   list_file="${tar_file}.list"
>>   vroot_dir="${tar_file}.vroot"
>>   
>> @@ -34,7 +34,7 @@ if git diff-index --quiet HEAD -- &>/dev/null
>>   then
>>       HEAD=HEAD
>>   else
>> -    HEAD=`git stash create`
>> +    HEAD=$(git stash create)
>>   fi
>>   git clone --shared . "$vroot_dir"
>>   test $? -ne 0 && error "failed to clone into '$vroot_dir'"
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
