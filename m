Received: from eggs.gnu.org ([2001:4830:134:3::10]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1droKF-0005gd-BE
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1droKE-00043S-L8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:46:15 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box> <20170912162100.GD2225@work-vm>
	<1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
Message-ID: <4f0cb74a-ae00-5921-291c-49c9acdb3e02@ilande.co.uk>
Date: Tue, 12 Sep 2017 17:46:00 +0100
MIME-Version: 1.0
In-Reply-To: <1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 12/09/17 17:41, Mark Cave-Ayland wrote:

> The commit message mentions that prior to the conversion some CPU state
> was missing but it doesn't mention anything about dropping existing
> fields as part of the conversion process so I suspect that this was an
> accidental side-effect.

Actually I've clicked send a little too early here since re-reading the
last paragraph of a90db15 I can see the inference here: "Exactly what
needs to be saved in what configurations has been more carefully
examined, too".

Alexey - do you recall from your analysis why these fields were no
longer deemed necessary, and how your TCG tests were configured?


ATB,

Mark.
