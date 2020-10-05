Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1549AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605C120578
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605C120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPM3L-0002EB-FA
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPM2E-0000pk-QN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:39:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPM2D-0000z3-6S
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:39:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id j2so8360306eds.9
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LMvJF0VtkoobbNqhSW7CogIOFpovJdAazJ9D6grhGGc=;
 b=DYcgtStBAwZOB8+YIujn8ubAJl4eGLFO3NxwjPHEZjYMkjO3sUz6gAZMFk073k7Omu
 I5gZ0ygMGCrVypCEeBl5DzCxhphX4sxC0KxddpTMv4GKYoESFZTKMYNxQUFOeOm9dvDa
 aSK/inZ6PG1MX2TNlLHspinO5Co3OWwfYy0AfR1bJUlFqXwxvGw0Z6idih2onagFDDFZ
 T/kX9lcZFoL/XVHbi8Q0bsTLjrm0LCkW1WbcDuxyWZujiWd4XhGskm+c4WmZFA8aMT7W
 0t2t0ed+25G9tboi2FL+Mwe9iqdCXUbC/ltxS+iTcH79TFnIlFQWemZFJCgeLv7fADKf
 BCkw==
X-Gm-Message-State: AOAM5332vtiVuPqv04E3aSNsljS6Xp19YpZIUcpQgV12ZjkRZ8Suwhfm
 DziZQcA2rbNH8zviru/EDzsjjGk9GWunAhig+2o=
X-Google-Smtp-Source: ABdhPJzq4DU6eYvGqxyiyNKz4EN5FgIRnF7nx+grpz8S0zT3BWsknDT00Hql6z4V0kkB1stM8jct8pJKN6qgYsJeI+E=
X-Received: by 2002:aa7:dd8d:: with SMTP id g13mr16189540edv.324.1601887191729; 
 Mon, 05 Oct 2020 01:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-14-f4bug@amsat.org>
 <CAHt6W4fAsxiNx11x53Q6BE_oCs9RwZtL8gg4dPHpfa7sQfp9AQ@mail.gmail.com>
In-Reply-To: <CAHt6W4fAsxiNx11x53Q6BE_oCs9RwZtL8gg4dPHpfa7sQfp9AQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 5 Oct 2020 10:39:40 +0200
Message-ID: <CAAdtpL6dbNh4+YQhj7WnfenBdVNFncQq2K7Z-FKRXn4n96OPXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/21] contrib/gitdm: Add more entries to the Red Hat
 domain
To: Frediano Ziglio <freddy77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 04:39:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Nir Soffer <nsoffer@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 5, 2020 at 10:05 AM Frediano Ziglio <freddy77@gmail.com> wrote:
>
> Hi,
>   can I disagree? If the contribution is personal I use my personal addre=
ss, if the contribution is from the job in the company I'm using the compan=
y address.

Certainly! Can I add your personal address to the "individual
contributor" list instead?

>
> Regards,
>    Frediano
>
>
> Il giorno dom 4 ott 2020 alle ore 19:05 Philippe Mathieu-Daud=C3=A9 <f4bu=
g@amsat.org> ha scritto:
>>
>> Cc: Frediano Ziglio <freddy77@gmail.com>
>> Cc: Frediano Ziglio <fziglio@redhat.com>
>> Cc: Nir Soffer <nirsof@gmail.com>
>> Cc: Nir Soffer <nsoffer@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> To the developers Cc'ed: If you agree with your entry, please
>> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
>> care, please either reply with Nack-by or ignore this patch.
>> I'll repost in 2 weeks as formal patch (not RFC) with only the
>> entries acked by their author.
>> ---
>>  contrib/gitdm/group-map-redhat | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-re=
dhat
>> index d15db2d35e..0419e82795 100644
>> --- a/contrib/gitdm/group-map-redhat
>> +++ b/contrib/gitdm/group-map-redhat
>> @@ -6,3 +6,5 @@ david@gibson.dropbear.id.au
>>  laurent@vivier.eu
>>  pjp@fedoraproject.org
>>  armbru@pond.sub.org
>> +freddy77@gmail.com
>> +nirsof@gmail.com
>> --
>> 2.26.2
>>

