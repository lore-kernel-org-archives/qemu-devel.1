Received: from eggs.gnu.org ([2001:4830:134:3::10]:34300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIbsv-0005Pf-Ai
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIbss-0007lg-6V
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:29:05 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43067)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fIbsr-0007lD-Rr
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:29:02 -0400
References: <1526383058-49501-1-git-send-email-imammedo@redhat.com>
	<7dd6b2d6-73f8-706e-9083-884ce478d784@vivier.eu>
	<20180515162246.6fd3616e@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8306c2d3-e8e6-f6b9-39c5-6922c10b52eb@vivier.eu>
Date: Tue, 15 May 2018 17:28:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180515162246.6fd3616e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: update comments to point to
 cpu_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi

Le 15/05/2018 à 16:22, Igor Mammedov a écrit :
> On Tue, 15 May 2018 13:32:33 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> Le 15/05/2018 à 13:17, Igor Mammedov a écrit :
>>> cpu_init() was replaced by cpu_create() since 2.12 but comments
>>> weren't updated. So update stale comments now.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  bsd-user/main.c   | 2 +-
>>>  linux-user/main.c | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/bsd-user/main.c b/bsd-user/main.c
>>> index 283dc6f..a6ef4a7 100644
>>> --- a/bsd-user/main.c
>>> +++ b/bsd-user/main.c
>>> @@ -917,7 +917,7 @@ int main(int argc, char **argv)
>>>      envlist_free(envlist);
>>>  
>>>      /*
>>> -     * Now that page sizes are configured in cpu_init() we can do
>>> +     * Now that page sizes are configured in cpu_create() we can do
>>>       * proper page alignment for guest_base.
>>>       */
>>>      guest_base = HOST_PAGE_ALIGN(guest_base);
>>> diff --git a/linux-user/main.c b/linux-user/main.c
>>> index 3234754..27d0b37 100644
>>> --- a/linux-user/main.c
>>> +++ b/linux-user/main.c
>>> @@ -693,7 +693,7 @@ int main(int argc, char **argv, char **envp)
>>>      envlist_free(envlist);
>>>  
>>>      /*
>>> -     * Now that page sizes are configured in cpu_init() we can do
>>> +     * Now that page sizes are configured in cpu_create() we can do
>>>       * proper page alignment for guest_base.
>>>       */
>>>      guest_base = HOST_PAGE_ALIGN(guest_base);
>>>   
>>
>> I think page size is now configured in tcg_exec_init() since:
> Should we drop this comments altogether?

No, I think you can update your patch with:

-     * Now that page sizes are configured in cpu_init() we can do
+     * Now that page sizes are configured in tcg_exec_init() we can do

Even if it's not related anymore with cpu_create()...

but you should also update the comment between tcg_exec_init() and
cpu_create() and move it before tcg_exec_init().

I think it's good to know we can't use HOST_PAGE_ALIGN() before
qemu_host_page_size is set in tcg_exec_init().

Thanks,
Laurent
