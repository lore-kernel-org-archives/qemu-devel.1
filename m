Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A75C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3974220659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 21:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+zGlacR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3974220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1d2E-0003bN-CL
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 16:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1j1d1N-00033q-NH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1j1d1K-0006zC-CA
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:24:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22287
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1j1d1I-0006r2-SM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 16:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581456274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZBjqKvLLhP4OyGzMMs1YVBSoEFgzfa+qsxSQC7JrXU=;
 b=h+zGlacRl6y811bFjBursEIPbCfPpHDdPkXUgpR8XUTgQEMcze2XtFvjfHtnVaXBA2Dicz
 BzFvrjyITzvSA0nCLAKm+QsNYDJLAuO1llBh1kBv/yx63qn0pDnfD6/Ph8WtoqskGkrto+
 01GfyljzjOSUTpQthfWIsUR0okIJNxg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-WGXJdKWmMe-oLoqao0YeIA-1; Tue, 11 Feb 2020 16:24:31 -0500
Received: by mail-oi1-f197.google.com with SMTP id 199so6735797oie.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 13:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pYormc3L+rB21II0cGaRASPJlNlnoQu2kPXIsXhg+Rg=;
 b=KaZNxIqXmuQHucmGkSBWUAu55zopewv/lZ5XE6KGuSYXbOq3Gcv4sgFT3cp2Y9N1So
 LygHnoWibY5vBpWUI8joOY2PkhjH3EIcczY+ThFdTaT2Oexq8Y9E+WzvdI4papYXIJ4h
 uCHdzzHdJV0xXr0500v0Hdsgna4pwI5A+lpDAvMq47G/iDgrK5wY9gI/JCX2Im+mXUT9
 gRwxa3J1YxmBbdmMVi7nMYVgy2VK9U+QBx1geLweJ7uwNc763YMpTRq9N3wr9LLwUlW/
 rRKmyBYv40L2PfTbyBaNz9HhrUISK9UaGj5hGOR/lOL0BMzjJLdHvrJk0Sa/G99cMwcS
 5kOg==
X-Gm-Message-State: APjAAAXJuztOyOMLSLhFLh/Yon213q0OBNSwbIyrFJ9AyETP5Q7g264S
 7o9Y8E4ewZJ6DTBNDon52b4VBj4r1Uv0VpgE4srzF5DeADNMjQ4ECM2fj6YkyTFMRduFeSSNs6J
 b4exno9W6A8gwaLmBW1PqiVsKpOj+/LM=
X-Received: by 2002:a54:4418:: with SMTP id k24mr4276134oiw.46.1581456270676; 
 Tue, 11 Feb 2020 13:24:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMUPqyYF1D+AboaHJgndbzbZI+rJqvaHuHi3bqpsTRdKxSKHTpmBZwXv3NVXRgHk3jpOMRuzg6A9suuqWjhLQ=
X-Received: by 2002:a54:4418:: with SMTP id k24mr4276122oiw.46.1581456270410; 
 Tue, 11 Feb 2020 13:24:30 -0800 (PST)
MIME-Version: 1.0
References: <15a5fbc76266fb51b365e66872c105b9e2832999.camel@intel.com>
In-Reply-To: <15a5fbc76266fb51b365e66872c105b9e2832999.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 11 Feb 2020 22:24:19 +0100
Message-ID: <CAMxuvazRMzO=7N3FjH74QBk1ehxwaM8rymFcn5_aDppU8_z+LA@mail.gmail.com>
Subject: Re: docs: Update vhost-user spec regarding backend program conventions
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
X-MC-Unique: WGXJdKWmMe-oLoqao0YeIA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Feb 11, 2020 at 4:24 PM Boeuf, Sebastien
<sebastien.boeuf@intel.com> wrote:
>
> From c073d528b8cd7082832fd1825dc33dd65b305aa2 Mon Sep 17 00:00:00 2001
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Date: Tue, 11 Feb 2020 16:01:22 +0100
> Subject: [PATCH] docs: Update vhost-user spec regarding backend program
>  conventions
>
> The vhost-user specification is not clearly stating the expected
> behavior from a backend program whenever the client disconnects.
>
> This patch addresses the issue by defining the default behavior and
> proposing an alternative through a command line option.
>
> By default, a backend program will have to keep listening even if the
> client disconnects, unless told otherwise through the newly introduced
> option --exit-on-disconnect.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5f8b3a456b..da9a1ebc4c 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -1323,6 +1323,10 @@ The backend program must end (as quickly and clean=
ly as possible) when
>  the SIGTERM signal is received. Eventually, it may receive SIGKILL by
>  the management layer after a few seconds.
>
> +By default, the backend program continues running after the client
> +disconnects. It accepts only 1 connection at a time on each UNIX domain
> +socket.

I don't think that's the most common behaviour. libvhost-user will
panic() on disconnect in general, unless the error/exit is handled
gracefully by the backend.

The most common case is to have 1-1 relation between device/qemu
instance and backend.

Why not restart the backend for another instance?

> +
>  The following command line options have an expected behaviour. They
>  are mandatory, unless explicitly said differently:
>
> @@ -1337,6 +1341,12 @@ are mandatory, unless explicitly said differently:
>    vhost-user socket as file descriptor FDNUM. It is incompatible with
>    --socket-path.
>
> +--exit-on-disconnect
> +
> +  When this option is provided, the backend program must terminate when
> +  the client disconnects. This can be used to keep the backend program's
> +  lifetime synchronized with its client process.

This section list options that are mandatory. It's probably a bit late
to add more mandatory options (I regret already some of them)

Do we need to specify the behaviour on client disconnect? Can't we
leave that to the backend and management layer to decide?


> +
>  --print-capabilities
>
>    Output to stdout the backend capabilities in JSON format, and then
> --
> 2.20.1
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.


