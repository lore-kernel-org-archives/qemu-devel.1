Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD60C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D991920870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXltvVWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D991920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQpn-00040X-4Z
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:44:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQog-0003RG-Eh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hDQoe-0007QN-GX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hDQoc-0007OH-Jj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:43:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id 4so13534699wmf.1
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=Lt8k8WxRvSHoHjbTl3/IIDl61m8cZBJdFBnAke5/crE=;
	b=FXltvVWhdhpLYo69FVDdMomNmflLHa7ZeNevyite/1KEzsZQadnQQoyWhSZqgLhSf1
	oLK/+Bd6biUdam/ijYvB7a9br0yYRkhmKiFxeuVy9K+JQuzCXiKL2RkrsdHkeVg+CgRF
	+skZ8AkqTzC5xNm5nkD487snxqwzoKbgng9fCvvXCkRlJUN+465cLMOsVzv6Qkqucn/j
	Ykhwh+1YpdXQ+4vfJGnbJj1MDCBa8ZHUNGf2P0B0LumwObPvXoZbPzcvdun5SK0P65+t
	AWQuLcTGwkeOMpvbpsyeTC/6KB9TV9WLXnisNyNpdKboHGT8k+/ufLk/9On+LASzoJjR
	CdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=Lt8k8WxRvSHoHjbTl3/IIDl61m8cZBJdFBnAke5/crE=;
	b=ElgOYighIPyEQDH5uCcko5tXLJdUbe+7RDTyJQUt5SGHf5Foq2U2hvIRmE+N8+xQUa
	IEsCytChEWNextVRNlZbDcb2/Qn9vBejL7LAAnqB7zMyFTgxrCWDA/BEvf9QSW0GDaVE
	RYEWlcYGSYX2iHjpkblKyWcu4vT9LCCb2TJ92QGcdRyi8GYTO0WY1vEtsV4IO3K6YmCy
	OWzgLLbjOM4anpQSQG2ZSgge2JaAfGbGhn+g7vOVHc5FNr53RKlSf6w4zU3edKd4eFfL
	zBiNGiw4PA67B6SVEKAeIbOJf19t5SuaGohzk8cFuaebwajGMYg5VDacd+gGR/D2+nWy
	hPaA==
X-Gm-Message-State: APjAAAVKaOIrPzssvO0eNVrsml0oQ8Q8863JTbp3PSI42ZBAd+HM20sF
	IZye6MfB4K2dgug0BIBtd9Sipgdk
X-Google-Smtp-Source: APXvYqwKWV+9YzLxxlvvPII5W0hTVxbKntDIHeLKaJhMoZ2JjL3tUZ3pOcxb7WHpZvUfLGazdvo0GQ==
X-Received: by 2002:a7b:c147:: with SMTP id z7mr16549295wmi.67.1554716623035; 
	Mon, 08 Apr 2019 02:43:43 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	q4sm41767891wrx.25.2019.04.08.02.43.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 02:43:42 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-11-armbru@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <eebcf43e-a4d3-d8b1-1611-23b665ebbe6e@gmail.com>
Date: Mon, 8 Apr 2019 11:44:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-11-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 10/15] vl: Make -machine $TYPE,
 help and -accel help print to stdout
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408084444.knA8e9yjdMdOOsOBpZMcQBugwwQ5Ekpsmarf75QRZkg@z>

Hi Markus,

On 4/8/19 11:36 AM, Markus Armbruster wrote:
> Command line help help explicitly requested by the user should be
> printed to stdout, not stderr.  We do elsewhere.  Adjust -machine
> $TYPE,help and -accel help to match: use printf() instead of
> error_printf().
>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   vl.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index c696ad2a13..792ef36001 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1556,12 +1556,12 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
>               continue;
>           }
>   
> -        error_printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
> -                     prop->name, prop->type);
> +        printf("%s.%s=%s", MACHINE_GET_CLASS(machine)->name,
> +                    prop->name, prop->type);

Does the line above have an alignment issue?

Anyway,

Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks,
Marcel

>           if (prop->description) {
> -            error_printf(" (%s)\n", prop->description);
> +            printf(" (%s)\n", prop->description);
>           } else {
> -            error_printf("\n");
> +            printf("\n");
>           }
>       }
>   
> @@ -3643,7 +3643,7 @@ int main(int argc, char **argv, char **envp)
>                                                        optarg, true);
>                   optarg = qemu_opt_get(accel_opts, "accel");
>                   if (!optarg || is_help_option(optarg)) {
> -                    error_printf("Possible accelerators: kvm, xen, hax, tcg\n");
> +                    printf("Possible accelerators: kvm, xen, hax, tcg\n");
>                       exit(0);
>                   }
>                   opts = qemu_opts_create(qemu_find_opts("machine"), NULL,


