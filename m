Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E99C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEA82071C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7xp2v+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEA82071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9HE-00060g-Fo
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE96O-0002AG-7s
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE96M-0007TG-I6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE96M-0007N7-Bz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584439533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRy5gbVbBssfqnTE4/fNCnzS8878j1YS+ngVXy5RyKY=;
 b=e7xp2v+Hi9fX8/hVwVPmFAZeOzEbCQSaKb+o+LF8rrGHkmh44awd8a48Xkmv+I7YiTAi9J
 DfNLt364H7Z5cOUy50qnX5lKApok0uCcqpJwJqhLrcW6N1/0jDAzW7qPJp5dqzjGJff06r
 6fNUQcjWpe36wUQCrbg+oYjcme/iq8k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-m93T5rbBPoqIJ3O_TkRE2Q-1; Tue, 17 Mar 2020 06:05:31 -0400
X-MC-Unique: m93T5rbBPoqIJ3O_TkRE2Q-1
Received: by mail-wr1-f69.google.com with SMTP id t10so4133942wrp.15
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mbViYDInhtzhzOnjgxz8a5DkEbv4zhEsie9K0pgxCUE=;
 b=DXzbFG7diO8uIp1CSmEecRbh7s7a1dhdkwtFHxLoXZyx6ouDpomkpke2YZ2ltxOrOx
 N8Qsuazj5YD0RGz++GaYjUq2QR1Z5PCT85TPQ4wc0TcN3oRtTs1q9oFahZq1oEuYjv7/
 sabfbMqVe2s0eG3Yp+e3CJn3kjnLdT5+cdgVnvgCFwC5ykEID8YrWkAp4ZOHl71Oqfde
 isUPVWstbKveVvwdWaTEsV4k/uYzK9NT5kxZDfZygtlbUMuHswWT4jeb1NCUwkJPfQ4k
 PnrRzZQose7Z+TzE0U7JgLj7leNDIqkgDacge75VMQ2agOSU7MeENXT03yex/91wIZSu
 QIUw==
X-Gm-Message-State: ANhLgQ1Eru550WGDozq5kpQT28PKY3hPka+Y+2GEgVAssFFdkUgyFTa/
 y2mEZ9LAa1O6mukXNxyKM59WpppEuvni0zzkfruZfhZ41UDlqrk5rquy5PTv4/M/AtFXCtGkMTa
 9aKxuAgXG5Jvzphc=
X-Received: by 2002:a7b:c354:: with SMTP id l20mr4408351wmj.40.1584439530596; 
 Tue, 17 Mar 2020 03:05:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt6u34pm614WVrq7zZdFsaPqPDK8EhQkAC1WEOxfgMCctMtYiZDP4RtOx3kvuN3Z2y5Ii9rtg==
X-Received: by 2002:a7b:c354:: with SMTP id l20mr4408243wmj.40.1584439529181; 
 Tue, 17 Mar 2020 03:05:29 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id h15sm3608071wrw.97.2020.03.17.03.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:05:28 -0700 (PDT)
Subject: Re: [PATCH v1 13/28] target/i386: use gdb_get_reg helpers
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-14-alex.bennee@linaro.org>
 <9ecb1d64-c447-5c0d-0280-ce9cd6537fa6@redhat.com>
Message-ID: <59d09313-963f-ffaa-a069-f89e597ac28f@redhat.com>
Date: Tue, 17 Mar 2020 11:05:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9ecb1d64-c447-5c0d-0280-ce9cd6537fa6@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 10:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
>> This is cleaner than poking memory directly and will make later
>> clean-ups easier.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v7
>> =C2=A0=C2=A0 - remove stray space
>> =C2=A0=C2=A0 - fixup the floatx80 set/get routines
>> ---
>> =C2=A0 target/i386/gdbstub.c | 27 +++++++++++----------------
>> =C2=A0 1 file changed, 11 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
>> index 572ead641ca..e4d8cb66c00 100644
>> --- a/target/i386/gdbstub.c
>> +++ b/target/i386/gdbstub.c
>> @@ -98,26 +98,22 @@ int x86_cpu_gdb_read_register(CPUState *cs,=20
>> uint8_t *mem_buf, int n)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return gdb_get_reg64(mem_buf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 env->regs[gpr_map[n]] &=20
>> 0xffffffffUL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 memset(mem_buf, 0, sizeof(target_ulong));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return sizeof(target_ulong);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return gdb_get_regl(mem_buf, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (n >=3D IDX_FP_REGS && n < IDX_=
FP_REGS + 8) {
>> -#ifdef USE_X86LDOUBLE
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FIXME: byteswap float val=
ues - after fixing fpregs layout. */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(mem_buf, &env->fpregs=
[n - IDX_FP_REGS], 10);
>> -#else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(mem_buf, 0, 10);
>> -#endif
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 10;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 floatx80 *fp =3D (floatx80 *=
) &env->fpregs[n - IDX_FP_REGS];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int len =3D gdb_get_reg64(me=
m_buf, cpu_to_le64(fp->low));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len +=3D gdb_get_reg16(mem_b=
uf + len, cpu_to_le16(fp->high));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return len;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (n >=3D IDX_XMM_REGS && n < IDX=
_XMM_REGS + CPU_NB_REGS) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n -=3D IDX_XMM_RE=
GS;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (n < CPU_NB_RE=
GS32 || TARGET_LONG_BITS =3D=3D 64) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stq_=
p(mem_buf, env->xmm_regs[n].ZMM_Q(0));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stq_=
p(mem_buf + 8, env->xmm_regs[n].ZMM_Q(1));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 16;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn gdb_get_reg128(mem_buf,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->xmm_regs[n].ZMM=
_Q(0),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->xmm_regs[n].ZMM=
_Q(1));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (n) {
>> @@ -290,10 +286,9 @@ int x86_cpu_gdb_write_register(CPUState *cs,=20
>> uint8_t *mem_buf, int n)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return 4;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (n >=3D IDX_FP_REGS && n < IDX_=
FP_REGS + 8) {
>> -#ifdef USE_X86LDOUBLE
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FIXME: byteswap float val=
ues - after fixing fpregs layout. */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(&env->fpregs[n - IDX_=
FP_REGS], mem_buf, 10);
>> -#endif
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 floatx80 *fp =3D (floatx80 *=
) &env->fpregs[n - IDX_FP_REGS];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp->low =3D le64_to_cpu(* (u=
int64_t *) mem_buf);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fp->high =3D le16_to_cpu(* (=
uint16_t *) (mem_buf + 8));

Note, checkpatch complains for both lines:
ERROR: space prohibited after that '*' (ctx:BxW)

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 10;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (n >=3D IDX_XMM_REGS && n < IDX=
_XMM_REGS + CPU_NB_REGS) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n -=3D IDX_XMM_RE=
GS;
>>
>=20
> I'd prefer both USE_X86LDOUBLE hunks in a separate patch, anyway:
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


