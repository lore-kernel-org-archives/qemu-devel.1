Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2920620731
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOjNxQfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2920620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlyq-0001ng-8i
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXlyD-0001IM-3P
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXlyB-0007Zg-Ds
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:54:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21305
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXlyB-0007Z6-8m
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574340838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50n83H+/RUfv5NbSgZbUbGe0qzTe9K7ePQxIVU8xfVE=;
 b=VOjNxQfy3glWVjBoxEbvFtTYXHlHRP3DyyQDHjZUdMc/1fwqn3cgd0u5FJaKysczSH1XmW
 cxaYy2gnEMEQoLeU3AdCnjtErfVZobK4Z3p/uBCmwkCSvGJ9hk82m0S0w5MsAsou0ETRpG
 MmtX+Qm7Wl6DcHDMvCr8v7wi9dWioR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-pMU3GqOfMEW4ipfMr1_IRg-1; Thu, 21 Nov 2019 07:53:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853D21005509;
 Thu, 21 Nov 2019 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E055ED46;
 Thu, 21 Nov 2019 12:53:49 +0000 (UTC)
Subject: Re: [PATCH 01/15] s390x: Cleanup cpu resets
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <32e994b4-6ae2-8de2-4ae0-fc61a21f5f7a@redhat.com>
Date: Thu, 21 Nov 2019 13:53:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-2-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pMU3GqOfMEW4ipfMr1_IRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 12.43, Janosch Frank wrote:
> Let's move the resets into one function and switch by type, so we can
> use fallthroughs for shared reset actions.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c |   3 +
>  target/s390x/cpu.c         | 111 ++++++++++++++++---------------------
>  2 files changed, 52 insertions(+), 62 deletions(-)
[...]
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 3abe7e80fd..10d5b915d8 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -82,67 +82,53 @@ static void s390_cpu_load_normal(CPUState *s)
>  }
>  #endif
> =20
> -/* S390CPUClass::cpu_reset() */
> -static void s390_cpu_reset(CPUState *s)
> +enum {
> +    S390_CPU_RESET_NORMAL,
> +    S390_CPU_RESET_INITIAL,
> +    S390_CPU_RESET_CLEAR,
> +};
> +
> +static void s390_cpu_reset(CPUState *s, uint8_t type)

Please give the enum a name and use that instead of uint8_t for "type".
Or at least make it an "int". uint8_t is not really appropriate here.

>  {
>      S390CPU *cpu =3D S390_CPU(s);
>      S390CPUClass *scc =3D S390_CPU_GET_CLASS(cpu);
>      CPUS390XState *env =3D &cpu->env;
> =20
> -    env->pfault_token =3D -1UL;
> -    env->bpbc =3D false;
>      scc->parent_reset(s);
>      cpu->env.sigp_order =3D 0;
>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
> -}
> =20
> -/* S390CPUClass::initial_reset() */
> -static void s390_cpu_initial_reset(CPUState *s)
> -{
> -    S390CPU *cpu =3D S390_CPU(s);
> -    CPUS390XState *env =3D &cpu->env;
> +    /* Set initial values after clearing */
> +    switch (type) {
> +    case S390_CPU_RESET_CLEAR:
> +        /* Fallthrough will clear the rest */

I think you could drop the above comment, since /* Fallthrough */ two
lines later should be enough.

> +        memset(env, 0, offsetof(CPUS390XState, start_initial_reset_field=
s));
> +        /* Fallthrough */
> +    case S390_CPU_RESET_INITIAL:
> +        memset(&env->start_initial_reset_fields, 0,
> +               offsetof(CPUS390XState, end_reset_fields) -
> +               offsetof(CPUS390XState, start_initial_reset_fields));
> +        /* architectured initial values for CR 0 and 14 */
> +        env->cregs[0] =3D CR0_RESET;
> +        env->cregs[14] =3D CR14_RESET;
> =20
> -    s390_cpu_reset(s);
> -    /* initial reset does not clear everything! */
> -    memset(&env->start_initial_reset_fields, 0,
> -        offsetof(CPUS390XState, end_reset_fields) -
> -        offsetof(CPUS390XState, start_initial_reset_fields));
> -
> -    /* architectured initial values for CR 0 and 14 */
> -    env->cregs[0] =3D CR0_RESET;
> -    env->cregs[14] =3D CR14_RESET;
> -
> -    /* architectured initial value for Breaking-Event-Address register *=
/
> -    env->gbea =3D 1;
> -
> -    env->pfault_token =3D -1UL;
> -
> -    /* tininess for underflow is detected before rounding */
> -    set_float_detect_tininess(float_tininess_before_rounding,
> -                              &env->fpu_status);
> +        /* architectured initial value for Breaking-Event-Address regist=
er */
> +        env->gbea =3D 1;
> +        /* tininess for underflow is detected before rounding */
> +        set_float_detect_tininess(float_tininess_before_rounding,
> +                                  &env->fpu_status);
> +        /* Fallthrough */
> +    case S390_CPU_RESET_NORMAL:
> +        env->pfault_token =3D -1UL;
> +        env->bpbc =3D false;
> +        break;
> +    }
> =20
>      /* Reset state inside the kernel that we cannot access yet from QEMU=
. */
> -    if (kvm_enabled()) {
> -        kvm_s390_reset_vcpu(cpu);
> +    if (kvm_enabled() && (type =3D=3D S390_CPU_RESET_CLEAR ||
> +                          type =3D=3D S390_CPU_RESET_INITIAL)) {
> +            kvm_s390_reset_vcpu(cpu);
>      }

Why don't you simply move that into the switch-case statement, too?

[...]

Anyway, re-using code is of course a good idea, but I wonder whether it
would be nicer to keep most things in place, and then simply chain the
functions like this:

static void s390_cpu_reset_normal(CPUState *s)
{
   ...
}

static void s390_cpu_reset_initial(CPUState *s)
{
    ...
    s390_cpu_reset_normal(s);
    ...
}

static void s390_cpu_reset_clear(CPUState *s)
{
    ...
    s390_cpu_reset_initial()
    ...
}

Just my 0.02 =80, but at least for me, that's easier to understand than a
switch-case statement with fallthroughs inbetween.

 Thomas


