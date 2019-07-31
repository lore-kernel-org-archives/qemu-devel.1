Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB786C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC52820651
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hslh3-00020v-SQ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hslgg-0001WI-TF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hslgf-0000tY-SC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>)
 id 1hslgb-0000qv-7P; Wed, 31 Jul 2019 06:18:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0F07985540;
 Wed, 31 Jul 2019 10:18:20 +0000 (UTC)
Received: from ptitpuce (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 541B65D6A7;
 Wed, 31 Jul 2019 10:17:53 +0000 (UTC)
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <20190730154209.2049f10a.cohuck@redhat.com>
 <CAFEAcA-rwBiXkDEDuT-=KQVJ2A2ob16=P0obbZBPUfZeYXy+dQ@mail.gmail.com>
 <20190730155547.7b201f5e.cohuck@redhat.com>
 <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
Date: Wed, 31 Jul 2019 12:17:50 +0200
Message-ID: <m1y30emrsh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 31 Jul 2019 10:18:20 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Hannes Reinecke <hare@suse.com>, Qemu-block <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell writes:

> On Tue, 30 Jul 2019 at 14:56, Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Tue, 30 Jul 2019 14:44:21 +0100
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> > On Tue, 30 Jul 2019 at 14:42, Cornelia Huck <cohuck@redhat.com> wrote:
>> > > I'm having a hard time figuring out what a 'cold' or a 'warm' reset is
>> > > supposed to be... can you add a definition/guideline somewhere?
>> >
>> > Generally "cold" reset is "power on" and "warm" is "we were already
>> > powered-on, but somebody flipped a reset line somewhere".
>>
>> Ok, that makes sense... my main concern is to distinguish that in a
>> generic way, as it is a generic interface. What about adding something
>> like:
>>
>> "A 'cold' reset means that the object to be reset is initially reset; a 'warm'
>> reset means that the object to be reset has already been initialized."
>>
>> Or is that again too generic?
>
> I think it doesn't quite capture the idea -- an object can have already
> been reset and then get a 'cold' reset: this is like having a powered-on
> machine and then power-cycling it.
>
> The 'warm' reset is the vaguer one, because the specific behaviour
> is somewhat device-dependent (many devices might not have any
> difference from 'cold' reset, for those that do the exact detail
> of what doesn't get reset on warm-reset will vary). But every
> device should have some kind of "as if you power-cycled it" (or
> for QEMU, "go back to the same state as if you just started QEMU on the
> command line"). Our current "reset" method is really cold-reset.

Is there any concept of locality associated with warm reset?
For example, you'd expect a cold reset to happen on the whole system,
but I guess a warm reset could be restricted to a single bus.

The documentation should give examples of how warm reset could be
triggered, and what it could do differently from cold reset.

>
> thanks
> -- PMM


--
Cheers,
Christophe de Dinechin (IRC c3d)

