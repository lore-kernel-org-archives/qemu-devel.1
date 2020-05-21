Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CBE206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDEeCpof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CBE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbl65-0001p4-1I
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jbl5K-0001KG-0a
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:18:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jbl5I-0002am-2T
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590067082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3voQyfA2Tdlb/3wlh//oMjYbLGIwwt9nZNJESQD/Js=;
 b=UDEeCpofuwqUuauoVSxGnOqv/QsuyYuaOteO0dTvbMJtmCh0RYPs7K1+s2fXOSlaMuUpbO
 6QI1XsfjfL9EDNu51mC3DGevQ+i7+j7aba5ox0C4MTlaHQPZgGhY4iJUrwlduXBm/QbJeU
 OYc1nc5QijAUb6X0KWU3GLzoO7r/PB0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-rupmn30COwC71HkuTWTM4A-1; Thu, 21 May 2020 09:17:59 -0400
X-MC-Unique: rupmn30COwC71HkuTWTM4A-1
Received: by mail-oi1-f199.google.com with SMTP id v203so3261007oie.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a3voQyfA2Tdlb/3wlh//oMjYbLGIwwt9nZNJESQD/Js=;
 b=XztN3+vWBokQL+sbTgzi0iBGcVppZlyLHsWJAgM5yWqQyXyDOiNRcBPIloXPEVugjr
 /21BqJa0rl/nuTw3S7rfzzDnDoHrO48Eqbuj0vz4/ojPypx7Y38SlPb6SIGWVSHSRkMU
 QUg5lm8ehyLofUg7oztT/Te357EZvXFYPFku8+KHXZi8QRO7sTURlJV5pB/6rpT8ldAG
 EoKSTTancoVjXpkfLzQdyRMwIJ3BYbzMTKuPo41lTqansp6P3FPhhWTSiAyPTJ19VyLo
 VKqT4Gf3VmMht1B9pxMSsERD+WtW/StQw4KZY2/SS1RyHp7GuvYJy846QlSSrG9UrYQS
 MWLw==
X-Gm-Message-State: AOAM533E8z9IrnK0TcN20P/EwkYDlFdDmPX0U9fvLGCOytX6C/8s2/Bo
 2mx5sg08T3wab6sk4/1X5/DSg/HStFN5HElVa2HPwUERjJ7P424MLMJtGmdCEzFD63xFdSW3SsC
 mD9VjHMMe2mJSDSC7hlYOA/m2gtdgQcw=
X-Received: by 2002:a9d:4c6:: with SMTP id 64mr7285925otm.315.1590067077011;
 Thu, 21 May 2020 06:17:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye1s7sFJA67/mP1sQsxxfl9oV1ij5TKvsKErUyfOPFEFjU+VJO305LznLVeNkQUpLx5aHBo63rlNJ6hZg4VL0=
X-Received: by 2002:a9d:4c6:: with SMTP id 64mr7285898otm.315.1590067076580;
 Thu, 21 May 2020 06:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-3-eblake@redhat.com>
 <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
 <69fec648-ec51-6a0d-1703-4017db901119@redhat.com>
In-Reply-To: <69fec648-ec51-6a0d-1703-4017db901119@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 21 May 2020 16:17:40 +0300
Message-ID: <CAMRbyyu5v_RverJzkNVfV56VViKVyUE=STVyz=--EfVG-bo74A@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 4:08 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 5/20/20 6:00 PM, Nir Soffer wrote:
>
> >>
> >> On the command-line side, 'qemu-img measure' gains a new --bitmaps
> >> flag.  When present, the bitmap size is rolled into the two existing
> >> measures (or errors if either the source image or destination format
> >> lacks bitmaps); when absent, there is never an error (for
> >> back-compat), but the output will instead include a new line item for
> >> bitmaps (which you would have to manually add), with that line being
> >> omitted in the same cases where passing --bitmaps would error.
> >
> > Supporting 2 ways to measure, one by specifying --bitmaps, and another
> > by adding bitmaps key is not a good idea. We really need one way.
> >
> > Each one has advantages. adding --bitmaps flag is consistent with
> > "qemu-img convert"
> > and future extensions that may require  new flag, and adding "bitmaps"
> > key is consistent
> > with "qmeu-img info", showing bitmaps when they exist.
> >
> > Adding a "bitmaps" key has an advantage that we can use it to test if qemu-img
> > supports measuring and copying bitmaps (since both features are expected to
> > be delivered at the same time). So we can avoid checking --help learn about
> > the capabilities.
> >
> > I'm ok with both options, can we have only one?
>
> That was the crux of the conversation after v3, where we were trying to
> figure out what interface you actually needed.  I implemented both to
> show the difference, but if you want only one, then my preference is to
> delete the --bitmaps option and only expose the optional 'bitmaps size'
> field in all cases where bitmaps can be copied.

I'm fine with this approach - but the bitmaps optional field should be displayed
even if there are no bitmaps in the source, so I can tell if tihs
version of qemu-img
supports measuring/copying bitmaps.

