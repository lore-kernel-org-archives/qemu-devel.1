Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350FCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B772071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXeX4xEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B772071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kARoW-0006Nj-7Z
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 01:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kARnx-0005wa-53
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 01:47:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kARnv-0007gg-6Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 01:47:32 -0400
Received: by mail-ot1-x341.google.com with SMTP id z18so9448199otk.6
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 22:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8129R7RIt/pXEkp9qdumq2LLGoxvq1WJI5NAzQD/Nvg=;
 b=FXeX4xEK7cZO5Q8OymKL31w3uGRbFVx7FEIE2QtFlpXcwfRU+JeF3YGbV2KfOVMTEm
 dO7VJe+QaHo/P5CxJ8TgP7ORx7krw9z4OwWOO+3gXikcRIKigfeZUqh5dnMrz7a3LlqM
 8RG1dCgF6zP//yuaeo+QrP5fzhSA3qevXPjO76DxR100Ba+wcsn81JQ1IN4gM4CSW9xP
 EOz/Vob694TsUEwp4GJMIXuxrmiOk4RtIZvUqRAW9GfurYzq1+/CrgXJRNPmLseuLw5X
 zHYdOljuvGOcMRYHmtPJUPrutlFshiWVcdw4SMD2f+ijw9l5VLFb+sv6bt4AFT7GxkHL
 Bd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8129R7RIt/pXEkp9qdumq2LLGoxvq1WJI5NAzQD/Nvg=;
 b=CoYU5Q0rf1HHcvbqc/HDfIadK7bb5NSfcTAdlnRKYg2mZYTm9GnbSuZAdJY/z0z/ew
 7Gmsj76rpDIxYCfw2Tws8mZy659Uj45wVkbvDh5s9OKXIoNPfqZ6eRrgucxJ4tsCXSah
 QMbHFBZJhwBTRYvKOGMxLDlh+CWVZH2mb0Qp/AHwodg1u9uiPg7MM4sILnkbt0QrDKRn
 GDEELObbg/c61MGFHiPXj13uYYE/ezz3DyEGaYKj/ahbKUp6AywiSZkC4ZaiamqGgYvt
 GKCT3DZh1Qx+suyJUZ2IFzSCyxVMn/LOMS382KQL9yc8Rt4NWzXALLTercXeq+ooRKtV
 egKA==
X-Gm-Message-State: AOAM5327PB9px+qA3VIP5aDLKFdHyQsEnpxEREvxBQG60wYDFgV7oNV0
 R/V3CWAApRyxg1Y6rYGC5JH9B/WRmTJIBzpNHM0=
X-Google-Smtp-Source: ABdhPJziJhhHUHkEYypx1qvhveSCwFCpB/141KY+iGVZHTDBv1tblzhgKhsJ3Tpm/v7AnjK0UAF6KqCoCZixbkp+gas=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr3305196otn.333.1598334449466; 
 Mon, 24 Aug 2020 22:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200825053636.29648-1-kraxel@redhat.com>
In-Reply-To: <20200825053636.29648-1-kraxel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 25 Aug 2020 13:46:53 +0800
Message-ID: <CAKXe6SKrTLAgRE4Wnk4sJkxzvXHD_FoaXBBrM_utLRtbJrCvRw@mail.gmail.com>
Subject: Re: [PATCH] usb: fix setup_len init (CVE-2020-14364)
To: Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Gonglei <arei.gonglei@huawei.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Store calculated setup_len in a local variable, verify it, and only
> write it to the struct (USBDevice->setup_len) in case it passed the
> sanity checks.
>
> This prevents other code (do_token_{in,out} functions specifically)
> from working with invalid USBDevice->setup_len values and overrunning
> the USBDevice->setup_buf[] buffer.
>
> Fixes: CVE-2020-14364
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Gonglei <arei.gonglei@huawei.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

Just see the page.
-->https://access.redhat.com/security/cve/CVE-2020-14364

The 'Attack Vector' of the CVSS score here is 'local'.

Hi Prasad,
I think this should be 'network' as the guest user can touch this in
cloud environment?
What's the consideration here?

Thanks,
Li Qiang

> ---
>  hw/usb/core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/hw/usb/core.c b/hw/usb/core.c
> index 5abd128b6bc5..5234dcc73fea 100644
> --- a/hw/usb/core.c
> +++ b/hw/usb/core.c
> @@ -129,6 +129,7 @@ void usb_wakeup(USBEndpoint *ep, unsigned int stream)
>  static void do_token_setup(USBDevice *s, USBPacket *p)
>  {
>      int request, value, index;
> +    unsigned int setup_len;
>
>      if (p->iov.size !=3D 8) {
>          p->status =3D USB_RET_STALL;
> @@ -138,14 +139,15 @@ static void do_token_setup(USBDevice *s, USBPacket =
*p)
>      usb_packet_copy(p, s->setup_buf, p->iov.size);
>      s->setup_index =3D 0;
>      p->actual_length =3D 0;
> -    s->setup_len   =3D (s->setup_buf[7] << 8) | s->setup_buf[6];
> -    if (s->setup_len > sizeof(s->data_buf)) {
> +    setup_len =3D (s->setup_buf[7] << 8) | s->setup_buf[6];
> +    if (setup_len > sizeof(s->data_buf)) {
>          fprintf(stderr,
>                  "usb_generic_handle_packet: ctrl buffer too small (%d > =
%zu)\n",
> -                s->setup_len, sizeof(s->data_buf));
> +                setup_len, sizeof(s->data_buf));
>          p->status =3D USB_RET_STALL;
>          return;
>      }
> +    s->setup_len =3D setup_len;
>
>      request =3D (s->setup_buf[0] << 8) | s->setup_buf[1];
>      value   =3D (s->setup_buf[3] << 8) | s->setup_buf[2];
> @@ -259,26 +261,28 @@ static void do_token_out(USBDevice *s, USBPacket *p=
)
>  static void do_parameter(USBDevice *s, USBPacket *p)
>  {
>      int i, request, value, index;
> +    unsigned int setup_len;
>
>      for (i =3D 0; i < 8; i++) {
>          s->setup_buf[i] =3D p->parameter >> (i*8);
>      }
>
>      s->setup_state =3D SETUP_STATE_PARAM;
> -    s->setup_len   =3D (s->setup_buf[7] << 8) | s->setup_buf[6];
>      s->setup_index =3D 0;
>
>      request =3D (s->setup_buf[0] << 8) | s->setup_buf[1];
>      value   =3D (s->setup_buf[3] << 8) | s->setup_buf[2];
>      index   =3D (s->setup_buf[5] << 8) | s->setup_buf[4];
>
> -    if (s->setup_len > sizeof(s->data_buf)) {
> +    setup_len =3D (s->setup_buf[7] << 8) | s->setup_buf[6];
> +    if (setup_len > sizeof(s->data_buf)) {
>          fprintf(stderr,
>                  "usb_generic_handle_packet: ctrl buffer too small (%d > =
%zu)\n",
> -                s->setup_len, sizeof(s->data_buf));
> +                setup_len, sizeof(s->data_buf));
>          p->status =3D USB_RET_STALL;
>          return;
>      }
> +    s->setup_len =3D setup_len;
>
>      if (p->pid =3D=3D USB_TOKEN_OUT) {
>          usb_packet_copy(p, s->data_buf, s->setup_len);
> --
> 2.27.0
>
>

