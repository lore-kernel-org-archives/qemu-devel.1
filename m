Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9430C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13CD20707
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+kYJjmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13CD20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joV0k-0000zg-Q5
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joUzU-0007lM-8h
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:44:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joUzS-0008GS-0y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593103481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jo0MGs7twxqrlAcVivhQ9s2bawwtfUp/pv0gLKR98RY=;
 b=D+kYJjmhIGucyCUqdCJDRg6yZmPVLBMbsYwuoAXK3+GpY4gS8cvPkWGw2s9eFL8ej0HFSu
 y4mPyBX8fXYTTQ7jlvJYoybfJPJip0vMFoFyvDRmQo4Un7ozKHXCtqTXsOaIMvMN7jaqFc
 +/TK+3hm47ASBtpfkusem8Z72gF9sfg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-my46ysENPTuXV2ixko85tw-1; Thu, 25 Jun 2020 12:44:36 -0400
X-MC-Unique: my46ysENPTuXV2ixko85tw-1
Received: by mail-ot1-f69.google.com with SMTP id z16so4004477otj.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jo0MGs7twxqrlAcVivhQ9s2bawwtfUp/pv0gLKR98RY=;
 b=XYdg90u9UuEGrU9k8H3tWXaGbWaDgiEflRv+B3vFqS/oYx+eshehxGXCV5arRC9u6z
 xo+qcIxG8Usnk0T8FbjkT4NfXZTK+yTNq5kEbGE7cqJSEJl+j9Dea20OV1s+v7a2xqi/
 2V8hxPtAs5fZPRlZuw7qZHfvvcPxwziPvdl0IbyNLRCvErh9/hqECil02YSJ2ePu22h3
 183S6iHDHXdEszI1CrWY/vDfXSP1mAjoSpEpYTmFubAMKeDc0mkx4gnKZEqWVweux8Uu
 q/jpUIVRBNu6UC76Ow5EGVVZ0fvIs53E+FITuYxQeyn8Hyxny0rN9SRrJkKxxqmV+gPm
 /YBg==
X-Gm-Message-State: AOAM530MCYI2vifcBt+BXGQDqA2whoXRzxVbd8BO3um45et8fE9hEeHR
 x2Y0wlpRDzvSeP3LhF437Ouz/5g3w7xN8N/q3WdC46Nhsn4KY6KEKd+rXnHW1cJsLoZZ4U3r4an
 RP3DAky2T+7jPJRxhIaWyxaH89hcucP0=
X-Received: by 2002:aca:b357:: with SMTP id c84mr2928284oif.118.1593103475859; 
 Thu, 25 Jun 2020 09:44:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrpGM9U5MO+zDQL8qayYXl7rTULiTLtROurDpup9UJSE3D2zrWs6TwN11424pSUmlW0BOl978MXztU7kaEo9E=
X-Received: by 2002:aca:b357:: with SMTP id c84mr2928258oif.118.1593103475571; 
 Thu, 25 Jun 2020 09:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200625162602.700741-1-eblake@redhat.com>
 <ebba61cb-635f-b9f8-94bc-a616db160230@redhat.com>