If measure reports bitmaps size we will create a large enough disk and
copy the bitmaps,
and if not we will have to drop the relevant backup history for this
vm, since the copy
will not include the bitmaps. The next backup for this vm will have to
be a full backup.

> Here's the diff that would accomplish that:

Diff does not eliminate the "bitmaps: 0" outputs, so it looks good.

>
> diff --git i/docs/tools/qemu-img.rst w/docs/tools/qemu-img.rst
> index 35050fc51070..69cd9a30373a 100644
> --- i/docs/tools/qemu-img.rst
> +++ w/docs/tools/qemu-img.rst
> @@ -597,7 +597,7 @@ Command description:
>     For more information, consult ``include/block/block.h`` in QEMU's
>     source code.
>
> -.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS]
> [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [--bitmaps] [-l
> SNAPSHOT_PARAM] FILENAME]
> +.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS]
> [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l
> SNAPSHOT_PARAM] FILENAME]
>
>     Calculate the file size required for a new image.  This information
>     can be used to size logical volumes or SAN LUNs appropriately for
> @@ -634,10 +634,7 @@ Command description:
>     copy bitmaps from a source image in addition to the guest-visible
>     data; the line is omitted if either source or destination lacks
>     bitmap support, or 0 if bitmaps are supported but there is nothing
> -  to copy.  If the ``--bitmaps`` option is in use, the bitmap size is
> -  instead folded into the required and fully-allocated size for
> -  convenience, rather than being a separate line item; using the
> -  option will raise an error if bitmaps are not supported.
> +  to copy.
>
>   .. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l
> | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
>
> diff --git i/qemu-img.c w/qemu-img.c
> index 1494d8f5c409..8dc4cae2c274 100644
> --- i/qemu-img.c
> +++ w/qemu-img.c
> @@ -5207,7 +5207,6 @@ static int img_measure(int argc, char **argv)
>           {"output", required_argument, 0, OPTION_OUTPUT},
>           {"size", required_argument, 0, OPTION_SIZE},
>           {"force-share", no_argument, 0, 'U'},
> -        {"bitmaps", no_argument, 0, OPTION_BITMAPS},
>           {0, 0, 0, 0}
>       };
>       OutputFormat output_format = OFORMAT_HUMAN;
> @@ -5224,7 +5223,6 @@ static int img_measure(int argc, char **argv)
>       QemuOpts *sn_opts = NULL;
>       QemuOptsList *create_opts = NULL;
>       bool image_opts = false;
> -    bool bitmaps = false;
>       uint64_t img_size = UINT64_MAX;
>       BlockMeasureInfo *info = NULL;
>       Error *local_err = NULL;
> @@ -5297,10 +5295,6 @@ static int img_measure(int argc, char **argv)
>               img_size = (uint64_t)sval;
>           }
>           break;
> -        case OPTION_BITMAPS:
> -            bitmaps = true;
> -            break;
> -        }
>       }
>
>       if (qemu_opts_foreach(&qemu_object_opts,
> @@ -5328,10 +5322,6 @@ static int img_measure(int argc, char **argv)
>           error_report("Either --size N or one filename must be
> specified.");
>           goto out;
>       }
> -    if (!filename && bitmaps) {
> -        error_report("--bitmaps is only supported with a filename.");
> -        goto out;
> -    }
>
>       if (filename) {
>           in_blk = img_open(image_opts, filename, fmt, 0,
> @@ -5387,18 +5377,6 @@ static int img_measure(int argc, char **argv)
>           goto out;
>       }
>
> -    if (bitmaps) {
> -        if (!info->has_bitmaps) {
> -            error_report("no bitmaps measured, either source or
> destination "
> -                         "format lacks bitmap support");
> -            goto out;
> -        } else {
> -            info->required += info->bitmaps;
> -            info->fully_allocated += info->bitmaps;
> -            info->has_bitmaps = false;
> -        }
> -    }
> -
>       if (output_format == OFORMAT_HUMAN) {
>           printf("required size: %" PRIu64 "\n", info->required);
>           printf("fully allocated size: %" PRIu64 "\n",
> info->fully_allocated);
> diff --git i/qemu-img-cmds.hx w/qemu-img-cmds.hx
> index e9beb15e614e..10b910b67cf8 100644
> --- i/qemu-img-cmds.hx
> +++ w/qemu-img-cmds.hx
> @@ -76,9 +76,9 @@ SRST
>   ERST
>
>   DEF("measure", img_measure,
> -"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N |
> [--object objectdef] [--image-opts] [-f fmt] [--bitmaps] [-l
> snapshot_param] filename]")
> +"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N |
> [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
>   SRST
> -.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS]
> [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [--bitmaps] [-l
> SNAPSHOT_PARAM] FILENAME]
> +.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS]
> [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l
> SNAPSHOT_PARAM] FILENAME]
>   ERST
>
>   DEF("snapshot", img_snapshot,
>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>


