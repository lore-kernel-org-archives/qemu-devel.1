Received: from eggs.gnu.org ([209.51.188.92]:53439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdO0-0004Dv-Iq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdNz-000423-NJ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:45:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
Date: Wed, 17 Apr 2019 07:45:24 +0200
In-Reply-To: <20190417025944.16154-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Tue, 16 Apr 2019 23:59:39 -0300")
Message-ID: <87sguhyykr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Eduardo Habkost <ehabkost@redhat.com> writes:

> My initial goal was simple: removing the qdev_get_machine() call
> from ppc_cpu_parse_featurestr() because I want to make
> qdev_get_machine() available only to softmmu code.
>
> Before doing this, I had to make *-user not call
> CPUClass::parse_features() anymore (it was pointless to call it,
> anyway).
>
> While doing this, I decided to rename parse_cpu_model() to
> something clearer (parse_cpu_option()).
>
> As a nice side effect, now the dependency between machine object
> creation and parse_cpu_option() is not hidden anymore.

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>
