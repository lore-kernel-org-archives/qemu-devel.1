Received: from eggs.gnu.org ([209.51.188.92]:58341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2IYm-0000W2-Kx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2IYj-00059n-L3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:41:23 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:33573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h2IYg-0004u5-5U
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:41:20 -0500
References: <cover.1551902740.git.balaton@eik.bme.hu>
	<12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
	<c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
	<20190308073206.qd3efvlxgeos45np@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903081718580.52464@zero.eik.bme.hu>
	<7005c46c-e22a-a4ba-9c4d-30cf0fadb5f5@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c4b00c71-a429-a48f-b861-3cedc63da2d9@vivier.eu>
Date: Fri, 8 Mar 2019 17:40:51 +0100
MIME-Version: 1.0
In-Reply-To: <7005c46c-e22a-a4ba-9c4d-30cf0fadb5f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5-resend 2/2] mips_fulong2e: Add on-board
 graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

Le 08/03/2019 à 17:35, Philippe Mathieu-Daudé a écrit :
> On 3/8/19 5:22 PM, BALATON Zoltan wrote:
>> On Fri, 8 Mar 2019, Gerd Hoffmann wrote:
>>> On Thu, Mar 07, 2019 at 01:32:41AM +0100, Philippe Mathieu-Daudé wrote:
>>>> On 3/6/19 9:05 PM, BALATON Zoltan wrote:
>>>>> Add (partial) emulation of the on-board GPU of the machine. This
>>>>> allows the PMON2000 firmware to run and should also work with Linux
>>>>> console but probably not with X yet.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Reviewed-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
>>>>> Tested-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
>>>>
>>>> Mojibaked again :(
>>>
>>> Mail was sent without Content-Type: header.  Both mutt and "git am" on
>>> my machine assume utf-8 and everything looks fine.  I guess your mail
>>> client assumes something else ...
>>
>> So it came out good at the end but that depends on what maintainer's
>> config does by default it seems.
>>
>>> "git send-email" should send the patches with correct headers, it even
>>> asks for the charset it should use in case it finds non-ascii
>>> characters.  So BALATON, could you check your mail client config, or
>>> switch over to "git send-email" for submitting patches?
>>
>> I'm sending what git format-patch is generating and that does not add
>> content type header by default. Is there a config option to enable that?
>> I can't use git send-email because I'm sending from different machine
>> than I use git on.
> 
> On another thread Laurent Vivier found it is a copy/paste problem
> between an email client and an editor (IIUC):
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03669.html
> 
> Laurent, if you understood what's wrong, can you add en entry in the
> wiki so we can refer contributors to it?

No sure. My guess is a cut'n'paste between two windows with different
charsets doesn't work because the buffer keeps the char encoding of the
first window and put them as raw binaries in the second one, so it
encodes something else.

Thanks,
Laurent
