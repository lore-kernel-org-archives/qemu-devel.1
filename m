Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB05C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BFD2187F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 09:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz/w3v3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BFD2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqZmq-0001Th-0q
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 04:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iqZm8-0000rB-Hd
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iqZm7-0004oN-HP
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 04:43:16 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iqZm7-0004bu-5T; Sun, 12 Jan 2020 04:43:15 -0500
Received: by mail-lj1-x241.google.com with SMTP id z22so6753275ljg.1;
 Sun, 12 Jan 2020 01:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uQmpwxVEj1cR4VjtZn7xRR3NzxiwsRUjQ/Q0ih7Ijuw=;
 b=lz/w3v3FvAImk7GIfeLMkjq7yFJEO27+zK0Trfs/b6YTLzlbx4zyrGmcYD5lup1nyi
 hdf54ZKtgUWMHwcA0ZCauN1r7BGXb6sRsJpw3sc2lLdV84h+oDivN4YzY2GdJWcD5NF9
 LCPlvrzEl/MnPz6qdIEt4MUWdwQLVWLs2e0+L+imOZHL1QBd9Q1RiURQ1Z7G3bVESAKX
 xvWR8jjK6XeaCb6+QObz4P49sgddj7H8lfmdPdysgvTLtuc0nfea0P9EaAptRhhP86KQ
 EwArp9tWLTwNvdSjCwwcbGNfG/uVQmNGZCefwAQFRAtttELBxu22e/W1/EXG2/jNkH9J
 kmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uQmpwxVEj1cR4VjtZn7xRR3NzxiwsRUjQ/Q0ih7Ijuw=;
 b=kFk2iaOApoDgJCY1yJT2+4vq90RUWwIPv7jiY70UKtgnrHI4oQq+HrZMa6oGcuFZvd
 vUD4RIG8+fIjuV6jgUNC9SyL0IHy1bYdXikb1MwEISwvSA3ZtL2lY1GnTuiF97QvJRaH
 /s7p5TH6QOGFy0KmVzie/faokEb+J3PHB30t7Gy7q8BbQoPnpFWig862sdExtH/AX3v4
 MC3Wr3zOZu+iBJmooRh3/zwwN5Q/NJzReHAGIwpL+vimmBD2jkPKjMPdQFVNg1Fu9HmU
 gd2YQdp5oX6pFdM91vlFZAvBXJ9HdYWX2grgrz2UBLxgG2KMrkg9who0OMzJYlDuI0Kd
 D/1Q==
X-Gm-Message-State: APjAAAW96GAcbFfNbDgwl9CHSMziSNmNwl6/CApM8O+jqwaWP3x+26vv
 xgx9cW8xqy2NJXebd/Sp0EzzjXBCyO/1HFOjDZE=
X-Google-Smtp-Source: APXvYqx2g1B8y9igJ79V+P1O1imbGLRFl3oMl1i8j7mLFRCVYeIYDi7trAw9KXRVQNnUEJuDknDqFeYmZsHJGGOEhaU=
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr7679182lji.87.1578822193085;
 Sun, 12 Jan 2020 01:43:13 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-6-philmd@redhat.com>
In-Reply-To: <20200109152133.23649-6-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 12 Jan 2020 17:42:45 +0800
Message-ID: <CAKmqyKMOznT5OspQYB41+xYNWK6BnxYeYT7qUWk=KJLv7i6XmQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] device-hotplug: Replace current_machine by
 qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 11:27 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> As we want to remove the global current_machine,
> replace MACHINE_GET_CLASS(current_machine) by
> MACHINE_GET_CLASS(qdev_get_machine()).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  device-hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/device-hotplug.c b/device-hotplug.c
> index f01d53774b..44d687f254 100644
> --- a/device-hotplug.c
> +++ b/device-hotplug.c
> @@ -45,7 +45,7 @@ static DriveInfo *add_init_drive(const char *optstr)
>      if (!opts)
>          return NULL;
>
> -    mc =3D MACHINE_GET_CLASS(current_machine);
> +    mc =3D MACHINE_GET_CLASS(qdev_get_machine());
>      dinfo =3D drive_new(opts, mc->block_default_type, &err);
>      if (err) {
>          error_report_err(err);
> --
> 2.21.1
>
>

