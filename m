Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A48C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7218B2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwz4MM9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7218B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizzT-0006iK-Ob
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jizi5-0003tO-I2
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 08:20:01 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b]:42547)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jizi0-0007nN-2m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 08:20:01 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id p15so877374qvr.9
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I27Gf9kjAaWqAWeTCSX0aZVa1pjrNkI2HruSIZfC1s4=;
 b=lwz4MM9lJSaPYaIAXkvnwNuhjDe1fD3yhqt/Qw7uVa3FKi2u2iIlF9CZRVy8FkAtgv
 sURfJlDt56SCYgnx9xqEb3V1yAyRJfsfY8Fdw1mnB5li2T+CSq6jck5jLQd6OUVCfd2N
 j6lZ83kBfDSpuwvR9BSE5pXPhtzYKxbf4kns8nHJCmtRWEHdrU/tmRjHTBij6/ECXxNN
 5V2KB3cXDheSTtK9KSaebo2qe19fQABZF4nWpch3FFweK3BDGvGvgfUY65NxkdBEh3vX
 H1F/+StfbJD6kso7eQzQAWLDm6fBJYO5smv43+4lc21I1cxTmvil/p9+Jk16XIw41WS2
 sRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I27Gf9kjAaWqAWeTCSX0aZVa1pjrNkI2HruSIZfC1s4=;
 b=MX9fcEJbNkJL9cAUD8WiRN5sbZDcIKPuz99i6qR9djrt7+ptUwScJVvBIPHKxvRGti
 YMcgKUiks1abjhV8yL4JV0O0haYPKvwvKWh5xrxyyvu2bFmrQ93ByKgjp+Y+YPceBoV9
 4hP2n8Gibe2epygtLL2hOy+5FhslVqc6K/51LQtncUl2IqFYv9L/c7qB4sDgg83bjsyT
 4985o0Iow2ZLvoyRFJ1OAvVDjPOXI5iM5gAUULgga3kdvURrR0vkqVcTguWq3/orpSsx
 7a3rpVd+yQbUPJ1yxAeZqK304/ZFxGp84tlQvnezHZC3xfmRgH0GYVZ22tOpiW0dNtoR
 2WFQ==
X-Gm-Message-State: AOAM532i12T0URaUttCyRImyO2CFjiYKDiIbXCbR1kmPoEsVPmhwudJB
 BqG1Sr70YkHgkiKqAyIA2DL9H86sPMm8JoVeOsTQDA==
X-Google-Smtp-Source: ABdhPJzYpWGD5Pv4vqqBOQSfG4JeOr4SaQmWRqEw88awtBWaXSVw3ydPHzhZ1HQ4Ci7TwCPOdKp+4Qc3PSWYlbqgLF4=
X-Received: by 2002:ad4:47aa:: with SMTP id a10mr2899047qvz.61.1591791589433; 
 Wed, 10 Jun 2020 05:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
In-Reply-To: <m2imfz877v.fsf@dme.org>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 10 Jun 2020 15:19:38 +0300
Message-ID: <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
To: David Edmondson <dme@dme.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, eblake@redhat.com,
 Max Reitz <mreitz@redhat.com>, Tony Zhang <tzz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=sameid@google.com; helo=mail-qv1-xf2b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks David,

Yes, I imaging the following use case:

disk.vmdk is a 50 GB disk that contains 12 MB binary of zeroes in its beginning.
/dev/sda is a raw disk containing garbage

I invoke:
qemu-img convert disk.vmdk -O raw /dev/sda

Required output:
The first 12 MB of /dev/sda contain zeros, the rest garbage, qemu-img
finishes fast.

Kevin, from what I understood from you, this is the default behavior.

So if my VMDK is causing trouble (all virtual size is being written)
this is probably since all the grains in the VMDK are zero allocated
right?

Thanks!

On Wed, Jun 10, 2020 at 2:56 PM David Edmondson <dme@dme.org> wrote:
>
> On Wednesday, 2020-06-10 at 08:28:29 +03, Sam Eiderman wrote:
>
> > Hi,
> >
> > 168468fe19c8 ("qemu-img: Add --target-is-zero to convert") has added a
> > nice functionality for cloud scenarios:
> >
> > * Create a virtual disk
> > * Convert a sparse image (qcow2, vmdk) to the virtual disk using
> > --target-is-zero
> > * Use the virtual disk
> >
> > This saves many unnecessary writes - a qcow2 with 1MB of allocated
> > data but with 100GB virtual size will be converted efficiently.
> >
> > However, does this pose a problem if the virtual disk is not zero initialized?
>
> As Vladimir indicated, the intent of the flag is supposed to be clear
> from the name :-) If your storage doesn't read zeroes absent any earlier
> writes, you probably don't want to be using it.
>
> > Theoretically - if all unallocated blocks contain garbage - this
> > shouldn't matter, however what about allocated blocks of zero? Will
> > convert skip copying allocated zero blocks in the source image to the
> > target since it assumes that the target is zeroed out first thing?
>
> So something like a "--no-need-to-zero" flag would do what you want,
> presuming that it would write known zeroes but no longer clean the
> device before use?
>
> dme.
> --
> You can't hide from the flipside.

