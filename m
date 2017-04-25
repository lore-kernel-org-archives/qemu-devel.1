Received: from eggs.gnu.org ([2001:4830:134:3::10]:59625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d31RN-00074n-9r
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d31RK-0002wd-68
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:27:41 -0400
References: <20170425131828.22480-1-n54@gmx.com>
	<CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f2327f24-0503-4a45-e361-9f18ff00bc22@redhat.com>
Date: Tue, 25 Apr 2017 16:27:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-PmbjRYb2EDDp60pKNnUQ8Rkdx79TTLgUMf_VRe2JT+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH]
 scripts/qemu-binfmt-conf.sh: Fix shell portability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25/04/2017 15:33, Peter Maydell wrote:
> On 25 April 2017 at 14:18, Kamil Rytarowski <n54@gmx.com> wrote:
>> Appease pkgsrc and use portable shell variable comparison.
>> This switches "==" to "=". It should not be a functional change.
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> ---
> 
> Thanks for this patch; it's an easy bug to let slip in
> if your /bin/sh happens to be bash.
> 
> PS: you forgot to cc qemu-devel@ on this patch.
> 
>>  scripts/qemu-binfmt-conf.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
>> index 0f1aa63872..8afc3eb5bb 100755
>> --- a/scripts/qemu-binfmt-conf.sh
>> +++ b/scripts/qemu-binfmt-conf.sh
>> @@ -284,12 +284,12 @@ while true ; do
>>          shift
>>          # check given cpu is in the supported CPU list
>>          for cpu in ${qemu_target_list} ; do
>> -            if [ "$cpu" == "$1" ] ; then
>> +            if [ "$cpu" = "$1" ] ; then
>>                  break
>>              fi
>>          done
>>
>> -        if [ "$cpu" == "$1" ] ; then
>> +        if [ "$cpu" = "$1" ] ; then
>>              qemu_target_list="$1"
>>          else
>>              echo "ERROR: unknown CPU \"$1\"" 1>&2
>> --
>> 2.12.2
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
