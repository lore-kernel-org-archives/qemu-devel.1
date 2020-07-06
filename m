Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D0C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CEA2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThO12PL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CEA2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUta-0001sU-Oj
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUUX-0000Mn-AE; Mon, 06 Jul 2020 13:01:17 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUUV-0006Rt-JJ; Mon, 06 Jul 2020 13:01:16 -0400
Received: by mail-il1-x144.google.com with SMTP id t27so28559432ill.9;
 Mon, 06 Jul 2020 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7ctzFV2wTSbf5LJWwfLFnbYaCCE17qTbQd0y6awEpBc=;
 b=ThO12PL7aDHTt6y75GpT9dyrfdUt5rmmp4Txh+Dd0WmdKFnGjk/r9Dm6MWbmdmKR2f
 gOl0EW560gWgAJC7KKPMPgy4RIOmmwIgVNkZadxV2u9D/dIfPdqotN2IpqAS9ycNQYHr
 hJ9dyDKYM4nPXV77ZHg3NPuffoCiRMGhmOByeH/avHgJv72C6g/CaXRvi9GUJfH3XClO
 jPo8NpRGszmVDXb43aPBUiVyM1/rwXiSMxzSVdmimKA5ZzWoLBOmJH+tqoSpPtKZ+8bh
 T2k+MkLuNEDO3YFDdNOzo/NtrgfOqqzzZgI1tkCp+0f10xp8ZpF+n8HFKOdAoTs7T00N
 VhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7ctzFV2wTSbf5LJWwfLFnbYaCCE17qTbQd0y6awEpBc=;
 b=GC+iYabkjjhtiURT1WKlPhDK84DXtPDSJ1SUb7X07NSN7ICnfFrgwd7Ee5J1kh/o+S
 h5eLIiH9yP97QNxOUq2qVoigIS8qVzdI89XroBMxx1cnaTKubP2rJ/BDPnP8XblThRFl
 zOVZqdxCHr3qwTYuNRhlBaJRa6QPS2ZdP7gBPMZ4GGlDPiMP2eBvZgDYiPJsO+WTZbr5
 fAOOEknIcJvhMQiRavAaJ76IHQvTyyQ5AlKHHF7eMx4PZRh15n3bR4ePvcjNK0jxBIN9
 zo7/eiNhzkLEZjCEY4N1a7Ll4fhYWZQQd/stn3WuUmFf9DNNQaR9ICGH7s8YtGImfWXk
 SdBg==
X-Gm-Message-State: AOAM531hR+m89Y3CLgPJyG+uzjaoM9LCpz+MU9w4gLIKJACw7JZv9Vf+
 s4GvX/vI1/G7BhwPE8XSjIo2ORHbmxVHF6QfZT0=
X-Google-Smtp-Source: ABdhPJwXFWIOkq2ujd/ddpYJrT5qb6ZnY2NEtThTElkRWlGkJW2XtpKOBtiOhFAWAiQeMsquUUzqsZikNh2Q3JoY55o=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr31745866ilj.131.1594054872136; 
 Mon, 06 Jul 2020 10:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-4-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:51:17 -0700
Message-ID: <CAKmqyKOXnBzRC6-FQ664k-g8gQkByLEGq1MxBJ97eddL+OcH1A@mail.gmail.com>
Subject: Re: [PATCH 03/26] hw/usb: Remove unused VM_USB_HUB_SIZE definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Paul Zimmerman <pauldzim@gmail.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Commit a5d2f7273c ("qdev/usb: make qemu aware of usb busses")
> removed the last use of VM_USB_HUB_SIZE, 11 years ago. Time
> to drop it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/usb.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index e29a37635b..4f04a1a879 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -470,10 +470,6 @@ void usb_generic_async_ctrl_complete(USBDevice *s, U=
SBPacket *p);
>  void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
>  bool usb_host_dev_is_scsi_storage(USBDevice *usbdev);
>
> -/* usb ports of the VM */
> -
> -#define VM_USB_HUB_SIZE 8
> -
>  /* usb-bus.c */
>
>  #define TYPE_USB_BUS "usb-bus"
> --
> 2.21.3
>
>

