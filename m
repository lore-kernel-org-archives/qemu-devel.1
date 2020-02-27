Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32F8C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872622468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872622468E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7II4-0007g3-Pe
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j7IHI-000795-I8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j7IHH-0000Vd-AE
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:28:32 -0500
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:53089)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j7IHH-0000Iq-2a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:28:31 -0500
Received: from player770.ha.ovh.net (unknown [10.108.54.87])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0C0C61335BC
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 13:28:25 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 61FCCFEA6C03;
 Thu, 27 Feb 2020 12:28:18 +0000 (UTC)
Date: Thu, 27 Feb 2020 13:28:16 +0100
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH] spapr: Fix Coverity warning while validating nvdimm
 options
Message-ID: <20200227132816.191b80ac@bahia.home>
In-Reply-To: <20200226134927.3cc5b6fb@bahia.home>
References: <158271897341.44994.2741557659975232894.stgit@lep8c.aus.stglabs.ibm.com>
 <20200226134927.3cc5b6fb@bahia.home>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13108008194453838165
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdegudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.46.122
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
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 13:49:27 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 26 Feb 2020 06:10:38 -0600
> Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
> 
> > Fixes Coverity issue,
> >       CID 1419883:  Error handling issues  (CHECKED_RETURN)
> >            Calling "qemu_uuid_parse" without checking return value
> > 
> > nvdimm_set_uuid() already verifies if the user provided uuid is valid or
> > not. So, need to check for the validity during pre-plug validation again.
> > 
> 
> Ok but since nvdimm_set_uuid() fills nvdimm->uuid why do you need to parse
> the string again in the first place ?
> 

As discussed on slack, you can forget this remark. Using the QOM accessor
is the way to go.

> > As this a false positive in this case, assert if not valid to be safe.
> > 
> > Reported-by: Coverity (CID 1419883)
> > Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > ---
> >  hw/ppc/spapr_nvdimm.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> > index 74eeb8bb74..051727536e 100644
> > --- a/hw/ppc/spapr_nvdimm.c
> > +++ b/hw/ppc/spapr_nvdimm.c
> > @@ -44,7 +44,7 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
> >      }
> >  
> >      uuidstr = object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP, NULL);

object_property_get_str() can theoretically return NULL and...

> > -    qemu_uuid_parse(uuidstr, &uuid);

... cause a segv in there because uuidstr will be dereferenced at
some point without checking if it's NULL.

AFAICT there are two scenarios that can cause object_property_get_str()
to return NULL:
- the property doesn't exist
- the property isn't a string

This can probably never happen with the current code base but we
can't about future changes. In order to ensure we abort rather
than segv, I'd pass &error_abort to object_property_get_str().

> > +    g_assert(qemu_uuid_parse(uuidstr, &uuid) == 0);
> 
> Like assert(), g_assert() is a macro that can be turned into a nop at
> compile time:
> 
> #ifdef G_DISABLE_ASSERT
> #define g_assert_not_reached()          G_STMT_START { (void) 0; } G_STMT_END
> #define g_assert(expr)                  G_STMT_START { (void) 0; } G_STMT_END
> #else /* !G_DISABLE_ASSERT */
> #define g_assert_not_reached()          G_STMT_START { g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, NULL); } G_STMT_END
> #define g_assert(expr)                  G_STMT_START { \
>                                              if G_LIKELY (expr) ; else \
>                                                g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, \
>                                                                          #expr); \
>                                         } G_STMT_END
> #endif /* !G_DISABLE_ASSERT */
> 
> One should avoid putting expressions with side-effects in g_assert() because
> the code may not be called at all if G_DISABLE_ASSERT is defined...
> 
> >      g_free(uuidstr);
> >  
> >      if (qemu_uuid_is_null(&uuid)) {
> 
> ... and uuid would be uninitialized here :-\
> 
> If you need to use g_assert(), please do something like:
> 
>     ret = qemu_uuid_parse(uuidstr, &uuid);
>     g_assert(!ret);
> 
> > 
> > 
> 


