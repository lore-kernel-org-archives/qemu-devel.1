Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B264C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 13:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D386206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 13:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D386206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53259 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGl4w-0008Bv-SQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 09:58:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGl2Q-0006aQ-Vw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGl2O-000772-RR
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 09:55:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hGl2N-00074e-V5; Wed, 17 Apr 2019 09:55:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04100307D84D;
	Wed, 17 Apr 2019 13:55:42 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB5975D6A6;
	Wed, 17 Apr 2019 13:55:40 +0000 (UTC)
Date: Wed, 17 Apr 2019 10:55:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190417135538.GA25134@habkost.net>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-3-ehabkost@redhat.com>
	<871s21194s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <871s21194s.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 17 Apr 2019 13:55:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/5] cpu: Extract CPU class lookup from
 parse_cpu_option()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417135538.ZoPxoHc3kPM8mG7T7ew58sOnpluGhzM6CtFD6eBB1yM@z>

On Wed, Apr 17, 2019 at 07:41:23AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > The new function will be useful in user mode, when we already
> > have a CPU model and don't need to parse any extra options.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/qom/cpu.h |  9 +++++++++
> >  exec.c            | 22 ++++++++++++----------
> >  2 files changed, 21 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> > index d28c690b27..e11b14d9ac 100644
> > --- a/include/qom/cpu.h
> > +++ b/include/qom/cpu.h
> > @@ -699,6 +699,15 @@ CPUState *cpu_create(const char *typename);
> >   */
> >  const char *parse_cpu_option(const char *cpu_option);
> >  
> > +/**
> > + * lookup_cpu_class:
> > + * @cpu_model: CPU model name
> > + *
> > + * Look up CPU class corresponding to a given CPU model name.
> > + */
> > +CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp);
> 
> Nitpicks, feel free to ignore.
> 
> Naming: lookup_cpu_class() makes my reading circuits stall momentarily,
> because lookup is a noun. The verb is spelled look up.  No stall:
> cpu_class_lookup(), look_up_cpu_class(), cpu_class_by_name_err(),
> cpu_class_parse(), ...
> 
> Doc string: this is a wrapper around cpu_class_by_name().  Perhaps that
> should be spelled out.
> 
> Apropos cpu_class_by_name(): it returns ObjectClass, not CPUClass.
> Isn't that odd?
> 
> Position: If you put it before cpu_create() rather than after, it's next
> to the function it wraps.  But perhaps you prefer to keep it next to
> parse_cpu_option().

Your suggestions make sense.  I didn't notice how close
lookup_cpu_class() was to the declaration of cpu_class_by_name().
I was seeing lookup_cpu_class() as "this portion of
parse_cpu_option() I need", and not as "a wrapper to
cpu_class_by_name()".

What about:

/**
 * arch_cpu_class_by_name:
 * @cpu_model: CPU model name
 *
 * Arch-specific wrapper around cpu_class_by_name(), uses CPU_RESOLVING_TYPE
 * for the current architecture.
 */
CPUClass *arch_cpu_class_by_name(const char *cpu_model, Error **errp);


-- 
Eduardo

