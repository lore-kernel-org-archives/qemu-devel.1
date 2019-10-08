Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D53C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37469206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 16:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37469206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHsEz-0003vH-CY
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 12:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iHsDj-0002xk-L7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iHsDh-0000rx-DF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:20:19 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:48678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iHsDg-0000pv-TQ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 12:20:17 -0400
Received: from player688.ha.ovh.net (unknown [10.108.57.150])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 552FD10CE4F
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 18:20:14 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id A9BD8AA5257F;
 Tue,  8 Oct 2019 16:19:22 +0000 (UTC)
Date: Tue, 8 Oct 2019 18:19:21 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 04/31] error: auto propagated local_err
Message-ID: <20191008181921.288e69e4@bahia.lan>
In-Reply-To: <87k19fgr7i.fsf@dusky.pond.sub.org>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-5-vsementsov@virtuozzo.com>
 <87k19fgr7i.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13203709686463830414
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrheelgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.37.72
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, arikalo@wavecomp.com,
 mst@redhat.com, mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, joel@jms.id.au, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, farman@linux.ibm.com, ehabkost@redhat.com,
 sw@weilnetz.de, dgilbert@redhat.com, yuval.shaia@oracle.com,
 alex.williamson@redhat.com, integration@gluster.org, clg@kaod.org,
 stefanha@redhat.com, david@redhat.com, jsnow@redhat.com, rth@twiddle.net,
 kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 berrange@redhat.com, andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org,
 sundeep.lkml@gmail.com, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 08 Oct 2019 18:03:13 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
> > Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> > functions with errp OUT parameter.
> >
> > It has three goals:
> >
> > 1. Fix issue with error_fatal & error_prepend/error_append_hint: user
> > can't see this additional information, because exit() happens in
> > error_setg earlier than information is added. [Reported by Greg Kurz]
> >
> > 2. Fix issue with error_abort & error_propagate: when we wrap
> > error_abort by local_err+error_propagate, resulting coredump will
> > refer to error_propagate and not to the place where error happened.
> > (the macro itself doesn't fix the issue, but it allows to [3.] drop all
> > local_err+error_propagate pattern, which will definitely fix the issue)
> > [Reported by Kevin Wolf]
> >
> > 3. Drop local_err+error_propagate pattern, which is used to workaround
> > void functions with errp parameter, when caller wants to know resulting
> > status. (Note: actually these functions could be merely updated to
> > return int error code).
> 
> Starting with stating your goals is an excellent idea.  But I'd love to
> next read a high-level description of how your patch achieves or enables
> achieving these goals.
> 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> [...]
> > diff --git a/include/qapi/error.h b/include/qapi/error.h
> > index 9376f59c35..02f967ac1d 100644
> > --- a/include/qapi/error.h
> > +++ b/include/qapi/error.h
> > @@ -322,6 +322,43 @@ void error_set_internal(Error **errp,
> >                          ErrorClass err_class, const char *fmt, ...)
> >      GCC_FMT_ATTR(6, 7);
> >  
> > +typedef struct ErrorPropagator {
> > +    Error *local_err;
> > +    Error **errp;
> > +} ErrorPropagator;
> > +
> > +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> > +{
> > +    error_propagate(prop->errp, prop->local_err);
> > +}
> > +
> > +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
> > +
> > +/*
> > + * ERRP_AUTO_PROPAGATE
> > + *
> > + * This macro is created to be the first line of a function with Error **errp
> > + * OUT parameter. It's needed only in cases where we want to use error_prepend,
> > + * error_append_hint or dereference *errp. It's still safe (but useless) in
> > + * other cases.
> > + *
> > + * If errp is NULL or points to error_fatal, it is rewritten to point to a
> > + * local Error object, which will be automatically propagated to the original
> > + * errp on function exit (see error_propagator_cleanup).
> > + *
> > + * After invocation of this macro it is always safe to dereference errp
> > + * (as it's not NULL anymore) and to append hints (by error_append_hint)
> > + * (as, if it was error_fatal, we swapped it with a local_error to be
> > + * propagated on cleanup).
> 
> Well, appending hints was always safe, it just didn't work with
> &error_fatal.  Don't worry about that now, I'll probably want to polish
> this contract comment a bit anyway, but later.
> 

FWIW I've already posted this:

Author: Greg Kurz <groug@kaod.org>
Date:   Mon Oct 7 15:45:46 2019 +0200

    error: Update error_append_hint()'s documenation
    
    error_setg() and error_propagate(), as well as their variants, cause
    QEMU to terminate when called with &error_fatal or &error_abort. This
    prevents to add hints since error_append_hint() isn't even called in
    this case.
    
    It means that error_append_hint() should only be used with a local
    error object, and then propagate this local error to the caller.
    
    Document this in <qapi/error.h> .
    
    Signed-off-by: Greg Kurz <groug@kaod.org>

Message-id: <156871563702.196432.5964411202152101367.stgit@bahia.lan>
https://patchwork.ozlabs.org/patch/1163278/

> > + *
> > + * Note: we don't wrap the error_abort case, as we want resulting coredump
> > + * to point to the place where the error happened, not to error_propagate.
> > + */
> > +#define ERRP_AUTO_PROPAGATE() \
> > +g_auto(ErrorPropagator) __auto_errp_prop = {.errp = errp}; \
> 
> Took me a second to realize: the macro works, because the initializer
> implicitly initializes .local_error = NULL.
> 
> __auto_errp_prop is an identifier reserved for any use.  I think we
> could use _auto_errp_prop, which is only reserved for use as identifiers
> with file scope in both the ordinary and tag name spaces.  See ISO/IEC
> 9899:1999 7.1.3 Reserved identifiers.
> 
> > +errp = ((errp == NULL || *errp == error_fatal) ? \
> > +    &__auto_errp_prop.local_err : errp)
> > +
> 
> Please indent multi-line macros like elsewhere in this file:
> 
> #define ERRP_AUTO_PROPAGATE()					\
>     g_auto(ErrorPropagator) __auto_errp_prop = {.errp = errp};	\
>     errp = ((errp == NULL || *errp == error_fatal)		\
>             ? &__auto_errp_prop.local_err : errp)
> 
> >  /*
> >   * Special error destination to abort on error.
> >   * See error_setg() and error_propagate() for details.
> 
> To be honest, the cover letter left me a bit skeptical, but now I think
> you might be up to something.  Let's see how the patches putting the
> macro to use come out.


