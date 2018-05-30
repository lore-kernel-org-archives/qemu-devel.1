Received: from eggs.gnu.org ([2001:4830:134:3::10]:58596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNyjT-0004Re-8I
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNyjQ-0002dN-4o
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fNyjP-0002d4-W3
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:53:28 -0400
Date: Wed, 30 May 2018 12:53:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180530125324.1c727415@redhat.com>
In-Reply-To: <70c781bc-7982-0450-2b2d-abbf49b4cfa8@redhat.com>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-3-peter.maydell@linaro.org>
	<20180530121131.17c8bee0@redhat.com>
	<70c781bc-7982-0450-2b2d-abbf49b4cfa8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/i386: Rename 2.13 machine types to
 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, guangrong.xiao@linux.intel.com, David Gibson <david@gibson.dropbear.id.au>

On Wed, 30 May 2018 12:19:59 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 30/05/2018 12:11, Igor Mammedov wrote:
> > -    Name (MEMA, 0x07FFE000)
> > +    Name (MEMA, 0x07FFF000)
> >  }
Michael, could you update ACPI test blobs in your next pull request please?


> > As far as I see it should safe wrt NVDIMMs,
> > but the question is what in this commit forced Seabios
> > to change allocated address?  
> 
> Probably 2.13 is longer than 3.0 or something like that
looks like it's other way around (2.13 is shorter than 3.0)
since address went up.

> (and the planets aligned in the right way).
probably not the case considering that warning reproduces
the same regardless of day and time changes. :)

> 
> Paolo
