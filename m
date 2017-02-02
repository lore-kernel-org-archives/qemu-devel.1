Received: from eggs.gnu.org ([2001:4830:134:3::10]:58657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cZDSH-0004Yr-Qh
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cZDSD-00011V-PH
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:13:25 -0500
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<20170202051445.5735-96-david@gibson.dropbear.id.au>
	<922cc254-3d39-c21e-3ac6-7f8bd3b95d90@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b8c77dc9-6083-bf26-3750-f0847ad1d6ed@redhat.com>
Date: Thu, 2 Feb 2017 10:13:16 +0100
MIME-Version: 1.0
In-Reply-To: <922cc254-3d39-c21e-3ac6-7f8bd3b95d90@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 095/107] spapr: clock should count only if
 vm is running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, qemu-ppc@nongnu.org

On 02/02/2017 09:37, Mark Cave-Ayland wrote:
> On 02/02/17 05:14, David Gibson wrote:
> 
...
> Hi David/Laurent,

Hi Mark,

> I just noticed this in your pull request today - this looks like it is
> along similar lines to the prototype patch I proposed last year as part
> of the decrementer migration thread discussion, i.e. use a
> vm_change_state_handler() to sync the clock on pause/resume.
> 
> Am I right in thinking this now solves the timebase migration problem,
> and so the only part required is to encode the decrementer relative to
> the timebase during migration to ensure its value is also migrated
> correctly?

Do you have a link to this thread discussion?

The main purpose of this patch was only to stop the clock (TBR) while
the machine is paused, so I'd like to know what is the problem you are
speaking about.

Thanks,
Laurent
