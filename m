Received: from eggs.gnu.org ([209.51.188.92]:52545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2IGA-0006B0-4w
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2IG9-0001Sy-3P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:22:10 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:30994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h2IG8-0001QL-N2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:22:09 -0500
Date: Fri, 8 Mar 2019 17:22:06 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190308073206.qd3efvlxgeos45np@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1903081718580.52464@zero.eik.bme.hu>
References: <cover.1551902740.git.balaton@eik.bme.hu>
	<12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
	<c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
	<20190308073206.qd3efvlxgeos45np@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Fri, 8 Mar 2019, Gerd Hoffmann wrote:
> On Thu, Mar 07, 2019 at 01:32:41AM +0100, Philippe Mathieu-Daud=E9 wrot=
e:
>> On 3/6/19 9:05 PM, BALATON Zoltan wrote:
>>> Add (partial) emulation of the on-board GPU of the machine. This
>>> allows the PMON2000 firmware to run and should also work with Linux
>>> console but probably not with X yet.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> Mojibaked again :(
>
> Mail was sent without Content-Type: header.  Both mutt and "git am" on
> my machine assume utf-8 and everything looks fine.  I guess your mail
> client assumes something else ...

So it came out good at the end but that depends on what maintainer's=20
config does by default it seems.

> "git send-email" should send the patches with correct headers, it even
> asks for the charset it should use in case it finds non-ascii
> characters.  So BALATON, could you check your mail client config, or
> switch over to "git send-email" for submitting patches?

I'm sending what git format-patch is generating and that does not add=20
content type header by default. Is there a config option to enable that? =
I=20
can't use git send-email because I'm sending from different machine than =
I=20
use git on.

Regards,
BALATON Zoltan
