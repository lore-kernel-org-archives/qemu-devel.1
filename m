Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CB4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEBF207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 23:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St9HHUN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEBF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia7Bi-0000Po-Eg
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 18:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1ia7Aa-0007Vh-OM
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1ia77u-0007vF-Mq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:53:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47583
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ia77o-0007qY-TX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 18:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574898813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dt21YewSkYYthHZXX0teFzXAQbwlQ3MJxgjdFJoojc=;
 b=St9HHUN8w1aTZrVbuCG4sxlEU5/MqW8MPTEWTOfwCA7niaY9lj/THTE6n39GjlL+bNK4Sq
 ixpBQneRS4JQXkaidYwgVk77i3nZltdAcqFK5XvjlGwIebB3CqegGnVB/V8jHOVaMrke2O
 cyv+JhZTBSIphSvrhL8czMUN/sLG1+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-ozXUE9MMN7GJroASLzybIQ-1; Wed, 27 Nov 2019 18:53:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D952A800D41;
 Wed, 27 Nov 2019 23:53:30 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76E3610016E8;
 Wed, 27 Nov 2019 23:53:27 +0000 (UTC)
Date: Wed, 27 Nov 2019 20:53:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
Message-ID: <20191127235325.GA4438@habkost.net>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
 <CAL1e-=i9=1PSD8coYae4AGeW_uiRHXVM8UvKnLdSW_tWRcMYgA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i9=1PSD8coYae4AGeW_uiRHXVM8UvKnLdSW_tWRcMYgA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ozXUE9MMN7GJroASLzybIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 26, 2019 at 12:49:40AM +0100, Aleksandar Markovic wrote:
> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>=20
> > Include AVR maintaners in MAINTAINERS file
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5e5e3e52d6..ad2d9dd04a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -163,6 +163,15 @@ S: Maintained
> >  F: hw/arm/smmu*
> >  F: include/hw/arm/smmu*
> >
> > +AVR TCG CPUs
> > +M: Michael Rolnik <mrolnik@gmail.com>
> > +S: Maintained
> > +F: target/avr/
> > +F: hw/misc/avr_mask.c
> > +F: hw/char/avr_usart.c
> > +F: hw/timer/avr_timer16.c
> > +F: hw/avr/
> > +
>=20
>=20
> If Cleber and Eduardo don't object, please add file:
>=20
> tests/acceptance/machine_avr6.py
>=20
> to the list. This means that the file would have a sort of "dual"
> maintainrship: Cleber and Eduardo would take care of Python/Avocado/test
> harness aspects, while you and Sarah would take care of AVR aspects.

No objections.  Thanks!

>=20
> Cleber and Eduardo, please note that AVR target will be significantly
> different than others, since these CPUs are not meant to work with Linux
> kernel, and there are other idiosyncracies where AVR folks would be reall=
y
> needed. There is also a case of MIPS-specific Avocado test where, at leas=
t
> from my point of view, dual maintainership worked well, so I think this o=
ne
> would work well too.
>=20
> With or without that file addition:
>=20
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

--=20
Eduardo


