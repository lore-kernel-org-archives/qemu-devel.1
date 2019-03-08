Received: from eggs.gnu.org ([209.51.188.92]:56919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2IT6-0006GZ-8V
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2ISz-0005kg-Ul
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:35:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2ISz-0005h7-MI
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:35:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id c13so9322244wmb.0
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 08:35:25 -0800 (PST)
References: <cover.1551902740.git.balaton@eik.bme.hu>
	<12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
	<c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
	<20190308073206.qd3efvlxgeos45np@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903081718580.52464@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7005c46c-e22a-a4ba-9c4d-30cf0fadb5f5@redhat.com>
Date: Fri, 8 Mar 2019 17:35:23 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1903081718580.52464@zero.eik.bme.hu>
Content-Type: text/plain; charset=windows-1252
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
To: BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/8/19 5:22 PM, BALATON Zoltan wrote:
> On Fri, 8 Mar 2019, Gerd Hoffmann wrote:
>> On Thu, Mar 07, 2019 at 01:32:41AM +0100, Philippe Mathieu-DaudÈ wrote:
>>> On 3/6/19 9:05 PM, BALATON Zoltan wrote:
>>>> Add (partial) emulation of the on-board GPU of the machine. This
>>>> allows the PMON2000 firmware to run and should also work with Linux
>>>> console but probably not with X yet.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Reviewed-by: Philippe Mathieu-Daud√© <philmd@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daud√© <philmd@redhat.com>
>>>
>>> Mojibaked again :(
>>
>> Mail was sent without Content-Type: header.† Both mutt and "git am" on
>> my machine assume utf-8 and everything looks fine.† I guess your mail
>> client assumes something else ...
> 
> So it came out good at the end but that depends on what maintainer's
> config does by default it seems.
> 
>> "git send-email" should send the patches with correct headers, it even
>> asks for the charset it should use in case it finds non-ascii
>> characters.† So BALATON, could you check your mail client config, or
>> switch over to "git send-email" for submitting patches?
> 
> I'm sending what git format-patch is generating and that does not add
> content type header by default. Is there a config option to enable that?
> I can't use git send-email because I'm sending from different machine
> than I use git on.

On another thread Laurent Vivier found it is a copy/paste problem
between an email client and an editor (IIUC):
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03669.html

Laurent, if you understood what's wrong, can you add en entry in the
wiki so we can refer contributors to it?

Thanks,

Phil.
