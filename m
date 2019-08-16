Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF0BC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8E12064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaRPXvV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8E12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybvi-0004Pu-Pe
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyboP-0006Z7-Jt
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyboO-0000bB-9q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:33 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:34862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyboO-0000ai-4d
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:32 -0400
Received: by mail-oi1-x229.google.com with SMTP id a127so4737765oii.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TeVFV6TgYwkKFjfA4Rt8sX1ByoNXPopwli97dB8Dk4s=;
 b=UaRPXvV3r9mCpt81lJL0af/GkTGwHkXlerdJVLIlv/lP5exmnS1v8XhOsOLBQBO59T
 eyFqSOpFzjtqnLk3FcCFHSX6PgNrZ5bYOpSfytzmjDB257v2XfHVuOLgcUlOS8PkQyDc
 3a/7yiYxfmsl0iHAhc9DSrPteR5dJuuqL2tqZh2e5fduGEiBMgILkrh9BFlVRBloCbQi
 dCpw8PpzkIUxbu5L9gPRanPC3jzau2Zw9y1rB3tC0FFx8OOu8BEznandyx+ZZebzRi3C
 biR1erKr6QO8+XHhE0dK1ubXTBKi7tEfAuEWF8ilYpamgP7Xf1PG72A4rkEdc6HuGpna
 B2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TeVFV6TgYwkKFjfA4Rt8sX1ByoNXPopwli97dB8Dk4s=;
 b=lQJq7RB7X0k76NtjX6ubdfPFk+6wcqRpn3eWvaAJmdJgSdZR6tE4Dc8Ad6fX8Mtxng
 K1ppGoSkaK2wVIhw+Ofls5O5IC/5acEnQ945NBpAmp/2sr6OtqqnToc8UH702zKUKpY9
 ja5xZgc83PmOWXo08yMJ7iEEdERtxXNZZEL/Fi/q0oJRT/tZ7fy6xm5JOwd5xnI5KmRz
 jGjA8GonPaYjvWk2yhgFji7DRtvrNOMHcKXRifSDGvgYk1z3ZkE0QTUWWFxBcrDY0Z7X
 LDt8EQz5TlFumd9m+srKRsAX4XXA8UIjZB0srLGWaivjIkF3fbfRHwX+nuBUY1ElfgJz
 pAzA==
X-Gm-Message-State: APjAAAWPJ7WtbR+xRr+g9HvFI5IEIZ0OxW/GAJLP8Xk6bl8yNAm5ENhI
 golsDnWRpzEeI8dClq90aP8RFXQTvG3rjszgVvbFeg==
X-Google-Smtp-Source: APXvYqz2+gPjxKKuoVy6UxOuSyRzqBsZmFqMhr4pnwFCFNYXG6k07x9orHfjL0FQTtHwRlilI4+FwBLVsf9VRtCkP0Y=
X-Received: by 2002:a54:4718:: with SMTP id k24mr4550727oik.146.1565960311194; 
 Fri, 16 Aug 2019 05:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190815163504.18937-1-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 13:58:19 +0100
Message-ID: <CAFEAcA8X7AmaqJfsEvFeBkASm5pkE6UUFnbXkzv8Ni=iJWU3qQ@mail.gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
Subject: Re: [Qemu-devel] [PULL 00/33] migration queue
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Wei Yang <richardw.yang@linux.intel.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019 at 17:36, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit f28ed74fd116491e31329044d140fde4aa23b2=
a0:
>
>   Update version for v4.1.0-rc5 release (2019-08-13 15:38:38 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190814a
>
> for you to fetch changes up to 7dd59d01ddcc4a4ba0c44c2cc9e3b35c79aa7a29:
>
>   migration: add some multifd traces (2019-08-14 17:33:14 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2019-08-15
>
> Marcel's vmxnet3 live migration fix (that breaks vmxnet3 compatibility
> but makes it work)
>
> Error description improvements from Yury.
>
> Multifd fixes from Ivan and Juan.
>
> A load of small cleanups from Wei.
>
> A small cleanup from Marc-Andr=C3=A9 for a future patch.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

