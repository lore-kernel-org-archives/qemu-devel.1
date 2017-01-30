Received: from eggs.gnu.org ([2001:4830:134:3::10]:36772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cYDnQ-0006Ht-GG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cYDnL-0000et-Fo
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:23:08 -0500
References: <20170130145025.26475-1-david@redhat.com>
	<89891b01-8d50-98ac-c26c-2a769b22b400@weilnetz.de>
	<CAFEAcA86o3ohxZj0qqHKSxqxmo1mCtwKPa_j78xdO2izynEopA@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <2d18251c-395e-641e-30d1-e44d7be9c012@weilnetz.de>
Date: Mon, 30 Jan 2017 16:23:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86o3ohxZj0qqHKSxqxmo1mCtwKPa_j78xdO2izynEopA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: use "qemu" cpu model in user
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Riku Voipio <riku.voipio@iki.fi>, pkg-qemu-devel@lists.alioth.debian.org, qemu-stable <qemu-stable@nongnu.org>

Am 30.01.2017 um 16:11 schrieb Peter Maydell:
> On 30 January 2017 at 15:09, Stefan Weil <sw@weilnetz.de> wrote:
>> Am 30.01.2017 um 15:50 schrieb David Hildenbrand:
>>> "any" does not exist, therefore resulting in a misleading error message.
>>>
>>> Reported-by: Stefan Weil <sw@weilnetz.de>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  linux-user/main.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/linux-user/main.c b/linux-user/main.c
>>> index 3004958..e588f58 100644
>>> --- a/linux-user/main.c
>>> +++ b/linux-user/main.c
>>> @@ -4322,6 +4322,8 @@ int main(int argc, char **argv, char **envp)
>>>  # endif
>>>  #elif defined TARGET_SH4
>>>          cpu_model = TYPE_SH7785_CPU;
>>> +#elif defined TARGET_S390X
>>> +        cpu_model = "qemu";
>>>  #else
>>>          cpu_model = "any";
>>>  #endif
>>
>> Thanks.
>>
>> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>>
>> This fix is also needed for Debian's QEMU user emulation.
> Does it merit a cc: qemu-stable ?
>
> thanks
> -- PMM

Yes, of course. Thanks for the reminder - I added that list now as cc.
