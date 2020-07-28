Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A689C433F8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596D9207F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVgohXRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596D9207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SaF-0001nU-MT
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k0SYh-0000QP-Hz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:34:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25128
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k0SYe-0004PZ-Fc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595954067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRmq5oYCCQkA/84jx/NiYmMqpAWKBrQc+66BHAR94Do=;
 b=WVgohXRojvfI1NFI25ET9uOvMKMLdWGdyIF7Y+WTNQSt2/CQ46NW8ywowaNb94bebGU6fa
 8lKyDEKMHuefCwjOeF0wqOVrr1+8hJ6n9FDQJpF5eQVglY1a01cuDIUgPSyYIFY3Vsm1l7
 RKDj2PhrtYK+Ae3cvE2uTP7K1+a9SzE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-rSTZ8m4VOP22ya4mjDbUvQ-1; Tue, 28 Jul 2020 12:34:24 -0400
X-MC-Unique: rSTZ8m4VOP22ya4mjDbUvQ-1
Received: by mail-oo1-f71.google.com with SMTP id m10so5221249ooi.18
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uRmq5oYCCQkA/84jx/NiYmMqpAWKBrQc+66BHAR94Do=;
 b=HoAeUlcL0WJjkRhrIwfQCQocKzD2yHNLpkWYBQMyymrp1n/DHUAo05+Dgws0bPcuS9
 50ktDS/Uo+q38v0GXAcpAHFGIteDGTELlvplv+3d/hc2iXKu11z2IrKqEsqJ9o4M9FVr
 AGPpuoS60ZcjTiiub0ge9JwOiSjN/310024oXwLnm45UHPHyChaZzvTaJQDIa9r85diT
 Jw45XpOzHqclCOB/8OvNMBizNabStzLOujc+S53/7A2BGz37jsgMZ1A2MzeRf1ge1DyS
 +s6FIbl7KGYdVrNBXet1XV61rvM11acgY42OeboQpOR0i7RG57lb+rnjaj67yikK2GVj
 IyGg==
X-Gm-Message-State: AOAM533WugOddffMOT0iBUfuKhEk1PBg3a8WiLGU2mm+HXJdfamFCsg9
 0097QJgkf9t19lpWTC+UtldHWJRikv/yei55nLtBPLb2Qx8MIDEWtYmcacHmOnSSyPp0afdj0dc
 rPPF0xuXQXxG8xPW/p2+DqsRZarKvDFg=
X-Received: by 2002:a05:6808:486:: with SMTP id
 z6mr4491069oid.56.1595954063988; 
 Tue, 28 Jul 2020 09:34:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/cGOx0XELarllRcaSYDDtzK+cqsii/zB4Qk1WF3kp5YydZeWbgshOiYPtLbaPm1xPWctyyhLZevYiqcshpQ4=
X-Received: by 2002:a05:6808:486:: with SMTP id
 z6mr4491045oid.56.1595954063664; 
 Tue, 28 Jul 2020 09:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-4-nsoffer@redhat.com>
 <398e7bd6-3bc6-f42a-0a9e-df8cc76e073d@virtuozzo.com>
In-Reply-To: <398e7bd6-3bc6-f42a-0a9e-df8cc76e073d@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 28 Jul 2020 19:34:07 +0300
Message-ID: <CAMRbyyt=RzuUouc63vftzrwruWCFhVs8f7gtvPU+BfL588Ddmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iotests: Add more qemu_img helpers
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 4:50 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 28.07.2020 00:58, Nir Soffer wrote:
> > Add 2 helpers for measuring and checking images:
> > - qemu_img_measure()
> > - qemu_img_check()
> >
> > Both use --output-json and parse the returned json to make easy to use
> > in other tests. I'm going to use them in a new test, and I hope they
> > will be useful in may other tests.
> >
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >   tests/qemu-iotests/iotests.py | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > index 8f79668435..717b5b652c 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -141,6 +141,12 @@ def qemu_img_create(*args):
> >
> >       return qemu_img(*args)
> >
> > +def qemu_img_measure(*args):
> > +    return json.loads(qemu_img_pipe("measure", "--output", "json", *args))
> > +
> > +def qemu_img_check(*args):
> > +    return json.loads(qemu_img_pipe("check", "--output", "json", *args))
> > +
>
> qemu_img_pipe has type hints, so I assume we should add them here too.

True, but type hints are not use consistently in this module (e.g.
qemu_img_verbose).

>
> Also, qemu-img don't report errors in json format, so in case of error, this will raise a problem about something that json can't parse. Probably we need better error handling.

Yes, this fails in an ugly and unhelpful way now.

Ideally failing command will raise a detailed error with the command,
exit code, output,
and error. Code that want to check for specific return code would do:

    try:
        iotests.qemu_img_check(disk)
    except iotest.Error as e:
        if e.rc == 2:
           ...

But most callers do not need this so they will fail loudly with all the details.

What do you think?

> Still, for 5.1 it's OK as is I think, so if we are in a hurry:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> >   def qemu_img_verbose(*args):
> >       '''Run qemu-img without suppressing its output and return the exit code'''
> >       exitcode = subprocess.call(qemu_img_args + list(args))
> >
>
>
> --
> Best regards,
> Vladimir
>