In-Reply-To: <ebba61cb-635f-b9f8-94bc-a616db160230@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 25 Jun 2020 18:44:24 +0200
Message-ID: <CAP+75-Ux6BJcjGrorrRjUm6jE91eJ0XtMof+KNs9Mxsv4dnNaw@mail.gmail.com>
Subject: Re: [PATCH v5] osdep: Make MIN/MAX evaluate arguments only once
To: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 6:36 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 6/25/20 6:26 PM, Eric Blake wrote:
> > I'm not aware of any immediate bugs in qemu where a second runtime
> > evaluation of the arguments to MIN() or MAX() causes a problem, but
> > proactively preventing such abuse is easier than falling prey to an
> > unintended case down the road.  At any rate, here's the conversation
> > that sparked the current patch:
> > https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05718.html
> >
> > Update the MIN/MAX macros to only evaluate their argument once at
> > runtime; this uses typeof(1 ? (a) : (b)) to ensure that we are
> > promoting the temporaries to the same type as the final comparison (we
> > have to trigger type promotion, as typeof(bitfield) won't compile; and
> > we can't use typeof((a) + (b)) or even typeof((a) + 0), as some of our
> > uses of MAX are on void* pointers where such addition is undefined).
> >
> > However, we are unable to work around gcc refusing to compile ({}) in
> > a constant context (such as the array length of a static variable),
> > even when only used in the dead branch of a __builtin_choose_expr(),
> > so we have to provide a second macro pair MIN_CONST and MAX_CONST for
> > use when both arguments are known to be compile-time constants and
> > where the result must also be usable as a constant; this second form
> > evaluates arguments multiple times but that doesn't matter for
> > constants.  By using a void expression as the expansion if a
> > non-constant is presented to this second form, we can enlist the
> > compiler to ensure the double evaluation is not attempted on
> > non-constants.
> >
> > Alas, as both macros now rely on compiler intrinsics, they are no
> > longer usable in preprocessor #if conditions; those will just have to
> > be open-coded or the logic rewritten into #define or runtime 'if'
> > conditions (but where the compiler dead-code-elimination will probably
> > still apply).
> >
> > I tested that both gcc 10.1.1 and clang 10.0.0 produce errors for all
> > forms of macro mis-use.  As the errors can sometimes be cryptic, I'm
> > demonstrating the gcc output:
> >
> > Use of MIN when MIN_CONST is needed:
> >
> > In file included from /home/eblake/qemu/qemu-img.c:25:
> > /home/eblake/qemu/include/qemu/osdep.h:249:5: error: braced-group withi=
n expression allowed only inside a function
> >   249 |     ({                                                  \
> >       |     ^
> > /home/eblake/qemu/qemu-img.c:92:12: note: in expansion of macro =E2=80=
=98MIN=E2=80=99
> >    92 | char array[MIN(1, 2)] =3D "";
> >       |            ^~~
> >
> > Use of MIN_CONST when MIN is needed:
> >
> > /home/eblake/qemu/qemu-img.c: In function =E2=80=98is_allocated_sectors=
=E2=80=99:
> > /home/eblake/qemu/qemu-img.c:1225:15: error: void value not ignored as =
it ought to be
> >  1225 |             i =3D MIN_CONST(i, n);
> >       |               ^
> >
> > Use of MIN in the preprocessor:
> >
> > In file included from /home/eblake/qemu/accel/tcg/translate-all.c:20:
> > /home/eblake/qemu/accel/tcg/translate-all.c: In function =E2=80=98page_=
check_range=E2=80=99:
> > /home/eblake/qemu/include/qemu/osdep.h:249:6: error: token "{" is not v=
alid in preprocessor expressions
> >   249 |     ({                                                  \
> >       |      ^
> >
> > Fix the resulting callsites that used #if or computed a compile-time
> > constant min or max to use the new macros.  cpu-defs.h is interesting,
> > as CPU_TLB_DYN_MAX_BITS is sometimes used as a constant and sometimes
> > dynamic.
> >
> > It may be worth improving glib's MIN/MAX definitions to be saner, but
> > that is a task for another day.
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> >
>
> Nice! (btw why extra line after s-o-b?)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>
> > ---
> >
> > v2 was: https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00727.=
html
> > v3: avoid __auto_type [Richard], document other approaches that fail
> > [Dave], rebase to master
> > v4: use ((void)0) instead of __builtin_unreachable [Dave], update comme=
nts
> > v5: fix typo, comment formatting, one more __builtin_unreachable
> > ---
> >  hw/usb/hcd-xhci.h         |  2 +-
> >  include/block/block.h     |  4 +--
> >  include/exec/cpu-all.h    |  8 +++---
> >  include/exec/cpu-defs.h   |  7 ++++-
> >  include/qemu/osdep.h      | 57 ++++++++++++++++++++++++++++++++-------
> >  accel/tcg/translate-all.c |  6 ++---
> >  migration/qemu-file.c     |  2 +-
> >  7 files changed, 63 insertions(+), 23 deletions(-)


