Received: from eggs.gnu.org ([2001:4830:134:3::10]:36995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhWQe-0005sC-Uk
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhWQb-0001M7-NS
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:38:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dhWQb-0001Ld-GM
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:38:17 -0400
Date: Tue, 15 Aug 2017 09:38:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170815093811.4047b0ab@nial.brq.redhat.com>
In-Reply-To: <CACXAS8DmEBwYMUz_Sun30Gdm_4w1Pdd7M3CCGamHVcydjs605A@mail.gmail.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-5-git-send-email-imammedo@redhat.com>
	<20170814095657.549d0bc8@nial.brq.redhat.com>
	<CACXAS8DmEBwYMUz_Sun30Gdm_4w1Pdd7M3CCGamHVcydjs605A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/28] sparc: convert cpu models to SPARC
 cpu subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 14 Aug 2017 18:24:31 +0200
Artyom Tarasenko <atar4qemu@gmail.com> wrote:

> Hi Igor,
> 
> On Mon, Aug 14, 2017 at 9:56 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> > On Fri, 14 Jul 2017 15:51:55 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >  
> >> QOMfy cpu models handling introducing propper cpu types
> >> for each cpu model.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> with this and conversion of features to properties,
> >> it would be possible to replace cpu_sparc_init() with
> >> cpu_generic_init() and reuse common -cpu handling
> >> infrastructure.
> >>
> >> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> CC: Artyom Tarasenko <atar4qemu@gmail.com>  
> >
> > ping,
> >
> > Mark, Artoym,
> >
> > As SPARC maintainers, cloud you please review/test patches 4-10/28.  
> 
> Will look on it on the upcoming weekend.
> 
> > +    /* SPARC cpu model names happen to have whitespaces,
> > +     * as type names shouldn't have spaces replace them with '-'
> > +     */  
> 
> Does it also happen for non-SPARC cpu model names?
not that I know of, there is nothing we can do about cpu model names
as it's user facing value and fixing them would break user's scripts,
hence target specific quirk in sparc_cpu_class_by_name().

Other targets have their own quirks, like cpu aliases which also
handled on per target basis in foo_cpu_class_by_name() callbacks.

> 
> Artyom
> 
