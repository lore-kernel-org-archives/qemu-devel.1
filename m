Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B91EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B561A2084D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfTf6PE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B561A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFj6-0004wr-TQ
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 08:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jNFi8-0004Ky-VU
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jNFi8-0006nk-0d
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:58:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jNFi7-0006n6-Md
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:58:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id c195so6612761wme.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KnWYUnK1L6dN97dQDYCPTN4VXjNloq0YgTvFM7zaXGs=;
 b=kfTf6PE3c+LfQqT5UQcWqWUFk4y8aoXI+lB4sCPxTZEqqLgAsSKNbgFc1tK8w6otdE
 1mjcNbuoRn3ipBOfl9h4R4vbWPjjZo8jOwh/Jpvzyyp2fUc0824f7vh48xrVdxbiaVRy
 vL3OfsTqeI6CXclcw75QdMAcWKk0pAiMI3lOgMMr9mOHeJ4US7/QpIrt+C1+ICp0WJ75
 hr+zS59N83TsXAmG/o/hMqn8lCuMhUiGz3C+HKwO79XyyE0C1UEMeNH4zWKDy0pFdJJo
 lBZG1rqJWnHXaVaSFv+PSFfu1NKMaSXp3Ln/0Rnl3KY/SvVoeNTSxVR9AIdhMhwKecnN
 DZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KnWYUnK1L6dN97dQDYCPTN4VXjNloq0YgTvFM7zaXGs=;
 b=J2pUfKTJAQXiGX80+bMJaChb+4Evs84eV9hjxgspk3YPYVvf2p4jg7n8lHybQIyZ88
 putYG4+dIzV9lWwN800xu1vXurshcz/TuvdwrMtnc57t2xcLdvgiJzWRlAFUM1C1S2Wp
 ZKDZ2G98BIO5gq1EDgl72tCSixpksBTnp4up1a0DmzjHNMIQ92GokPwpVsxz12fhbPkF
 lSVfHo8fZOXZNLgR13hCLY+dUnGtj4+Tl7AeC4R3L2ZhpIIVu+umOwyqSHKl1AV6TQrC
 9nTEQbJuETpVZFwFW9LEFQAcHse7mcOSbA8dy6qnAE1Kwtr20EntuCayNZBWBNnb4LrI
 MJIg==
X-Gm-Message-State: AGi0PuY3Ozjc0chAX4Ijxw8dEsYd/F0LhnIhwW+uhqA49gMZs/+UGxHT
 4e73BFfgpL8ng0NHStwkeSaeV+sxWnA=
X-Google-Smtp-Source: APiQypJG0ddeWqHWcQSQ7HSiaWfcJww3SqbM9YAfjvfsdkZ5upxsF7CqIu8IItDPhYKGTcW3e7yhYQ==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr9678041wmb.75.1586609889912; 
 Sat, 11 Apr 2020 05:58:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i129sm7017848wmi.20.2020.04.11.05.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 05:58:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 73F591FF7E;
 Sat, 11 Apr 2020 13:58:07 +0100 (BST)
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-10-alex.bennee@linaro.org>
 <20200410130805.cniysjvluyz52apy@steredhat>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v1 09/11] gdbstub: i386: Fix gdb_get_reg16() parameter
 to unbreak gdb
In-reply-to: <20200410130805.cniysjvluyz52apy@steredhat>
Date: Sat, 11 Apr 2020 13:58:07 +0100
Message-ID: <87tv1q89i8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefano Garzarella <sgarzare@redhat.com> writes:

> On Thu, Apr 09, 2020 at 10:15:27PM +0100, Alex Benn=C3=A9e wrote:
>> From: Peter Xu <peterx@redhat.com>
>>=20
>> We should only pass in gdb_get_reg16() with the GByteArray* object
>> itself, no need to shift.  Without this patch, gdb remote attach will
>> crash QEMU.
>>=20
>> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20200409164954.36902-3-peterx@redhat.com>
>> ---
>>  target/i386/gdbstub.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
>> index f3d23b614ee..b98a99500ae 100644
>> --- a/target/i386/gdbstub.c
>> +++ b/target/i386/gdbstub.c
>> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>>      } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>>          floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
>>          int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
>> -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
>> +        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
>>          return len;
>>      } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>>          n -=3D IDX_XMM_REGS;
>> --=20
>> 2.20.1
>>=20
>>
>
> I had the following issue while attaching to qemu started with gdbserver
> listening:
>
> (gdb) target remote :1234
> Remote debugging using :1234
> Remote communication error.  Target disconnected.: Connection reset by pe=
er.
>
> $ qemu-system-x86_64 -m 1G -smp 4 ... -s
> ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion failed: (len =
=3D=3D gdbserver_state.mem_buf->len)
> Bail out! ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion
> failed: (len =3D=3D gdbserver_state.mem_buf->len)

I'll see if the new gdb testcases can be generalised - they would have
caught these snafus.

>
>
> Thanks to Philippe, I tried this patch and it solves my issue:
>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
>
> Thanks,
> Stefano


--=20
Alex Benn=C3=A9e

