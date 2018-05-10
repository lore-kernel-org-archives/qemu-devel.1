Received: from eggs.gnu.org ([2001:4830:134:3::10]:35076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGqb2-00027P-Ol
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGqaz-0005pH-MK
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:47:20 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGqaz-0005ow-Gh
	for qemu-devel@nongnu.org; Thu, 10 May 2018 14:47:17 -0400
Received: by mail-qk0-x22f.google.com with SMTP id c137-v6so2392104qkg.2
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 11:47:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <1513160272-15921-1-git-send-email-christian.ehrhardt@canonical.com>
	<CAATJJ0+snukR5zqeL4v3B+YfcVP8jwxjgjfV6pupeJpoGCeHfA@mail.gmail.com>
	<CAATJJ0KK3Ya1RMyAjPDyYOQHbo+2xoWDbnVNup1Yop8Og00eBw@mail.gmail.com>
	<d0b421e2-2c0b-db08-5f6e-d05e11bbc007@amsat.org>
Message-ID: <791e86e2-c278-13cf-0c3a-05b53e30aa08@amsat.org>
Date: Thu, 10 May 2018 15:47:12 -0300
MIME-Version: 1.0
In-Reply-To: <d0b421e2-2c0b-db08-5f6e-d05e11bbc007@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu-guest-agent: freeze-hook to ignore
 dpkg files as well
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Paolo,

On 04/24/2018 10:01 PM, Philippe Mathieu-Daudé wrote:
> Hi Christian,
> 
> On 04/09/2018 04:18 AM, Christian Ehrhardt wrote:
>> Re-Ping for consideration?
>>
>> On Mon, Jan 22, 2018 at 3:03 PM, Christian Ehrhardt <
>> christian.ehrhardt@canonical.com> wrote:
>>
>>> Hi,
>>> maybe I missed a formal thing on this submission, but I don't see it right
>>> away.
> 
> You missed to Cc the maintainer of this file:
> 
> $ ./scripts/get_maintainer.pl -f scripts/qemu-guest-agent/fsfreeze-hook
> Michael Roth <mdroth@linux.vnet.ibm.com> (maintainer:QEMU Guest Agent)
> 
> (I Cc'ed him).
> 
> See https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
> 
>>> So for now just a ping on any updates in regard to accept this?
>>>
>>> On Wed, Dec 13, 2017 at 11:17 AM, Christian Ehrhardt
>>> <christian.ehrhardt@canonical.com> wrote:
>>>> The hook already skips a set of rpm upgrade artifacts.
>>>> Do the same with such files that might be created by dpkg.
>>>>
>>>> Fixes: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1484990
>>>>
>>>> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Can you take this patch via your MISC tree?

>>>> ---
>>>>  scripts/qemu-guest-agent/fsfreeze-hook | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
>>> b/scripts/qemu-guest-agent/fsfreeze-hook
>>>> index c27b29f..13aafd4 100755
>>>> --- a/scripts/qemu-guest-agent/fsfreeze-hook
>>>> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
>>>> @@ -13,7 +13,7 @@ FSFREEZE_D=$(dirname -- "$0")/fsfreeze-hook.d
>>>>  # Check whether file $1 is a backup or rpm-generated file and should be
>>> ignored
>>>>  is_ignored_file() {
>>>>      case "$1" in
>>>> -        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave |
>>> *.sample)
>>>> +        *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave |
>>> *.sample | *.dpkg-old | *.dpkg-new | *.dpkg-tmp | *.dpkg-dist | *.dpkg-bak
>>> | *.dpkg-backup | *.dpkg-remove)
>>>>              return 0 ;;
>>>>      esac
>>>>      return 1
>>>> --
>>>> 2.7.4
