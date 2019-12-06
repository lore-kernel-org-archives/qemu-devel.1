Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4140C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741DF2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQOBdCgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741DF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIFV-0004rj-9e
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idHga-0006NZ-MM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:46:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idHgY-0004tb-9V
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:46:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idHgW-0004r1-3q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575654389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RW5iekn261u88V+htHTfTeLvSH0GQFRgCSnUYDL4dU=;
 b=FQOBdCgZJnEBgAxg+kUdeCxg5b3nhM8kGRmC3X8RiCKRegrGScjH+h0Pm8LcFZ8HKsDcVq
 TUFizle581/8P5oUm5oIBAklxNB40ffFt7PRKs16ODCbpITTJtsK/K21kGw1x05eYrj2Yy
 9R6RiwZTwvDGQ/ow1shsNq1bvFwY4rs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-BHUzw7FkM3WB2Mv686rJDg-1; Fri, 06 Dec 2019 12:46:28 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so2694434wrm.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 09:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CKCdT+tlDyeURWzChG1t7XRuJA7azoiw3IC/vqT8Rls=;
 b=gOSrY/mvuTbegzEXXoWGvQNo5tzjM1YMFFk4jjq1/36ad7yAFFnKwNJVoSB7xoR6AW
 tCLm9jRXkvY8KErRVfFWK/yNQE5xaq/yh7k+WrNA8Botd2wyq1wK4UU+lCpC7q6d/kRc
 hOCQIPR28s7cjEdxj1UbjR9e3blJeRbOpyqujd34jFdWoUELylpWE0NuvkxrsMS1Y7qB
 TgO6hPsPvCzzUgmd84tNwS9tpmYSoz++QuutUPGIVl+ILgtZrLUGYLJWBVkqhvNxWrct
 4nyNV+lpmW7+RFAVsLxluCzaMv8PWz9pt+P19kXW9EI1D8ELvz2K/+l6upvLU07wYTc9
 JiBA==
X-Gm-Message-State: APjAAAWmfYVaJKqM25HVUMXY8WDodVvUR4FVdZu0yL09jDYQpQKX8T1M
 Tz2ahj1ps/wyJE9JGO1A+PItjV1086PaKYoZCzozjiGIYV41SINfdLQXWGtLgppjLaVOxDwk0i7
 Lz5E8Xjx73KqnEic=
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr11401988wmb.172.1575654387121; 
 Fri, 06 Dec 2019 09:46:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIlZpZbQnHFRO3MOFohq+yPqJZ4mwVHWr7bxNDZzs0FThCQuyhoh6STGBPzKKjf75joHLGyQ==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr11401970wmb.172.1575654386888; 
 Fri, 06 Dec 2019 09:46:26 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c17sm16591487wrr.87.2019.12.06.09.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 09:46:26 -0800 (PST)
Subject: Re: [PATCH v8 15/37] target/mips: Style improvements in mips_malta.c
To: qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1566216496-17375-16-git-send-email-aleksandar.markovic@rt-rk.com>
 <DM5PR22MB1658090DD9EF830F43F7957DD2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64460769-1e63-ab16-c58f-79f5f848f3ff@redhat.com>
Date: Fri, 6 Dec 2019 18:46:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <DM5PR22MB1658090DD9EF830F43F7957DD2A80@DM5PR22MB1658.namprd22.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: BHUzw7FkM3WB2Mv686rJDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 8/19/19 4:47 PM, Aleksandar Rikalo wrote:
> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
>  > Sent: Monday, August 19, 2019 2:07 PM
>  > To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
>  > Cc: philmd@redhat.com <philmd@redhat.com>; Aleksandar Markovic=20
> <amarkovic@wavecomp.com>; Aleksandar Rikalo <arikalo@wavecomp.com>
>  > Subject: [EXTERNAL][PATCH v8 15/37] target/mips: Style improvements=20
> in mips_malta.c
>  >
>  > From: Aleksandar Markovic <amarkovic@wavecomp.com>
>  >
>  > Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.
>  >
>  > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>  > ---
>  >=A0 hw/mips/mips_malta.c | 216=20
> ++++++++++++++++++++++++++++++---------------------
>  >=A0 1 file changed, 128 insertions(+), 88 deletions(-)
>  >
>  > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
[...]>  > @@ -347,7 +362,8 @@ static uint64_t malta_fpga_read(void *opaque,
> hwaddr addr,
>  >
>  >=A0=A0=A0=A0=A0 /* SWITCH Register */
>  >=A0=A0=A0=A0=A0 case 0x00200:
>  > -=A0=A0=A0=A0=A0=A0=A0 val =3D 0x00000000;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 /* All switches closed */
>  > +=A0=A0=A0=A0=A0=A0=A0 /* ori a3, a3, low(ram_low_size) */

I'm not sure what happened here, this change is incorrect.

>  > +=A0=A0=A0=A0=A0=A0=A0 val =3D 0x00000000;
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>  >
>  >=A0=A0=A0=A0=A0 /* STATUS Register */
>  > @@ -386,10 +402,11 @@ static uint64_t malta_fpga_read(void *opaque,=20
> hwaddr addr,
>  >=A0=A0=A0=A0=A0 /* GPINP Register */
>  >=A0=A0=A0=A0=A0 case 0x00a08:
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* IN =3D OUT until a real I2C control is i=
mplemented */
>  > -=A0=A0=A0=A0=A0=A0=A0 if (s->i2csel)
>  > +=A0=A0=A0=A0=A0=A0=A0 if (s->i2csel) {
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D s->i2cout;
>  > -=A0=A0=A0=A0=A0=A0=A0 else
>  > +=A0=A0=A0=A0=A0=A0=A0 } else {
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D 0x00;
>  > +=A0=A0=A0=A0=A0=A0=A0 }
>  >=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>  >
[...]
>=20
> Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
>=20


