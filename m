Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D11BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0662D20767
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwZwflhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0662D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnSHv-0001Vh-8D
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 15:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnSHE-00015z-VO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:38:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnSHD-0001Yp-42
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:38:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id k15so14127818otp.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QJWkn9zt4ilJDPW4zjmy+57fNYr+r7Hwk9Zenipgmbs=;
 b=pwZwflhkImZttMjdC4yjwxZ3v2og7XY4A1tOz8rELUWOGxydu13nR1mt31250yD97u
 ichLKPrRTCvjWkfo9/CD/PleTBO5WtEKeVZQP9l2KDMyrXx0p78Mk5nO17j1U2IrWXv/
 YAZ67t8JgRq1VsOgE7ByWDykt5FRyyFe7XM5BnEB7NToULbPj7flwTJeiFEF96NwQn8q
 XPbQH3IFEavfxPBs+x8rY/LBKtUJEUSzP3e++MwdLYu6QABGa8V+WzbSlxXcOHFylwLH
 dylur7pkOMTWmCARTaqWOvffqBg2wZoGrg7VI2a5n3w6dQjEKHzw/kme2bV5nVlGYo/K
 IMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QJWkn9zt4ilJDPW4zjmy+57fNYr+r7Hwk9Zenipgmbs=;
 b=moYK2xg+PqTmjPhnOtXyA4SBNa7svcyjG9S/7uWUlhuVchsu7FJvqbwLvOGJ9S/0tv
 hOzDpott4G+p0koSXiS+7XaR0TbKAgRLPVcaUyyNhjzzhRcn2EaA9osgfjMzkHURloy9
 bRhfycgDY91Url6dYoDB0hStkCT4zU7y7n3o5q93mWN5gRPq3wepvIkXg32QXG1lHCVi
 kzm/UIn+re4D3GwD614bdWD4o1lpJ96KJiv7a++vom0nJdaQB44zgoJGkAVZo8H9rTED
 04hZipQ0j27NJgGEX756OKaVEadlXBqdvPkj2q8dkB+epHqnI3oIKq4ew1sucZAyQKHx
 wBIQ==
X-Gm-Message-State: AOAM532msad7EZ5NIq1Jy3kEyRmBzqb8v9P8Gl7O4dG/Ul+7G2t0mcfq
 L1gb+YHLPUVn1Opv2+5VLbNgZVDG4Dp1VPXf4ULYtA==
X-Google-Smtp-Source: ABdhPJxA4spKQNLZjhBsBWf10VhQsIn0r79DddpPf1O9pfGORIc2N6oNwMC05aS3WfrweJjGQOVeMrZDWZ3FPycwQsY=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr15207929oto.91.1592854721585; 
 Mon, 22 Jun 2020 12:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592686588.git.balaton@eik.bme.hu>
 <f0b64bf047e343f8b2e91baeccb4753bc26b17cc.1592686588.git.balaton@eik.bme.hu>
In-Reply-To: <f0b64bf047e343f8b2e91baeccb4753bc26b17cc.1592686588.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 20:38:30 +0100
Message-ID: <CAFEAcA8J-CTYXxGEsuFF0Oc2DE-PuK3BYmosSSmRhQSCc5sjXQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] sm501: Fix and optimize overlap check
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 20 Jun 2020 at 22:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> When doing reverse blit we need to check if source and dest overlap
> but it is not trivial due to possible different base and pitch of
> source and dest. Do rectangle overlap if base and pitch match,
> otherwise just check if memory area containing the rects overlaps so
> rects could possibly overlap.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 2db347dcbc..e7c69bf7fd 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -690,6 +690,7 @@ static void sm501_2d_operation(SM501State *s)
>      unsigned int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
>      int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
>      int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
> +    bool overlap = false;
>
>      if ((s->twoD_stretch >> 16) & 0xF) {
>          qemu_log_mask(LOG_UNIMP, "sm501: only XY addressing is supported.\n");
> @@ -784,16 +785,21 @@ static void sm501_2d_operation(SM501State *s)
>                           ldn_he_p(&s->local_mem[src_base + si], bypp));
>                  break;
>              }
> -            /* Check for overlaps, this could be made more exact */
> -            uint32_t sb, se, db, de;
> -            sb = src_base + src_x + src_y * (width + src_pitch);
> -            se = sb + width + height * (width + src_pitch);
> -            db = dst_base + dst_x + dst_y * (width + dst_pitch);
> -            de = db + width + height * (width + dst_pitch);
> -            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
> -                /* regions may overlap: copy via temporary */
> -                int llb = width * bypp;
> -                int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
> +            /* If reverse blit do simple check for overlaps */
> +            if (rtl && src_base == dst_base && src_pitch == dst_pitch) {
> +                overlap = (src_x < dst_x + width && src_x + width > dst_x &&
> +                           src_y < dst_y + height && src_y + height > dst_y);

This part looks good...

> +            } else if (rtl) {
> +                unsigned int sb, se, db, de;
> +                sb = src_base + (src_x + src_y * src_pitch) * bypp;
> +                se = sb + (width + height * src_pitch) * bypp;
> +                db = dst_base + (dst_x + dst_y * dst_pitch) * bypp;
> +                de = db + (width + height * dst_pitch) * bypp;
> +                overlap = (db >= sb && db <= se) || (de >= sb && de <= se);

...but this part I think the overlap calculation isn't right. Consider
 db=5, de=15, sb=10, se=12. This gives overlap=false but
the two regions do overlap because [sb,se] is entirely inside [db,de].
I think you want
  overlap = (db < se && sb < de);
(this is the same logic as each of the x/y range checks in the rectangle
overlap test. put another way, if !(db<se) then we can't have an overlap
because the dest range starts after the source range ends; similarly if
!(sb<de) then the source range begins after the dest range ends and
there's no overlap. So for an overlap to be possible we must have both
db<se && sb<de.)
Here I'm using a definition of the "end" de and se which is that they point
to the byte *after* the last one used (ie that we're really working with
"half-open" ranges [db, de)  and [sb, se) where de and se aren't in the
range), because that's easier to calculate given that we need to account
for bypp and it's more natural when dealing with "start, length" pairs.

Also and less importantly (because it's wrong in the "safe" direction) I think
your se and de are overestimates, because one-past-the-last-used-byte in each
case is
   sb + (width + (height-1) * src_pitch) * bypp
(consider width=1 height=1, where one-past-the-last-used-byte is sb + bypp
because there's only one pixel involved).

> +            }
> +            if (overlap) {
> +                /* pixman can't do reverse blit: copy via temporary */
> +                int tmp_stride = DIV_ROUND_UP(width * bypp, sizeof(uint32_t));
>                  uint32_t *tmp = tmp_buf;
>
>                  if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {

PS: why do we care about overlap only for right-to-left blits and not
left-to-right blits ?

thanks
-- PMM

