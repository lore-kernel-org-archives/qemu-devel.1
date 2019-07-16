Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A8C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776C8206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRdH4wS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776C8206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLDX-0006vz-1y
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58241)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1hnLDH-0006UK-Eb
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1hnLDF-0006JI-Rd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:01:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1hnLDC-0006D0-3G; Tue, 16 Jul 2019 07:01:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so17248319wrm.8;
 Tue, 16 Jul 2019 04:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y/nrn1aTBBWiysRlPUFbQtjQuzJcAjKwSSO7nD8QQOo=;
 b=HRdH4wS7FFN3Q0/o52Yl8KUEwq7xNcBdHTayjh0lVvNs+s59xwhIRaCog+8fB991j1
 uuB5FvLWoPJkU8bTqS3nuNHT5+sskniV39tOK6BxWrmL5//t7qPfxi2V8tr8noc4M48P
 ZTBe9PBarxo3ffpfyxpLIPgjWsZxhPr19q9dq6wn6bgdNudbUY9+tCiRmf6LG/dDFEEt
 CWYhP8RpwHXPoNViKdjbYm7MhGe+7DKQVBrGtq9v2Usc/rXeEHyAccXWYygKChBOgRBY
 C8sePfFZqhadec+Zyj2m69ZmKB0VYTc0wOwafa6Uiu1nouKVpBjX2/mL6DU2KlqepYNp
 1O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y/nrn1aTBBWiysRlPUFbQtjQuzJcAjKwSSO7nD8QQOo=;
 b=f4XpcJ0OfKDLP+h73nwVAG9eEySIJRFBNPwId94YoyXSLC3TYwGJdjAHV2PdFyLCtO
 Vchm/CWWH2nnHn3Gw9KgqvuG3qHi/LstvjlVrE1bW914yotSHAnN54An8Lbn4UqguY52
 n6/qk8kpI9mRuO+JMftdEF1zRZv/0wLiITbLW62fiIJau73/vc9gKtQysDm2oK96XCic
 jsSjNLHzyooUi8S9ayUCyVrQWqTeIBWUxbFWU1dFpqRGfCoBl8qHFOvxr8U8VgxucuVB
 zMCleTZnNyxa/mKf871McImulyY0fuBk27vk+uR4Fmz4SpAC6WqumlrzB/amhkHQjpdo
 ppWQ==
X-Gm-Message-State: APjAAAWKGek0Yy/k7ZoZRdsoYNsDr5kcNb/ZCs+lW43vrwHHNhTEuqCL
 OsOQ+V0uue0d8NgksWuWLk3nXniRaa/MkCAruoo=
X-Google-Smtp-Source: APXvYqzxlsYTxG4iu27yLGHJfiiVnpBWNDDvUHVmxIh1Kky0Bvn5/NfZ7J5KntS5o1qKpfw+ttG9YvLNEsEI1GYBrvA=
X-Received: by 2002:adf:ed8a:: with SMTP id c10mr36701175wro.33.1563274887142; 
 Tue, 16 Jul 2019 04:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190615051722.13994-1-rfried.dev@gmail.com>
 <CAGi-RUJazCVVh9NwpQ1AHfPdPLW1aYxKst6w6PKfCk2doBz_9w@mail.gmail.com>
 <8422687a-f410-64a4-1211-b06a4f26681e@redhat.com>
In-Reply-To: <8422687a-f410-64a4-1211-b06a4f26681e@redhat.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Tue, 16 Jul 2019 14:01:16 +0300
Message-ID: <CAGi-RUJHBfNedjaFvotpBAH-PcMox-j8aDpYzP6a5VhxseykgQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] net: cadence_gem: clear RX control
 descriptor
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 10:19 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 7/16/19 9:11 AM, Ramon Fried wrote:
> > ping
> >
> > On Sat, Jun 15, 2019 at 8:17 AM Ramon Fried <rfried.dev@gmail.com> wrot=
e:
> >>
> >> The RX ring descriptors control field is used for setting
> >> SOF and EOF (start of frame and end of frame).
> >> The SOF and EOF weren't cleared from the previous descriptors,
> >> causing inconsistencies in ring buffer.
> >> Fix that by clearing the control field of every descriptors we're
> >> processing.
> >>
> >> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> >> ---
> >>  hw/net/cadence_gem.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> >> index ecee22525c..d83a82bdb0 100644
> >> --- a/hw/net/cadence_gem.c
> >> +++ b/hw/net/cadence_gem.c
> >> @@ -406,6 +406,11 @@ static inline void rx_desc_set_sof(uint32_t *desc=
)
> >>      desc[1] |=3D DESC_1_RX_SOF;
> >>  }
> >>
> >> +static inline void rx_desc_clear(uint32_t *desc)
> >> +{
> >> +    desc[1]  =3D 0;
> >> +}
> >> +
> >>  static inline void rx_desc_set_eof(uint32_t *desc)
> >>  {
> >>      desc[1] |=3D DESC_1_RX_EOF;
> >> @@ -994,6 +999,8 @@ static ssize_t gem_receive(NetClientState *nc, con=
st uint8_t *buf, size_t size)
> >>          bytes_to_copy -=3D MIN(bytes_to_copy, rxbufsize);
> >>
> >>          /* Update the descriptor.  */
> >> +        rx_desc_clear(s->rx_desc[q]);
>
> Maybe move the call before the comment, regardless:
Make sense, sent v2.
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> >> +
> >>          if (first_desc) {
> >>              rx_desc_set_sof(s->rx_desc[q]);
> >>              first_desc =3D false;
> >> --
> >> 2.21.0
> >>

