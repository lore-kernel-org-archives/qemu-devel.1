Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A002C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 02:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF7D2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 02:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNOpj++S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF7D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZQGE-0000p4-SJ
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 21:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iZQFP-0000IK-8o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 21:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iZQFL-0001zk-98
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 21:06:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iZQFJ-0001yo-LQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 21:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574733988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5QyZ7o8Za2BCXuTW0pF+VWY13/jVX4PNAL8mZVHr6w=;
 b=hNOpj++Sor2EeyI4x8y2s3QiP3vsm64QP+fnPSGZ1o5T6PtVSZnXqgWdbnOwcHmhX9Vucg
 bbewnq+1RnVIlwWbRUprOE2SVrNqowrdTGVvHr6F1YaQuC0pk+P2R0hvGV4QUn+ncDx5Hh
 RHXISzZbZRIKZ7jTX5wHvaCjpNk2HXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-hFrpoZdVM8K0OPNBDiQpIA-1; Mon, 25 Nov 2019 21:06:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D79A5477;
 Tue, 26 Nov 2019 02:06:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C480A1001B08;
 Tue, 26 Nov 2019 02:06:23 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8F9CF4BB65;
 Tue, 26 Nov 2019 02:06:23 +0000 (UTC)
Date: Mon, 25 Nov 2019 21:06:23 -0500 (EST)
From: Cleber Rosa <crosa@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <23698103.13805166.1574733983349.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAL1e-=i9=1PSD8coYae4AGeW_uiRHXVM8UvKnLdSW_tWRcMYgA@mail.gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-18-mrolnik@gmail.com>
 <CAL1e-=i9=1PSD8coYae4AGeW_uiRHXVM8UvKnLdSW_tWRcMYgA@mail.gmail.com>
Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
MIME-Version: 1.0
X-Originating-IP: [10.10.120.170, 10.4.195.25]
Thread-Topic: target/avr: Update MAINTAINERS file
Thread-Index: jTTfU09A9JhTce8hUMJf4uzx3vmm4w==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: hFrpoZdVM8K0OPNBDiQpIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 richard henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, imammedo@redhat.com, dovgaluk@ispras.ru,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
> To: "Michael Rolnik" <mrolnik@gmail.com>, "Cleber Rosa" <crosa@redhat.com>, "Eduardo Habkost" <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org, "richard henderson" <richard.henderson@linaro.org>, philmd@redhat.com, thuth@redhat.com,
> dovgaluk@ispras.ru, imammedo@redhat.com
> Sent: Monday, November 25, 2019 6:49:40 PM
> Subject: Re: [PATCH v36 17/17] target/avr: Update MAINTAINERS file
> 
> On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
> 
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
> 
> 
> If Cleber and Eduardo don't object, please add file:
> 
> tests/acceptance/machine_avr6.py
> 
> to the list. This means that the file would have a sort of "dual"
> maintainrship: Cleber and Eduardo would take care of Python/Avocado/test
> harness aspects, while you and Sarah would take care of AVR aspects.
> 

No objections, quite the contrary, I'd happy to be CC'd when such code
changes.

Thanks,
- Cleber.

> Cleber and Eduardo, please note that AVR target will be significantly
> different than others, since these CPUs are not meant to work with Linux
> kernel, and there are other idiosyncracies where AVR folks would be really
> needed. There is also a case of MIPS-specific Avocado test where, at least
> from my point of view, dual maintainership worked well, so I think this one
> would work well too.
> 
> With or without that file addition:
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> 
> 
> >  CRIS TCG CPUs
> >  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> >  S: Maintained
> > --
> > 2.17.2 (Apple Git-113)
> >
> >
> 


