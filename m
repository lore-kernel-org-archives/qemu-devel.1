Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9893CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFB320737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aisQX7xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFB320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB33z-0003wX-Lb
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kB30r-00029T-1g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:31:21 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:46711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kB30o-0004YW-U9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:31:20 -0400
Received: by mail-il1-x143.google.com with SMTP id c6so3087141ilo.13
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fhx25CUFGkKH0Kicebu1oAsw8upQPFN61oXOXscPXlU=;
 b=aisQX7xj26SRMbq61kPLblQJhIUB0oExpIoxF1ETzzi6sChEjS0yvrhgrifQk/4MQj
 SawVqpZ0Y2AFUk1iwzi+zGSMz/Qi17Fq7xieEjPrZirFxkNcMFiGyWS0Cjt2tkN/9Hko
 b2XcgKOwmayr/yt4FwIK2HPq3onZFZwEpfq3eLdXHRPkl71JPuSLLtfNbuT5vBYt946h
 0mPw6KPVTMKI1pUfBGIvWXaFIZcKyYx2Z428VZeBRSGcwkEthZ1PrDaG05kSYAqIUZh9
 EoC1elPVASUk6Ais7eV4o74t8N46mtZ2AJW9Gd8T9sYiUjQMpHE2IDAvbf6zRjocVTX6
 uwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fhx25CUFGkKH0Kicebu1oAsw8upQPFN61oXOXscPXlU=;
 b=iPN2O2N9GcH7BWpPq42o7fr2dKtrkk8eEdmrP/Ogi+t0zqCmeFnF/qLizWcnxFF/vV
 nCIyHNBtGmReb5aXiP+zKPx8q1Ckqbbsl+UpTwdYslFkM+oZVb0qWIS1eiUwe2sEQkTG
 8+Bp1Aah3YFdNonDBi9oP2kBdR0FcJQ3Ssis5kFVix/I9I53Jsmy1g7cQa60Hd9RN1Yt
 lk1z4bmwoqCvSRaxBgeqD1ABu3zc2TqXs1VJHYiQndgMd+EJByEfJ0/ixXL88WL6ix5H
 Er1LykOHm30BFLht7jeO2qiniJlZl5x2ayaMHTeC/UYjRNtOly+07iwKc2eFogrdaXgJ
 NeOw==
X-Gm-Message-State: AOAM532XhkCrkD6loZM/BYPhokQKcPeZ73ozOp7/nzpTjIk+l00/l1xh
 gPsOHsGbRAJZIid3lmgXNvghMMopOwTXcerYN2g=
X-Google-Smtp-Source: ABdhPJwZ/RlrB4QIewt2b94NaEZxaJd06sx8p9E0iJGtQYO5c+AuKn4xAuRr+KPfKvzQYxVkZlRmRN+BigNlyH/eKE8=
X-Received: by 2002:a05:6e02:ef3:: with SMTP id
 j19mr15603230ilk.227.1598477477431; 
 Wed, 26 Aug 2020 14:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
 <CAAdtpL7MKX-UAxPWyh-Xgj1xTLmiQat=UgpJ21xeZtpjB-nzPg@mail.gmail.com>
In-Reply-To: <CAAdtpL7MKX-UAxPWyh-Xgj1xTLmiQat=UgpJ21xeZtpjB-nzPg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Aug 2020 14:20:33 -0700
Message-ID: <CAKmqyKO_vF8QS28S0kdYX_KYMCSU+n=Ps=-brU2uZxxYZG0WaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] core/register: Specify instance_size in the
 TypeInfo
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 2:40 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Le mar. 25 ao=C3=BBt 2020 19:42, Alistair Francis <alistair.francis@wdc.c=
om> a =C3=A9crit :
>>
>> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  hw/core/register.c | 31 +++++++++++++------------------
>>  1 file changed, 13 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/core/register.c b/hw/core/register.c
>> index ddf91eb445..31038bd7cc 100644
>> --- a/hw/core/register.c
>> +++ b/hw/core/register.c
>> @@ -176,17 +176,6 @@ void register_reset(RegisterInfo *reg)
>>      }
>>  }
>>
>> -void register_init(RegisterInfo *reg)
>> -{
>> -    assert(reg);
>> -
>> -    if (!reg->data || !reg->access) {
>> -        return;
>> -    }
>> -
>> -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
>> -}
>> -
>>  void register_write_memory(void *opaque, hwaddr addr,
>>                             uint64_t value, unsigned size)
>>  {
>> @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(Devi=
ceState *owner,
>>          int index =3D rae[i].addr / data_size;
>>          RegisterInfo *r =3D &ri[index];
>>
>> -        *r =3D (RegisterInfo) {
>> -            .data =3D data + data_size * index,
>> -            .data_size =3D data_size,
>> -            .access =3D &rae[i],
>> -            .opaque =3D owner,
>> -        };
>> -        register_init(r);
>> +        if (data + data_size * index =3D=3D 0 || !&rae[i]) {
>> +            continue;
>> +        }
>> +
>> +        /* Init the register, this will zero it. */
>> +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
>
>
> Easier to review &ri[index] than that void* cast IMO.

I find that more complex as then we aren't using the local variable we
created. I'm going to leave it as is, I hope that's ok.

> Otherwise:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks

Alistair

>
>> +
>> +        /* Set the properties of the register */
>> +        r->data =3D data + data_size * index;
>> +        r->data_size =3D data_size;
>> +        r->access =3D &rae[i];
>> +        r->opaque =3D owner;
>>
>>          r_array->r[i] =3D r;
>>      }
>> @@ -329,6 +323,7 @@ static const TypeInfo register_info =3D {
>>      .name  =3D TYPE_REGISTER,
>>      .parent =3D TYPE_DEVICE,
>>      .class_init =3D register_class_init,
>> +    .instance_size =3D sizeof(RegisterInfo),
>>  };
>>
>>  static void register_register_types(void)
>> --
>> 2.28.0
>>
>>

