Received: from eggs.gnu.org ([209.51.188.92]:53521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGxpm-0004IJ-1Q
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGxpl-0000Ts-0I
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 23:35:34 -0400
Date: Thu, 18 Apr 2019 00:35:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418033527.GD25134@habkost.net>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<87sguhyykr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sguhyykr.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] Remove qdev_get_machine() call from
 ppc_cpu_parse_featurestr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Wed, Apr 17, 2019 at 07:45:24AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > My initial goal was simple: removing the qdev_get_machine() call
> > from ppc_cpu_parse_featurestr() because I want to make
> > qdev_get_machine() available only to softmmu code.
> >
> > Before doing this, I had to make *-user not call
> > CPUClass::parse_features() anymore (it was pointless to call it,
> > anyway).
> >
> > While doing this, I decided to rename parse_cpu_model() to
> > something clearer (parse_cpu_option()).
> >
> > As a nice side effect, now the dependency between machine object
> > creation and parse_cpu_option() is not hidden anymore.
> 
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks.  I'm queueing this even though I agree with the comments
at patch 2/5, because I'm already planning to send a separate
cleanup series for cpu_class_by_name() and other related code.

-- 
Eduardo
