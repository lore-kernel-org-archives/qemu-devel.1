Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E9C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C5A2171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C5A2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvfdi-0000tc-Tk
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 06:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hvfco-0008Fa-HE
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hvfcn-0001B1-Ho
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hvfci-0000uO-29; Thu, 08 Aug 2019 06:26:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 613C2C0467C3;
 Thu,  8 Aug 2019 10:26:17 +0000 (UTC)
Received: from gondolin (dhcp-192-181.str.redhat.com [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06A6960600;
 Thu,  8 Aug 2019 10:25:59 +0000 (UTC)
Date: Thu, 8 Aug 2019 12:25:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190808122557.45e8d455.cohuck@redhat.com>
In-Reply-To: <CAFEAcA-WPX153SSC-M6y8LLzO86GaPvxATo1hu4e-UzkH8MXRg@mail.gmail.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-12-damien.hedde@greensocs.com>
 <CAFEAcA-WPX153SSC-M6y8LLzO86GaPvxATo1hu4e-UzkH8MXRg@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 08 Aug 2019 10:26:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 11/33] hw/s390x/ipl.c: remove
 qbus_reset_all registration
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug 2019 16:24:30 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >
> > Replace deprecated qbus_reset_all by resettable_reset_cold_fn for
> > the ipl registration in the main reset handlers.
> >
> > This does not impact the behavior.
> >
> > Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> > ---
> >  hw/s390x/ipl.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index 60bd081d3e..402770a2c9 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -234,7 +234,11 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >       */
> >      ipl->compat_start_addr = ipl->start_addr;
> >      ipl->compat_bios_start_addr = ipl->bios_start_addr;
> > -    qemu_register_reset(qdev_reset_all_fn, dev);
> > +    /*
> > +     * TODO: when we add some kind of main reset container / domain
> > +     * switch to it to really benefit from multi-phase.
> > +     */  
> 
> I think this comment misses the mark a bit. Here's my suggestion:
> 
> /*
>  * Because this Device is not on any bus in the qbus tree (it is
>  * not a sysbus device and it's not on some other bus like a PCI
>  * bus) it will not be automatically reset by the 'reset the
>  * sysbus' hook registered by vl.c like most devices. So we must
>  * manually register a reset hook for it.
>  * TODO: there should be a better way to do this.
>  */

Agreed, that explains much better why we're doing this.

> 
> > +    qemu_register_reset(resettable_reset_cold_fn, dev);

This is fine for the conversion done within this series; but resetting
the ipl device is one case where the cold vs. warm distinction falls a
bit short (there's a s390_reset enum which covers more cases). Not sure
if we want some custom reset types?

> >  error:
> >      error_propagate(errp, err);
> >  }
> > --
> > 2.22.0
> >  
> 
> thanks
> -- PMM


