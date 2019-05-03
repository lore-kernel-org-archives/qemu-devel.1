Received: from eggs.gnu.org ([209.51.188.92]:60628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMWGe-00025w-5o
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMWGc-00051V-QT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:22:16 -0400
References: <20190419154041.77802-1-stephen.checkoway@oberlin.edu>
	<45e6247e-cddb-2185-7f7b-503be00bd453@vivier.eu>
	<f61fc519-da75-5b41-21d0-508cf89016f2@redhat.com>
	<fc4a45ba-08d0-59ba-80eb-10a08cda3b7d@ilande.co.uk>
	<af92f288-7159-b7ad-3360-5c2bb9b392f6@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9920c883-741a-76e9-8d97-f68b65dbcff6@ilande.co.uk>
Date: Fri, 3 May 2019 12:22:08 +0100
MIME-Version: 1.0
In-Reply-To: <af92f288-7159-b7ad-3360-5c2bb9b392f6@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] hw/char/escc: Lower irq
 when transmit buffer is filled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Stephen Checkoway <stephen.checkoway@oberlin.edu>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>, qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 03/05/2019 08:21, Laurent Vivier wrote:

>>> Mark, Artyom, are you OK with this patch?
>>
>> I started testing this with my OpenBIOS test images at the start of the week, but
>> unfortunately got distracted by real life :)
>>
>> I've now finished and confirmed there are no regressions in my local tests, so I'll
>> include this in the PR I am planning to send shortly containing the leon3 updates.
> 
> Hi Mark,
> 
> I've already included a leon3 patch ("hw/sparc/leon3: Allow load of
> uImage firmwares") in the PR I sent yesterday for the trivial branch.
> I've removed from my PR this patch about the ESCC, so you can take it.

Hi Laurent,

Understood, and thanks for looking out for the patch. My first week back has been
quite busy so I'm still playing catch-up here...


ATB,

Mark.
