Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E874CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D52206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRlEE+Xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D52206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqf22-0001Ci-1w
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jqeye-00057q-P9; Wed, 01 Jul 2020 11:48:48 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jqeyd-000134-2R; Wed, 01 Jul 2020 11:48:48 -0400
Received: by mail-ed1-x543.google.com with SMTP id d16so13706301edz.12;
 Wed, 01 Jul 2020 08:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q32RtG8V4Fr7hL0mqz3/MDCOgImuHN+TvsIF9UXXCuw=;
 b=mRlEE+XfRxXkKvkOMwPsWMK1LTjn2lf0rj9ZM/UkpIa/hWeDRanpR/Z+w1Sl9UlOf5
 Q9PSS4oKVw+E+DZr7MUBAB3yR6f5MtJvLvrhsrQNaP7nHdOQlOampvOracA/IQgs3F/B
 3r3fkJyfqSTzhAsreirGu0yKntxYMwCS1Ey34R09stY60QohUy1fpYNqijOHTKRypn+d
 aYCXV7pNU5CsCyOWcuX0hO7wxoJFDDFM89sGmaRId8frG4XLTjWgL/8ntCOQv//wW1V3
 y88V6Siv1nZE0Iro5qyBvOhvQmL9FS3vXw/Fx5qx3QRlOFH+O4DJn8LfYPgnM97Z8uwE
 Mw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q32RtG8V4Fr7hL0mqz3/MDCOgImuHN+TvsIF9UXXCuw=;
 b=pfapwJU0g3glSxJrYoBgkO4civehayWp+Tbula55NzQIkrtOh8EM/kwzX/F/pCf9Mp
 +HXSJw4qxj5O1m2tS2wMH8U6rx7j2mtfiSDpgwqNRdKYCK8HGjdhfIhnBH717Lb0IjDE
 t3iT9C1Sdr5ruLebIEoyzWzYimPXIfSBNQyGOauOv12lXTT4HEuH2LN+tYu1qTzsxnKJ
 61h4O2AlBAM2x3Q9m+yNVY7ShQEps16DiWUdiVomcYgXWVQWpZSP3D5OFVgA2l6UZRTJ
 fKHorwTnVLbrwgYPqpMvpOFbUXMKJT1jyJoIOmOo+9tLXtcYfDE0j4TE4I6SdCZp947j
 TFVg==
X-Gm-Message-State: AOAM5318H2CL+DM4YbtTI+EQnRdMIRSTGSbjjS5b0ZFgV2w9CspBQnxG
 D9vo0tARYKymEGtpBedH7xYTIy6UC+t+Nq/4zIc=
X-Google-Smtp-Source: ABdhPJyDBmkTZGBa0+XnBB8A6PSv7vQCtHQqkM0xCb6T9oaG4qgg0rl+arH9ujTVlIoH5/xhAdSAhwiHxvGQHbUuYq8=
X-Received: by 2002:a05:6402:354:: with SMTP id
 r20mr29656490edw.32.1593618524681; 
 Wed, 01 Jul 2020 08:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzjjrfxXeSENBQuHzTe4TRMWV5GOdqPkD3bo17T3ufR1A@mail.gmail.com>
 <1058ccbd-b4bb-9413-abc5-ae89076a58e1@redhat.com>
 <20200630082301.6vybzwmg4pviuwob@sirius.home.kraxel.org>
 <CAFEAcA8jkzf8+d5AyAVH2HJ544TyHsM4xP5tpWsKiJbJtWMjKw@mail.gmail.com>
 <20200630165356.2ka2ltwmrfjb5msn@sirius.home.kraxel.org>
 <3eb3c266-1a83-9f40-4760-1ab2578ae5d6@redhat.com>
 <20200701151524.wogl4ihbdevgf4bt@sirius.home.kraxel.org>
In-Reply-To: <20200701151524.wogl4ihbdevgf4bt@sirius.home.kraxel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 1 Jul 2020 16:48:33 +0100
Message-ID: <CA+XhMqxUL9vaEycf52umx8aE_PBd0A3hOUVXEBSNFd=ePR8x7Q@mail.gmail.com>
Subject: Re: [PATC 7/9] Skipping drm build, unsupported
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes it does. Regards.

On Wed, 1 Jul 2020 at 16:15, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > Ah, that is the problem.  Yes, DT_CHR is an non-posix optimization which
> > > allows to get the file type directly, without another round-trip to the
> > > kernel.  If that isn't available you can stat() the file and check
> > > ((st_mode & S_IFMT) == S_IFCHR) instead.
> >
> > Even when d_type and DT_CHR is available, there are filesystems where the
> > Linux kernel reports d_type of DT_UNKNOWN, and where you are best having
> > that code also falling back to an fstat().
>
> Given this isn't perforance critical at all it is probably simplest to
> avoid non-portable d_type altogether and just to the fstat
> unconditionally.
>
> David, does that work for haiku?
>
> take care,
>   Gerd
>
> diff --git a/util/drm.c b/util/drm.c
> index a23ff2453826..a1d3520d00f2 100644
> --- a/util/drm.c
> +++ b/util/drm.c
> @@ -24,6 +24,7 @@ int qemu_drm_rendernode_open(const char *rendernode)
>  {
>      DIR *dir;
>      struct dirent *e;
> +    struct stat st;
>      int r, fd;
>      char *p;
>
> @@ -38,10 +39,6 @@ int qemu_drm_rendernode_open(const char *rendernode)
>
>      fd = -1;
>      while ((e = readdir(dir))) {
> -        if (e->d_type != DT_CHR) {
> -            continue;
> -        }
> -
>          if (strncmp(e->d_name, "renderD", 7)) {
>              continue;
>          }
> @@ -53,6 +50,12 @@ int qemu_drm_rendernode_open(const char *rendernode)
>              g_free(p);
>              continue;
>          }
> +        fstat(r, &st);
> +        if ((st.st_mode & S_IFMT) != S_IFCHR) {
> +            close(r);
> +            g_free(p);
> +            continue;
> +        }
>          fd = r;
>          g_free(p);
>          break;
>

