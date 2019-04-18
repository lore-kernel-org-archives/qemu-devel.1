Received: from eggs.gnu.org ([209.51.188.92]:37464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGz1x-0004lq-N1
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGz1w-0002jn-Nw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 00:52:13 -0400
Date: Thu, 18 Apr 2019 01:52:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418045208.GE25134@habkost.net>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] linux-user: Use lookup_cpu_class()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, Apr 16, 2019 at 11:59:42PM -0300, Eduardo Habkost wrote:
> The return value of cpu_get_model() is just a CPU model name and
> never includes extra options.  We don't need to call
> parse_cpu_option().

Oops.  I was wrong.  linux-user also supports extra features in
the "-cpu" option, so we do need to call parse_cpu_option().

e.g.: this worked before:

  $ qemu-x86_64 -cpu Nehalem,+popcnt /bin/true

and now this is broken:

  $ qemu-x86_64 -cpu Nehalem,+popcnt /bin/true
  unable to find CPU model 'Nehalem,+popcnt'

I will drop patches 2-5 from my queue.  Sorry for the noise.

-- 
Eduardo
