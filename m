Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C484FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8B420767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bcw2QeQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8B420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbne-0001dw-Qo
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbmr-00014U-Iu
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:00:49 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbmo-0003LB-MN
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:00:49 -0400
Received: by mail-oi1-x242.google.com with SMTP id k22so2777528oib.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=95VhPjfLEHBiCVgOh1i8OPiRUJ3tTZfViGVGNdJFeW8=;
 b=Bcw2QeQu6iiVjiXAnbO0F+xRrQx8SswyzCyyOXU/jkh9ZX8f89sC93S7eWs2EbjuHP
 gXkvsglL9m4XQGPJzE8TUYOHKGpMURLhrpPUxWlb7iheFEHNctEj+di4d+F77vFPTtti
 PhJm33fINiqlLUKB/Fybg26sfnq3eOJ6CxYeL3QEW/sJ0kkgIiwT+ewPl/icC4DsP4SK
 yXevbTjg6Nz8a44aMPSyLRT2h2F/1d2v8woOIEqO04bv4kLmIHJdPtidn9fubeDiB6dA
 NzAnLIJzMcy/jy/ZhaIHtNjKPfxOfUb+LrC6HV0OcvPGyjqVTLKhEiNOoJj6+U4q+Ejk
 njrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=95VhPjfLEHBiCVgOh1i8OPiRUJ3tTZfViGVGNdJFeW8=;
 b=Yu5BwjLf1rzwx4Sn2Ycb525b2NjE4n3dU3SZ4QZlQqMvR/rvyG4ZpHyTXESSZS3mv4
 F64Qn6r47YRpHeFfmxiFdrzJ0RDixfYNiTqiKtLvmjd5SUKHyDXHfQeLGGCiwKpRgd2h
 MpKpf81k5biPu28n/a6W+9ki4/rAQtoP1QIPD/Pab0ouEG5nxWWmIAPI+8tY0dDQFIf8
 //x4lADBZB5EsMgMviJxgxKy8a+KmT8iDAkc/4ST2llsMuBzP3Y0CbWmra0NGrLPJgZS
 0Gz35ukyedWSTuNrAdm8Bbwf0sjRKUD9OFwpzCrKmcw5n+u/4MnxoeWKyinhSbcIUWAm
 ywLA==
X-Gm-Message-State: AOAM532t7EBCORY8K2xRIRmdgZh0TgaQVIAAMjbbuKS/QYPtCa0t+pQ2
 xrcw7Ak+qyViPLZ4A3pK5Wve1h8LDHWX4pH4zJ8vfQ==
X-Google-Smtp-Source: ABdhPJyf1mTe1xt4Qlyl4NK1azktp2Qa7S/dBu9omXWqa4AugzQyHjjypOELCQPJzphWki2ptJmvB4kX86u4d7NiYvA=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr1320049oib.163.1594321245523; 
 Thu, 09 Jul 2020 12:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200703201911.26573-1-f4bug@amsat.org>
 <20200703201911.26573-3-f4bug@amsat.org>
In-Reply-To: <20200703201911.26573-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 20:00:34 +0100
Message-ID: <CAFEAcA_fsBtBnzarO4Obd7-5766oSuHzDqRrK48VqgDmH5ip+g@mail.gmail.com>
Subject: Re: [PATCH 02/18] migration/vmstate: Introduce
 vmstate_no_state_to_migrate
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 21:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Introduce a special state to indicate when an object doesn't
> have anything in its state to migrate.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/migration/vmstate.h | 1 +
>  migration/vmstate.c         | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index af7d80cd4e..0922bc8efa 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -195,6 +195,7 @@ struct VMStateDescription {
>  };
>
>  extern const VMStateDescription vmstate_dummy; /* Exclusively for linux-=
user */
> +extern const VMStateDescription vmstate_no_state_to_migrate;
>
>  extern const VMStateInfo vmstate_info_bool;
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index bafa890384..d640cafad3 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -20,6 +20,13 @@
>  #include "trace.h"
>  #include "qjson.h"
>
> +const VMStateDescription vmstate_no_state_to_migrate =3D {
> +    .name =3D "empty-state",
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

Does this definitely not put any data into the migration stream?
We don't want to change what's on the wire for machines that
use devices that start using this. (If it does by default, it
would be easy to make the migration code special case the
magic symbol to act like "no vmsd specified").

thanks
-- PMM

