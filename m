Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9B4C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460DB2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 11:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCIoVq1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460DB2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKLS7-0001tB-Fe
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 07:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iKLRM-0001Pp-OL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iKLRK-0002PD-JW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:56:36 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iKLRI-0002OF-Lh
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 07:56:33 -0400
Received: by mail-io1-xd41.google.com with SMTP id w12so45100005iol.11
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IL5FBdAvXUA93jNHA93fQEkKBO6jrOksRZy3o133Nw0=;
 b=BCIoVq1TFJ8Sa5mrARu8UDRZotgXpHaEZamYmzIEi7QiOsgD3HJYqXfSdachcVgC4j
 3IJUvJiqmHu/MFsy0WvPF/CrsxvzLGC5j/b9umU+xnNNdU/WCHorK5LSSZ7DDK/C3EnW
 uoWYTN4wUyXr1oB6pAQS7A0w2N4n6/DTviOSwpKOybtuXmBCEo+Bl/JxWKJfs++x2Q24
 LtPj4WUtR/fr6Ik4rVU5AHkh2WAEuRyWQN9uM35jgeETGOIKacQ3RQinmS2qypTgYAsD
 gPT7kRxiosrymbJRQuXtXIWKduc22Ad7dcEB9alpKysTNRmz6HYY5NWoFSG15WoHhPf3
 uDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IL5FBdAvXUA93jNHA93fQEkKBO6jrOksRZy3o133Nw0=;
 b=EQXO59JwILVpqCUyzB58BX+2GfhsRF55BPaI5WS1CjrtWUd7R2o9GUjjgh5HusW0nZ
 5K5IVHTh8x2IsHur/pvsidGzSwBxnbkzoe0byRWABhxqd/vpD87Pzn8HhajY+JOLupYY
 MCNfQILd2Gv9xq7QhhW54c64ftk4NrD59JYPeNbkodLf8FiCLovlhbP/iyrhskOUlAD9
 V06MtySpzdtCweOgFHRKItpkvblNun0QgqMrEXI1/vEdme2QlfocHT6D2DWktQGv3qMU
 Yj0lhvZyDUyKsbEajTm8wnfWALze/+z1M3nWHNRAADw7jz3bpSgeymE77gpuxQ5Yk/ch
 6CnQ==
X-Gm-Message-State: APjAAAVHKbKZKy/8RkwJOKFw+SNfpLph7Z3jCgH4vai22y+BTBNC8ft8
 Cb0+lEtNgmtehxbj/dAYOXyY1U5k4jIeGPrDLcfZ5g==
X-Google-Smtp-Source: APXvYqyYgQidGLqzHV6Y6+n58u1HA0fwWVReIOM4oVeN0kQEK05y4hrnykdfGwDbuN03e55qt/4fM1Mso6DEU3XMiT0=
X-Received: by 2002:a5e:9741:: with SMTP id h1mr7061223ioq.143.1571140590103; 
 Tue, 15 Oct 2019 04:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-2-drjones@redhat.com>
 <CADSWDztJDUEd+_7XnBPWL1bk5Xh=V_aLc1+VrP97_Ycbe3489A@mail.gmail.com>
 <20191015105628.7ln6ph5s3vpsyfuw@kamzik.brq.redhat.com>
In-Reply-To: <20191015105628.7ln6ph5s3vpsyfuw@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 15 Oct 2019 12:56:19 +0100
Message-ID: <CADSWDzsKx7+4mR4pmsqi0+rddUv47q=UKwVt509B8g68UoRiMA@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 11:56, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Oct 15, 2019 at 10:59:16AM +0100, Beata Michalska wrote:
> > On Tue, 1 Oct 2019 at 14:04, Andrew Jones <drjones@redhat.com> wrote:
> > > +
> > > +    obj = object_new(object_class_get_name(oc));
> > > +
> > > +    if (qdict_in) {
> > > +        Visitor *visitor;
> > > +        Error *err = NULL;
> > > +
> > > +        visitor = qobject_input_visitor_new(model->props);
> > > +        visit_start_struct(visitor, NULL, NULL, 0, &err);
> > > +        if (err) {
> > > +            object_unref(obj);
> >
> > Shouldn't we free the 'visitor' here as well ?
>
> Yes. Good catch. So we also need to fix
> target/s390x/cpu_models.c:cpu_model_from_info(), which has the same
> construction (the construction from which I derived this)
>
> >
> > > +            error_propagate(errp, err);
> > > +            return NULL;
> > > +        }
> > > +
>
> What about the rest of the patch? With that fixed for v6 can I
> add your r-b?
>

I still got this feeling that we could optimize that a bit - which I'm
currently on, so hopefully I'll be able to add more comments soon if
that proves to be the case.

BR
Beata

> Thanks,
> drew

