Received: from eggs.gnu.org ([2001:4830:134:3::10]:53485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g86cr-0006hD-BN
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g86co-00067C-LH
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:37:21 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-7-crosa@redhat.com>
	<4f0850d2-3baa-7acc-d34b-98f074f1a2f8@vivier.eu>
	<50e4aeaa-7f4f-03b3-05ae-2a29deac9662@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <72ee2b27-cdcc-5cfd-ae71-8dfe95a595ac@vivier.eu>
Date: Thu, 4 Oct 2018 18:36:51 +0200
MIME-Version: 1.0
In-Reply-To: <50e4aeaa-7f4f-03b3-05ae-2a29deac9662@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/10] thunk.c: clean up commented out
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Le 04/10/2018 à 18:31, Cleber Rosa a écrit :
> 
> 
> On 10/4/18 12:24 PM, Laurent Vivier wrote:
>> Le 04/10/2018 à 18:18, Cleber Rosa a écrit :
>>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>>> ---
>>>  thunk.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/thunk.c b/thunk.c
>>> index d5d8645cd4..e351ae53af 100644
>>> --- a/thunk.c
>>> +++ b/thunk.c
>>> @@ -21,8 +21,6 @@
>>>  #include "qemu.h"
>>>  #include "exec/user/thunk.h"
>>>  
>>> -//#define DEBUG
>>> -
>>
>> Generally we use that to enable easily existing debug traces.
>>
> 
> Oh, I wasn't aware that was intentional (I clearly lack some background
> here).
> 
>> In this case, if you remove the "#define" I think you should also
>> replace the "#ifdef DEBUG"s by some trace_XXXX() functions.
>>
> 
> Is that desirable? I don't want to disrupt the status quo just because
> it looked odd to me.

Yes, it's better to have trace_XXX() functions than DEBUG macros. The
change is trivial (add the format strings in ./trace-events and call
them from thunk.c with the existing parameters)

Thanks,
Laurent
