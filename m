Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4823C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E86E224D7
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 19:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYR+XSuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E86E224D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF1FM-0005iS-LG
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 15:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iF1EF-0005Ej-MV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iF1EE-0002OA-8s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:21:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iF1EE-0002NJ-2G
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 15:21:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id o18so12596006wrv.13
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rU6MVBb5pA0BxfX5ZvVsarsL2G9lAzaVenRY/bLuZxc=;
 b=NYR+XSuj704/zNkkfyPEF+2ZIFIRA3Irjr7zWp3VPa7WMkY6TlZUGnZmX5K0if2fFi
 QTn72J3jCiHfspCwp9z58m8z871Aj5zkFxoEr6EpY3DRXjngUEXMBomQk+5U1+rJvgf5
 jaSMuYCGLUgZgKJiVPDhWBftr57foBXCSjz3BWeLqZJGLTYnpls15Low/pMdDSdZiqBa
 J+YMAGQTBEkhO1ThF6Ajzu2eUlzbF6BTiLsDP4O2VMLB/6zqYw9A2lJnpfEfaNcS5nrR
 1cdALk8bB2BCPKhVTjrMJip8/6t/jES50RyA+MfOoZb2rANMosgkmUn3Bs04Tw0pIvNL
 uT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rU6MVBb5pA0BxfX5ZvVsarsL2G9lAzaVenRY/bLuZxc=;
 b=tusfd9N1v49rnorpfItToXDmw5MzCqJtbOI1Qh1GSdMBKFNwxgZh2c2kG8cYRa3Ul8
 fTMeHDUcSKI5sxUuKLnKbvfs2EElBdDxtGFKa2giewbFuVJn0UE5uwnYz8acsM/Pj6Uc
 qSjeNKLm7duwFs2fM2TcYYHHZus2hL+OgWEiBqkW4gmlZMVMcw2m7vQsph0TbFqI+r0F
 KHSx/WCRztiQJaCdah0dJ96JaeAbtjspKwX+Ykf1oeeL2a1IXNDaKRXjRXpxiTMtbHsU
 7sM++MLg3Ddb9PXl+Vz5YCvqnuccTCnktZTzstrKrVmEzbmzLpYDU1MChzAUUzxKTtzk
 tKPQ==
X-Gm-Message-State: APjAAAWxUoCTGwdjBnXi0/DOrOeLP5yuPn1DBNwj24DI7zqJPQ+5B3PJ
 Gg/OfWbpPAGdUePZCQ7s3F1xfg==
X-Google-Smtp-Source: APXvYqxKt1BTLeRBGu9gOSI4SfePHKFSjQc7o8sssEZExcgx+ruz3WgLOB26xYoeBss5AheW0Ssapw==
X-Received: by 2002:adf:e545:: with SMTP id z5mr15420902wrm.263.1569871260417; 
 Mon, 30 Sep 2019 12:21:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm18349058wrm.3.2019.09.30.12.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 12:20:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A3D251FF87;
 Mon, 30 Sep 2019 20:20:58 +0100 (BST)
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
 <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Lockup with --accel tcg,thread=single
In-reply-to: <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com>
Date: Mon, 30 Sep 2019 20:20:58 +0100
Message-ID: <87ftkdlhet.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/09/19 17:37, Peter Maydell wrote:
>> Not sure currently what the best fix is here.
>
> Since thread=3Dsingle uses just one queued work list, could it be as
> simple as

Does it? I thought this was the case but:

  static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
  {
      qemu_mutex_lock(&cpu->work_mutex);
      if (cpu->queued_work_first =3D=3D NULL) {
          cpu->queued_work_first =3D wi;
      } else {
          cpu->queued_work_last->next =3D wi;
      }
      cpu->queued_work_last =3D wi;
      wi->next =3D NULL;
      wi->done =3D false;
      qemu_mutex_unlock(&cpu->work_mutex);

      qemu_cpu_kick(cpu);
  }

Does seem to imply the vCPU CPUState is where the queue is. That's not
to say there shouldn't be a single work queue for thread=3Dsingle.

>
> diff --git a/cpus.c b/cpus.c
> index d2c61ff..314f9aa 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1539,7 +1539,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
>              cpu =3D first_cpu;
>          }
>
> -        while (cpu && !cpu->queued_work_first && !cpu->exit_request) {
> +        while (cpu && !first_cpu->queued_work_first && !cpu->exit_reques=
t) {
>
>              atomic_mb_set(&tcg_current_rr_cpu, cpu);
>              current_cpu =3D cpu;
>
> or something like that?
>
>> Side note -- this use of run_on_cpu() means that we now drop
>> the iothread lock within memory_region_snapshot_and_clear_dirty(),
>> which we didn't before. This means that a vCPU thread can now
>> get in and execute an access to the device registers of
>> hw/display/vga.c, updating its state in a way I suspect that the
>> device model code is not expecting... So maybe the right answer
>> here should be to come up with a fix for the race that 9458a9a1
>> addresses that doesn't require us to drop the iothread lock in
>> memory_region_snapshot_and_clear_dirty() ? Alternatively we need
>> to audit the callers and flag in the documentation that this
>> function has the unexpected side effect of briefly dropping the
>> iothread lock.
>
> Yes, this is intended.  There shouldn't be side effects other than
> possibly a one-frame flash for all callers.
>
> Paolo


--
Alex Benn=C3=A9e

