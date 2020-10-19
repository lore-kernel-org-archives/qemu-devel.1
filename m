Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E042D2225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E042D2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUdbu-0000sX-RY
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 18:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUda6-0008Td-IU
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:24:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kUda5-0001Kr-2l
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 18:24:42 -0400
Received: by mail-io1-f66.google.com with SMTP id h21so1819053iob.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h4MNzP64P/GA8hdLKKUQ8WNyx/IY1akuF6qGVFNn3/Q=;
 b=OyKyFauJX/5ZfAi0Th113tXhUCpDx2mncujZi99BB0L9upd3cvcqHqwhZ2nnpbD4lX
 2Z0EF0NCifjQHOtjSMiD2A9km/9WmaXcqXuu+1HC4NPeaASklXNKbRL24csW/GyCrZ79
 9EUBpXxXK7hb1u6NgaeOboR9Pp1EmV/xXuvnBb30c8XcCaUxjzaw52Avug3ris1fZtKK
 M7SXQ0BO+IOWhXFyoPtehzk06L1oavMia4V3Y5160JvAC4blTEsPP6IU3WlG+4xNwrwF
 PNqPmViZ6KGErw0qBE6Zv7zqoymxW9kQEtk6tL5lO+uqrN6qVcb+HgF+sh23z6SEeyT8
 UFNA==
X-Gm-Message-State: AOAM5310jH2FBLncYkjJBGYzgd1P8RE7z0QqsPL0xKqWjnC+UzDZQREp
 pFkqpS08OsveduqCVLTWUUdhfie0NbE=
X-Google-Smtp-Source: ABdhPJzjMTwn5ZJuQCqZFg2toLk/fyvcF2acHTy3r1qPVzwBNbzykO04ywz6vZnEtNSnMjGJW6S+7g==
X-Received: by 2002:a6b:1542:: with SMTP id 63mr1395580iov.64.1603146279947;
 Mon, 19 Oct 2020 15:24:39 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173])
 by smtp.gmail.com with ESMTPSA id d14sm988861ila.42.2020.10.19.15.24.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 15:24:39 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id g7so2041791ilr.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 15:24:39 -0700 (PDT)
X-Received: by 2002:a92:b109:: with SMTP id t9mr1765896ilh.191.1603146279218; 
 Mon, 19 Oct 2020 15:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
In-Reply-To: <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 19 Oct 2020 15:24:28 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
Message-ID: <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.66; envelope-from=osy86dev@gmail.com;
 helo=mail-io1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 18:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Correct me if I'm wrong but wouldn't the following test still fail
with --cross-prefix=""

if test -n "$cross_prefix"; then
...

That was my main reason for making this change.

-j

On Mon, Oct 19, 2020 at 4:24 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 19 Oct 2020, Thomas Huth wrote:
> > On 19/10/2020 10.07, Thomas Huth wrote:
> >> On 19/10/2020 03.39, Joelle van Dyne wrote:
> >>> From: osy <osy86@users.noreply.github.com>
> >>>
> >>> The iOS toolchain does not use the host prefix naming convention. We add a
> >>> new option `--enable-cross-compile` that forces cross-compile even without
> >>> a cross_prefix.
> >>>
> >>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >>> ---
> >>>  configure | 13 ++++++++++++-
> >>>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/configure b/configure
> >>> index 3c63879750..46d5db63e8 100755
> >>> --- a/configure
> >>> +++ b/configure
> >>> @@ -234,6 +234,7 @@ cpu=""
> >>>  iasl="iasl"
> >>>  interp_prefix="/usr/gnemul/qemu-%M"
> >>>  static="no"
> >>> +cross_compile="no"
> >>>  cross_prefix=""
> >>>  audio_drv_list=""
> >>>  block_drv_rw_whitelist=""
> >>> @@ -456,6 +457,11 @@ for opt do
> >>>    optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
> >>>    case "$opt" in
> >>>    --cross-prefix=*) cross_prefix="$optarg"
> >>> +                    cross_compile="yes"
> >>> +  ;;
> >>> +  --enable-cross-compile) cross_compile="yes"
> >>> +  ;;
> >>> +  --disable-cross-compile) cross_compile="no"
> >>
> >> Can't you simply use --cros-prefix="" instead?
> >
> > I mean, still introduce the "cross_compile=yes" variable, just omit the new
> > options.
>
> That seems less intuitive for people trying to find this option. If --help
> lists --enable-cross-compile I can guess what that means but there's no
> way I could guess --cros-prefix="" unless I've been told or searched and
> stumbled upon it. So unless it's a big problem I like the explicit options
> better. Or is that a convention in other projects to use empty prefix to
> enable cross compile that I don't know about?
>
> Regards,
> BALATON Zoltan

