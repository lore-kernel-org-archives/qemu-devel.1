Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10733C35656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64FE2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64FE2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j590D-0006O8-3D
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j58za-0005wS-KB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j58zY-0001XH-3m
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:09:22 -0500
Received: from regular1.263xmail.com ([211.150.70.202]:56532)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1j58zX-0001TW-L7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:09:20 -0500
Received: from localhost (unknown [192.168.167.225])
 by regular1.263xmail.com (Postfix) with ESMTP id 2F8612E3;
 Fri, 21 Feb 2020 22:09:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.1.3] (unknown [223.72.97.133])
 by smtp.263.net (postfix) whith ESMTP id
 P16688T139983170070272S1582294151490749_; 
 Fri, 21 Feb 2020 22:09:11 +0800 (CST)
X-UNIQUE-TAG: <270ed0bd55c17e2a197f143398e19bb3>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: gang.chen.5i5j@gmail.com
X-SENDER-IP: 223.72.97.133
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH] target: i386: Check float overflow about register stack
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20200221034547.5215-1-chengang@emindsoft.com.cn>
 <a5533719-7ef1-938b-e52c-20711e65417f@redhat.com>
From: Chen Gang <chengang@emindsoft.com.cn>
Message-ID: <900fd511-72f0-675d-4a7e-d228b2ade9c7@emindsoft.com.cn>
Date: Fri, 21 Feb 2020 22:09:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a5533719-7ef1-938b-e52c-20711e65417f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.150.70.202
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
Cc: qemu-devel@nongnu.org, Chen Gang <gang.chen.5i5j@gmail.com>,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/2/21 =E4=B8=8B=E5=8D=884:58, Paolo Bonzini wrote:
> On 21/02/20 04:45, chengang@emindsoft.com.cn wrote:
>>  static inline void fpush(CPUX86State *env)
>>  {
>> -    env->fpstt =3D (env->fpstt - 1) & 7;
>> -    env->fptags[env->fpstt] =3D 0; /* validate stack entry */
>> +    set_fpstt(env, env->fpstt - 1, false, true);
>=20
> On overflow fpstt is ~0, so this does:
>=20
>     env->foverflow =3D true;
>     env->fpstt =3D 7;
>     env->fptags[7] =3D 0;      /* validate stack entry */
>=20
> Is this correct?  You are going to set ST0 so the register should not b=
e
> marked empty.
>=20

Originally, I wanted to add foverflow to mark the stack overflow only,
and kept another things no touch.

But I think what you said above is correct, for me, if fpush/f[i]ld*_STO
are overflow, the env->fpstt, env->fpregs and env->fptags should be kept
no touch, and foverflow is set true, so there is no negative effect.

Welcome your idea.

>>  void helper_fdecstp(CPUX86State *env)
>>  {
>> -    env->fpstt =3D (env->fpstt - 1) & 7;
>> +    set_fpstt(env, env->fpstt - 1, false, false);
>=20
> This is clearing env->foverflow.  But after 8 consecutive fdecstp or
> fincstp the result of FXAM should not change.
>=20
>>      env->fpus &=3D ~0x4700;
>>  }
>> =20
>>  void helper_fincstp(CPUX86State *env)
>>  {
>> -    env->fpstt =3D (env->fpstt + 1) & 7;
>> +    set_fpstt(env, env->fpstt + 1, true, false);
>=20
> Same here.
>=20

OK. thanks.

Now if foverflow is only for fpush/f[i]ld*_ST0, I guess fincstp/fdecstp
can clear foverflow. The env->fptags are only for fpop, which keep no
touch in fincstp/fdecstp.

> The actual bug is hinted in helper_fxam_ST0:
>=20
>     /* XXX: test fptags too */
>=20
> I think the correct fix should be something like
>=20
> diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
> index 99f28f267f..792a128a6d 100644
> --- a/target/i386/fpu_helper.c
> +++ b/target/i386/fpu_helper.c
> @@ -991,7 +991,11 @@ void helper_fxam_ST0(CPUX86State *env)
>          env->fpus |=3D 0x200; /* C1 <-- 1 */
>      }
>=20
> -    /* XXX: test fptags too */
> +    if (env->fptags[env->fpstt]) {
> +        env->fpus |=3D 0x4100; /* Empty */
> +        return;
> +    }
> +

For fpop overflow, this fix is enough, but for me, we still need
foverflow to check fpush/fld*_ST0 overflow.

Don't you think we need check fpush/f[i]ld*_ST0 overflow?

Thanks



