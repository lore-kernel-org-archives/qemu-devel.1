Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78E5C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9252089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9252089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUN3-00072r-QY
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 11:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hsUMN-0006SX-8o
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hsUMM-0006K1-66
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hsUM5-000649-Mb; Tue, 30 Jul 2019 11:48:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE83B30BD1CC;
 Tue, 30 Jul 2019 15:47:58 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F83719C5B;
 Tue, 30 Jul 2019 15:47:28 +0000 (UTC)
Date: Tue, 30 Jul 2019 17:47:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190730174725.10419dfb.cohuck@redhat.com>
In-Reply-To: <34a216b0-0067-8627-599c-6a67622c4bd2@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <20190730154209.2049f10a.cohuck@redhat.com>
 <CAFEAcA-rwBiXkDEDuT-=KQVJ2A2ob16=P0obbZBPUfZeYXy+dQ@mail.gmail.com>
 <20190730155547.7b201f5e.cohuck@redhat.com>
 <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
 <34a216b0-0067-8627-599c-6a67622c4bd2@greensocs.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 30 Jul 2019 15:47:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>,
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 16:08:59 +0200
Damien Hedde <damien.hedde@greensocs.com> wrote:

> On 7/30/19 3:59 PM, Peter Maydell wrote:
> > On Tue, 30 Jul 2019 at 14:56, Cornelia Huck <cohuck@redhat.com> wrote:  
> >>
> >> On Tue, 30 Jul 2019 14:44:21 +0100
> >> Peter Maydell <peter.maydell@linaro.org> wrote:
> >>  
> >>> On Tue, 30 Jul 2019 at 14:42, Cornelia Huck <cohuck@redhat.com> wrote:  
> >>>> I'm having a hard time figuring out what a 'cold' or a 'warm' reset is
> >>>> supposed to be... can you add a definition/guideline somewhere?  
> >>>
> >>> Generally "cold" reset is "power on" and "warm" is "we were already
> >>> powered-on, but somebody flipped a reset line somewhere".  
> >>
> >> Ok, that makes sense... my main concern is to distinguish that in a
> >> generic way, as it is a generic interface. What about adding something
> >> like:
> >>
> >> "A 'cold' reset means that the object to be reset is initially reset; a 'warm'
> >> reset means that the object to be reset has already been initialized."
> >>
> >> Or is that again too generic?  
> > 
> > I think it doesn't quite capture the idea -- an object can have already
> > been reset and then get a 'cold' reset: this is like having a powered-on
> > machine and then power-cycling it.
> > 
> > The 'warm' reset is the vaguer one, because the specific behaviour
> > is somewhat device-dependent (many devices might not have any
> > difference from 'cold' reset, for those that do the exact detail
> > of what doesn't get reset on warm-reset will vary). But every
> > device should have some kind of "as if you power-cycled it" (or
> > for QEMU, "go back to the same state as if you just started QEMU on the
> > command line"). Our current "reset" method is really cold-reset.

Ah ok, that makes sense.

> >   
> 
> Exactly. In the following patches, I've tried to replace existing reset
> calls by cold or warm reset depending on whether:
> + it is called through the main system reset -> cold
> + it is called during normal life-time       -> warm
> 
> But I definitely can add some docs/comments to better explain that.

Yes, that would be great; I think I now understand enough for looking
at the patches.

