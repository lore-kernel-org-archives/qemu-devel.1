Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B50EC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 17:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038FE2084D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgR+f8Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038FE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNJix-0004dh-4a
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 13:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jNJiH-0004DP-LA
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jNJiG-0005X1-3I
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:14:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jNJiF-0005Wn-SV
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 13:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586625274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+8NpMEq2185PgVngI+nq3wvKU1rWNW4o/0VtYhn2xY=;
 b=VgR+f8EtsU4z8L4fX2cZueA7350ZaDs81JYHGuCybxZMWhE1kFnqh4Pdcm6+XzCntRnDy2
 b9yPlyfHEjmAQ2qmtcgv/tQBkI0fR4aXgFDwlqX4Au3SKSX4cCB5mJFcURqJnavPfy4wMU
 oFSP3/oeLrg4+fY/9h1LKX8CjLcaPz8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-guEQgiGUNn--SRYflyxZcA-1; Sat, 11 Apr 2020 13:14:32 -0400
X-MC-Unique: guEQgiGUNn--SRYflyxZcA-1
Received: by mail-ed1-f72.google.com with SMTP id d4so5101073edn.22
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 10:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ns5BUkm7OvQ3cf5pEI8JAgujzRusJcUTKRw46w069ak=;
 b=BtdmghMWM57/2NLgZm+GErHE5f/gaPNrISW+54Zf2Nagx01yCz4dyKe7fA7jrIwFpM
 iXR3S+VBvHJ6nMP6G9Nzu44IwKNZobnisDHFHEmgRRigHEP3xdsDBg6lrwPRe3tv6pHP
 k1QIv36uUm3kpBrieRnJHRNu/Hu+HwVOGHF645+4PfYsn7zYuQC8FuYvufh7AjDsJjKZ
 xSqTGP1I+iBgidS7SrVCtXCBcmyb0urLO4yKYytTQdt1t5tRu5c/xElQYbj9MGkY3r6F
 zoSLu9dWpokEx35C3rzSLfZUguk0tZa8rEK3wNS7xzstLfA+sARO7qa3sft94KGd5QUS
 QLfA==
X-Gm-Message-State: AGi0PuYM+oVYTEIv0gpnMBYzXsljIlwjOJ4WQSkwwsBRlW3rkTXginCO
 Va3ri8Qw4E9tXcfe1LZ3IfbFNtCGcUV7dG5l7E67cbv9g6MIvlH5/Gmo859OSYQuvAODiLkCic2
 IsA/URdSvTUeXhlA=
X-Received: by 2002:a17:906:43c6:: with SMTP id
 j6mr8474343ejn.39.1586625271684; 
 Sat, 11 Apr 2020 10:14:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypKmVdB5zdpqpjvgPxAYgox6ZgcCAXE/XhW8Knmd2WdKXV5QP1/7A+gFHHPA3lH2fk4sF8eZYw==
X-Received: by 2002:a17:906:43c6:: with SMTP id
 j6mr8474328ejn.39.1586625271441; 
 Sat, 11 Apr 2020 10:14:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f12sm575535edw.42.2020.04.11.10.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2020 10:14:30 -0700 (PDT)
Subject: Re: [PATCH v1 09/11] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
To: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-10-alex.bennee@linaro.org>
 <20200410130805.cniysjvluyz52apy@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9d815bf0-47ae-c5cf-86b9-582cec742db6@redhat.com>
Date: Sat, 11 Apr 2020 19:14:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410130805.cniysjvluyz52apy@steredhat>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 3:08 PM, Stefano Garzarella wrote:
> On Thu, Apr 09, 2020 at 10:15:27PM +0100, Alex Benn=C3=A9e wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> We should only pass in gdb_get_reg16() with the GByteArray* object
>> itself, no need to shift.  Without this patch, gdb remote attach will
>> crash QEMU.
>>
>> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20200409164954.36902-3-peterx@redhat.com>
>> ---
>>   target/i386/gdbstub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
>> index f3d23b614ee..b98a99500ae 100644
>> --- a/target/i386/gdbstub.c
>> +++ b/target/i386/gdbstub.c
>> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>>       } else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>>           floatx80 *fp =3D (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
>>           int len =3D gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
>> -        len +=3D gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
>> +        len +=3D gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
>>           return len;
>>       } else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) =
{
>>           n -=3D IDX_XMM_REGS;
>> --=20
>> 2.20.1
>>
>>
>=20
> I had the following issue while attaching to qemu started with gdbserver
> listening:
>=20

Alex, if possible can you amend this info please?

<---

> (gdb) target remote :1234
> Remote debugging using :1234
> Remote communication error.  Target disconnected.: Connection reset by pe=
er.
>=20
> $ qemu-system-x86_64 -m 1G -smp 4 ... -s
> ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion failed: (len =
=3D=3D gdbserver_state.mem_buf->len)
> Bail out! ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion faile=
d: (len =3D=3D gdbserver_state.mem_buf->len)

--->

Thanks!

>=20
>=20
> Thanks to Philippe, I tried this patch and it solves my issue:
>=20
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> Thanks,
> Stefano
>=20
>=20


