Received: from eggs.gnu.org ([2001:4830:134:3::10]:57211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drxKm-0001yH-RY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 22:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1drxKj-0000iu-FD
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 22:23:24 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1drxKj-0000gE-AU
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 22:23:21 -0400
Received: by mail-pg0-x243.google.com with SMTP id m30so2036013pgn.5
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 19:23:20 -0700 (PDT)
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box> <20170912162100.GD2225@work-vm>
	<1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
	<4f0cb74a-ae00-5921-291c-49c9acdb3e02@ilande.co.uk>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d7dd9adf-4727-aeb5-b8ad-ac8c22c2f4bf@ozlabs.ru>
Date: Wed, 13 Sep 2017 12:23:13 +1000
MIME-Version: 1.0
In-Reply-To: <4f0cb74a-ae00-5921-291c-49c9acdb3e02@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 13/09/17 02:46, Mark Cave-Ayland wrote:
> On 12/09/17 17:41, Mark Cave-Ayland wrote:
> 
>> The commit message mentions that prior to the conversion some CPU state
>> was missing but it doesn't mention anything about dropping existing
>> fields as part of the conversion process so I suspect that this was an
>> accidental side-effect.
> 
> Actually I've clicked send a little too early here since re-reading the
> last paragraph of a90db15 I can see the inference here: "Exactly what
> needs to be saved in what configurations has been more carefully
> examined, too".
> 
> Alexey - do you recall from your analysis why these fields were no
> longer deemed necessary, and how your TCG tests were configured?

I most certainly did not do analysis (my bad. sorry) - I took the patch
from David as he left the team, fixed to compile and pushed away. I am also
very suspicions we did not try migrating TCG or anything but pseries. My
guest that things did not break (if they did not which I am not sure about,
for the TCG case) because the interrupt controller (XICS) or the
pseries-guest took care of resending an interrupt which does not seem to be
the case for mac99.


-- 
Alexey
