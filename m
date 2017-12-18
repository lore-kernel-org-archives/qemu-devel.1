Received: from eggs.gnu.org ([2001:4830:134:3::10]:49183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eQqDx-00033s-4m
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eQqDu-0001Oo-21
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:52:33 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:50065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eQqDt-0001N1-OP
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 02:52:29 -0500
References: <20171121064106.13721-1-ybettan@redhat.com>
	<fe42e8d1-afde-f761-9780-b1a8f7d4030f@vivier.eu>
	<64af419e-b8b8-0a05-21f7-1029bc809079@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0843d1d9-e015-f4bd-3a98-92c0e3db5b42@vivier.eu>
Date: Mon, 18 Dec 2017 08:52:01 +0100
MIME-Version: 1.0
In-Reply-To: <64af419e-b8b8-0a05-21f7-1029bc809079@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl.c && linux-user/main.c : removed **envp
 from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>

Le 18/12/2017 à 07:07, Yoni Bettan a écrit :
> 
> 
> On 11/21/2017 09:30 AM, Laurent Vivier wrote:
>> Le 21/11/2017 à 07:41, Yoni Bettan a écrit :
>>>          * it was added on 2008 902b3d5c392bb6f48ef340ad8ecc3311705d2800
>>>            when introduced cache-utils.[ch]
>>>          * since then cache-utils.[ch] were removed but **envp was left
>>>            behind
>>>
>>> Signed-off-by: Yoni Bettan <ybettan@redhat.com>
>>> ---
>>>   linux-user/main.c | 2 +-
>>>   vl.c              | 6 +++---
>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/linux-user/main.c b/linux-user/main.c
>>> index aa02f25b85..ca5628c1ca 100644
>>> --- a/linux-user/main.c
>>> +++ b/linux-user/main.c
>>> @@ -4233,7 +4233,7 @@ static int parse_args(int argc, char **argv)
>>>       return optind;
>>>   }
>>>   -int main(int argc, char **argv, char **envp)
>>> +int main(int argc, char **argv)
>>>   {
>>>       struct target_pt_regs regs1, *regs = &regs1;
>>>       struct image_info info1, *info = &info1;
>>> diff --git a/vl.c b/vl.c
>>> index 1ad1c04637..9667756ccc 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -35,10 +35,10 @@
>>>   #ifdef CONFIG_SDL
>>>   #if defined(__APPLE__) || defined(main)
>>>   #include <SDL.h>
>>> -int qemu_main(int argc, char **argv, char **envp);
>>> +int qemu_main(int argc, char **argv);
>>>   int main(int argc, char **argv)
>>>   {
>>> -    return qemu_main(argc, argv, NULL);
>>> +    return qemu_main(argc, argv);
>>>   }
>>>   #undef main
>>>   #define main qemu_main
>> I think this part can be removed now. As it seems it has been added
>> because of the envp parameter.
> 
> Thanks Laurent for your response and sorry for my late response.
> I think this part was added for another purpose as described here
> 880fec5d086
> 
> As i see it the env param was added in 2008 in order to support cache-utils
> as shown in 902b3d5c392bb6f48ef340ad8ecc3311705d2800 and in 2009
> another main function was added in order to unbreak SDL on Mac-OS X and
> the env param
> was added only for consistency I suppose...
> 
> What do you think?

I think we don't need it anymore as there is no difference betweent
qemu_main() and main().

Thanks,
Laurent
