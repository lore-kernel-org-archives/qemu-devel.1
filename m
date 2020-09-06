Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86AAC43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 10:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A1D20C09
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 10:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnfW8TO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A1D20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEsO8-0000nH-Qf
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 06:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kEsNO-0000I5-03; Sun, 06 Sep 2020 06:58:26 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kEsNJ-0004tp-7x; Sun, 06 Sep 2020 06:58:25 -0400
Received: by mail-ej1-x643.google.com with SMTP id gr14so13031980ejb.1;
 Sun, 06 Sep 2020 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=/Dta+vMz4GOoDJrEcjwZklzloG6EdgCv6g7arRk1UMA=;
 b=hnfW8TO5ju7gUfLAyUEVQMX4HXKML/01RAkLt3nnp66sg/Dfm8wBj9rxBbtukEjO/P
 dvdKLrGs6dLaBHeMjcog1aLyROWI/sGZHvndYGaDhp+epi1KsYVCAwRgluxmSoa7aQtY
 zaOlCa/HdIMDyVC2uSStSNLpqOmsAGVz72nf6lb7dx6hj5Ih5pBWjyPzrgGg1fG48/ZH
 haKiDBKwqb202OBhZIZQNOdR3811khUvzHL6B+5R0WH95X4COBsUXYorVsZGNWfB68KE
 ytC3CHbFOAy1cWR5hJcZpwyNbUWnzrN8hpMe4v0scpNJwV4YVerwURQyJgn3x1YGnbEM
 s7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=/Dta+vMz4GOoDJrEcjwZklzloG6EdgCv6g7arRk1UMA=;
 b=QqxrAyyan5qQMTR0Zh1oo1OL4gfCbbcwb7UONllEvsiW+DexeYSXJvbCQwhWlCC2nX
 DJRUM++mi9V4KGmAPJYzSO9K6szt4RTSDc9SUzoRXGOouP1sCij9LBnYrCpwRMp3pdU6
 d4HVTYhfcPs6bm/Tt9dqRx8Dzv/58BNpaFBVO2sgCLa7/ztqLuGcVK0qrfoxRBfVo6oD
 1WEaaC7OCGOZwA/qDWPdt6qu16Rnql2Zgl1mvK53P/1N5OfsqIN1JKSkuw57XUJVr84d
 5ghK7bAQfX7/NyWcE3mIlN9Zy7pUFp4SGOC/kqfXEYlLhErshyw70oL/XfD4zzoe3jY+
 ou2g==
X-Gm-Message-State: AOAM530dg/4Ne4oItKZEZU5m47z0QLdy20Tq2LWBqiGbYz2/7VyHzZgY
 2Fxw2ty3nIBKQLHM8ejoro8U5DGEgoQVl7lnmCMioksx96E=
X-Google-Smtp-Source: ABdhPJzhz0Gtg99LAw8cv5WBbipoEdiy4/Z0AjOBbOBYGz7mn+0ChowhdoimgXIVk8pAFaj4lkhouygnsvutha2ScPY=
X-Received: by 2002:a17:906:2a17:: with SMTP id
 j23mr5360715eje.146.1599389897846; 
 Sun, 06 Sep 2020 03:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200904020907.241550-1-tom.ty89@gmail.com>
 <20200904020907.241550-2-tom.ty89@gmail.com>
In-Reply-To: <20200904020907.241550-2-tom.ty89@gmail.com>
From: Tom Yan <tom.ty89@gmail.com>
Date: Sun, 6 Sep 2020 18:58:06 +0800
Message-ID: <CAGnHSEnF--OJ9biTx_ZxgqizVtr+0rBL8o-b9wY9+XNsnLPV=A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] file-posix: add sg_get_max_segments that actually
 works with sg
To: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, 
 qemu-devel@nongnu.org, mlevitsk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=tom.ty89@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In commit 867eccfed84f96b54f4a432c510a02c2ce03b430, Levitsky appears
to have assumed that the only "SCSI Passthrough" is `-device
scsi-generic`, while the fact is there's also `-device scsi-block`
(passthrough without the sg driver). Unlike `-device scsi-hd`, getting
max_sectors is necessary to it (more precisely, hw_max_sectors might
what matters, but BLKSECTGET reports max_sectors, so).

I'm unsure about how qemu-nbd works, but the commit clearly wasn't the
right approach to fix the original issue it addresses. (It should for
example ignore the max_transfer if it will never matter in to it, or
overrides it in certain cases; when I glimpsed over
https://bugzilla.redhat.com/show_bug.cgi?id=1647104, I don't see how
it could be file-posix problem when it is reporting the right thing,
regardless of whether "removing" the code helps.)

I don't think we want to "mark" `-device scsi-block` as sg either. It
will probably bring even more unexpected problems, because they are
literally different sets of things behind the scene / in the kernel.

On Fri, 4 Sep 2020 at 10:09, Tom Yan <tom.ty89@gmail.com> wrote:
>
> sg devices have different major/minor than their corresponding
> block devices. Using sysfs to get max segments never really worked
> for them.
>
> Fortunately the sg driver provides an ioctl to get sg_tablesize,
> which is apparently equivalent to max segments.
>
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> ---
>  block/file-posix.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 411a23cf99..9e37594145 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1178,6 +1178,21 @@ static int sg_get_max_transfer_length(int fd)
>  #endif
>  }
>
> +static int sg_get_max_segments(int fd)
> +{
> +#ifdef SG_GET_SG_TABLESIZE
> +    long max_segments = 0;
> +
> +    if (ioctl(fd, SG_GET_SG_TABLESIZE, &max_segments) == 0) {
> +        return max_segments;
> +    } else {
> +        return -errno;
> +    }
> +#else
> +    return -ENOSYS;
> +#endif
> +}
> +
>  static int get_max_transfer_length(int fd)
>  {
>  #if defined(BLKSECTGET) && defined(BLKSSZGET)
> @@ -1268,7 +1283,7 @@ static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
>          bs->bl.max_transfer = pow2floor(ret);
>      }
>
> -    ret = get_max_segments(s->fd);
> +    ret = bs->sg ? sg_get_max_segments(s->fd) : get_max_segments(s->fd);
>      if (ret > 0) {
>          bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
>                                             ret * qemu_real_host_page_size);
> --
> 2.28.0
>

