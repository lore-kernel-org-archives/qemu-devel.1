Received: from eggs.gnu.org ([2001:4830:134:3::10]:48922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWNCN-0008PD-Hy
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWNCI-0007np-11
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:01:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:49764)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWNCH-0007nL-RD
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:01:09 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071724.4572.85855.stgit@PASHA-ISP>
	<5500e05f-2923-3378-aa42-600cf0c4bf9b@redhat.com>
	<000801d27701$7424d810$5c6e8830$@ru>
	<1cab1a55-15cf-e9dc-f137-e55b613bd090@redhat.com>
In-Reply-To: <1cab1a55-15cf-e9dc-f137-e55b613bd090@redhat.com>
Date: Wed, 25 Jan 2017 16:01:11 +0300
Message-ID: <000a01d2770b$1ab2d980$50188c80$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v7 05/14] apic: save apic_delivered flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 25/01/2017 12:52, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> >> On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
> >>> This patch implements saving/restoring of static apic_delivered variable.
> >>>
> >>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >>> ---
> >>>  hw/intc/apic_common.c           |   32 ++++++++++++++++++++++++++++++++
> >>>  include/hw/i386/apic_internal.h |    2 ++
> >>>  2 files changed, 34 insertions(+)
> >>>
> >>> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> >>> index d78c885..ac6cc67 100644
> >>> --- a/hw/intc/apic_common.c
> >>> +++ b/hw/intc/apic_common.c
> >>> @@ -384,6 +384,24 @@ static bool apic_common_sipi_needed(void *opaque)
> >>>      return s->wait_for_sipi != 0;
> >>>  }
> >>>
> >>> +static bool apic_irq_delivered_needed(void *opaque)
> >>> +{
> >>> +    return true;
> >>
> >> Is it needed for CPUs except the first (or the last?)?
> >>
> >
> > As this is global variable, it is needed only for one CPU.
> > Do you mean that APIC state is saved for every CPU?
> 
> Yes, each CPU has its own APIC.

How to link this data to a single CPU?

Pavel Dovgalyuk
