Received: from eggs.gnu.org ([2001:4830:134:3::10]:49387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fbiIn-000676-1r
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 04:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fbiIj-0001wP-T2
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 04:10:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fbiIj-0001vZ-AL
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 04:10:41 -0400
References: <20180702151023.24532-1-shorne@gmail.com>
	<20180702151023.24532-23-shorne@gmail.com>
	<feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
	<CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
	<43d6bc18-440a-31e9-f055-8d0b14cbc74e@linaro.org>
	<b31d8ace-fb05-0748-ba21-9daf97350af6@redhat.com>
	<20180706230236.GV24595@lianli.shorne-pla.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <55935a1a-8f01-2411-18ec-70a537e69bea@vivier.eu>
Date: Sat, 7 Jul 2018 10:10:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180706230236.GV24595@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 22/25] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

Le 07/07/2018 à 01:02, Stafford Horne a écrit :
> On Fri, Jul 06, 2018 at 05:22:15PM -0500, Eric Blake wrote:
>> On 07/04/2018 03:54 PM, Richard Henderson wrote:
>>> On 07/03/2018 04:51 PM, Stafford Horne wrote:
>>>> Richard, how do you usually remove these before your pr?  I suppose you have
>>>> some kind of script?
>>>
>>> No, I just edit the things by hand.
>>
>> I do it by always using 'git am' to suck in patches from the mailing list,
>> including my own patches, and even if I already have the patch locally.
>> That is, my workflow for PR bypasses my local work tree to ensure I don't
>> leave local artifacts around in the PR.
> 
> Hi Eric,
> 
> How do you carry the Change list for each patch brought in with 'git am' i.e.
> v2,v3 when you have updates that need respin?  Do you just update that manually
> on the .patch files after 'git format-patch'?
> 
> I found and tried `git notes` recently which seems to be meant for this.
> 
> From 'git help notes'
> 
>    Notes can also be added to patches prepared with git format-patch by
>    using the --notes option. Such notes are added as a patch commentary
>    after a three dash separator line.
> 
> However, I found the notes get lots pretty easily during rebases and would not
> survive a 'git am'.

You need to set notes.rewriteref=refs/notes/commits

Thanks,
Laurent
