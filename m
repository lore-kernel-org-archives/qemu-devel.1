Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A88C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D23F20714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOnxkl1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D23F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7zX-0007Gi-K8
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iY7ya-0006Sn-2G
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iY7yY-0007Pm-Ki
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:23:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iY7yY-0007PW-H7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574425430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uqx1xmNj1e+gFqYpWwe0U6FMFid0qtGoykXZef8cEI=;
 b=MOnxkl1NLfsBQ5xhs4SqJh43YuwKLr8aKf0H+ioIFPO/HuD1iiyHxlmiGJOiOD40htZ6Z1
 h2Jzn8HVe+3pjyxJLz7AHvTKdOn8TWwyGaMyRtXMvGh6syDzvAP9aM+xSo8hpKDtFAyavO
 Jc7rTZRQ131dDBvlbDvcjfCYFzBoIr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-EpgiF7R1MbiaBsPK9lxn6w-1; Fri, 22 Nov 2019 07:23:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63FDC801E74;
 Fri, 22 Nov 2019 12:23:44 +0000 (UTC)
Received: from [10.36.118.121] (unknown [10.36.118.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE11563620;
 Fri, 22 Nov 2019 12:23:42 +0000 (UTC)
Subject: Re: [PATCH] Remove wrappers
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <4793f8ae-a709-2a41-ea71-4197a026b58a@redhat.com>
 <20191122122019.23069-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f63f7243-005a-6679-df31-577126938170@redhat.com>
Date: Fri, 22 Nov 2019 13:23:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122122019.23069-1-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: EpgiF7R1MbiaBsPK9lxn6w-1
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.11.19 13:20, Janosch Frank wrote:
> That's what it would look like.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   target/s390x/cpu-qom.h | 12 ++++++++----
>   target/s390x/cpu.c     | 28 +++++-----------------------
>   target/s390x/cpu.h     |  8 +++++---
>   target/s390x/sigp.c    |  4 ++--
>   4 files changed, 20 insertions(+), 32 deletions(-)
>=20
> diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
> index b809ec8418..e8ec999e77 100644
> --- a/target/s390x/cpu-qom.h
> +++ b/target/s390x/cpu-qom.h
> @@ -34,13 +34,18 @@
>   typedef struct S390CPUModel S390CPUModel;
>   typedef struct S390CPUDef S390CPUDef;
>  =20
> +typedef enum cpu_reset_type {
> +    S390_CPU_RESET_NORMAL,
> +    S390_CPU_RESET_INITIAL,
> +    S390_CPU_RESET_CLEAR,
> +} cpu_reset_type;
> +
>   /**
>    * S390CPUClass:
>    * @parent_realize: The parent class' realize handler.
>    * @parent_reset: The parent class' reset handler.
>    * @load_normal: Performs a load normal.
> - * @cpu_reset: Performs a CPU reset.
> - * @initial_cpu_reset: Performs an initial CPU reset.
> + * @reset: Performs a CPU reset of a given type.
>    *
>    * An S/390 CPU model.
>    */
> @@ -57,8 +62,7 @@ typedef struct S390CPUClass {
>       DeviceRealize parent_realize;
>       void (*parent_reset)(CPUState *cpu);
>       void (*load_normal)(CPUState *cpu);
> -    void (*cpu_reset)(CPUState *cpu);
> -    void (*initial_cpu_reset)(CPUState *cpu);
> +    void (*reset)(CPUState *cpu, cpu_reset_type type);
>   } S390CPUClass;
>  =20
>   typedef struct S390CPU S390CPU;
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 556afecbc1..970495d042 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -82,12 +82,6 @@ static void s390_cpu_load_normal(CPUState *s)
>   }
>   #endif
>  =20
> -typedef enum cpu_reset_type {
> -    S390_CPU_RESET_NORMAL,
> -    S390_CPU_RESET_INITIAL,
> -    S390_CPU_RESET_CLEAR,
> -} cpu_reset_type;
> -
>   static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
>   {
>       S390CPU *cpu =3D S390_CPU(s);
> @@ -138,21 +132,6 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_ty=
pe type)
>   #endif
>   }
>  =20
> -static void s390_cpu_reset_normal(CPUState *s)
> -{
> -    return s390_cpu_reset(s, S390_CPU_RESET_NORMAL);
> -}
> -
> -static void s390_cpu_reset_initial(CPUState *s)
> -{
> -    return s390_cpu_reset(s, S390_CPU_RESET_INITIAL);
> -}
> -
> -static void s390_cpu_reset_clear(CPUState *s)
> -{
> -    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
> -}
> -
>   #if !defined(CONFIG_USER_ONLY)
>   static void s390_cpu_machine_reset_cb(void *opaque)
>   {
> @@ -444,6 +423,11 @@ static Property s390x_cpu_properties[] =3D {
>       DEFINE_PROP_END_OF_LIST()
>   };
>  =20
> +static void s390_cpu_reset_clear(CPUState *s)
> +{
> +    return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
> +}
> +
>   static void s390_cpu_class_init(ObjectClass *oc, void *data)
>   {
>       S390CPUClass *scc =3D S390_CPU_CLASS(oc);
> @@ -459,8 +443,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void=
 *data)
>   #if !defined(CONFIG_USER_ONLY)
>       scc->load_normal =3D s390_cpu_load_normal;
>   #endif
> -    scc->cpu_reset =3D s390_cpu_reset_normal;
> -    scc->initial_cpu_reset =3D s390_cpu_reset_initial;

You have to set

scc->reset =3D s390_cpu_reset;

if I'm not wrong.

>       cc->reset =3D s390_cpu_reset_clear;
>       cc->class_by_name =3D s390_cpu_class_by_name,
>       cc->has_work =3D s390_cpu_has_work;
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 17460ed7b3..687b31d87e 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -734,21 +734,23 @@ static inline uint64_t s390_build_validity_mcic(voi=
d)
>  =20
>   static inline void s390_do_cpu_full_reset(CPUState *cs, run_on_cpu_data=
 arg)
>   {
> -    cpu_reset(cs);
> +    S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
> +
> +    scc->reset(cs, S390_CPU_RESET_CLEAR);
>   }
>  =20
>   static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg)
>   {
>       S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
>  =20
> -    scc->cpu_reset(cs);
> +    scc->reset(cs, S390_CPU_RESET_CLEAR);
>   }
>  =20
>   static inline void s390_do_cpu_initial_reset(CPUState *cs, run_on_cpu_d=
ata arg)
>   {
>       S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
>  =20
> -    scc->initial_cpu_reset(cs);
> +    scc->reset(cs, S390_CPU_RESET_INITIAL);
>   }
>  =20
>   static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_dat=
a arg)
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index 2ce22d4dc1..727875bb4a 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -254,7 +254,7 @@ static void sigp_initial_cpu_reset(CPUState *cs, run_=
on_cpu_data arg)
>       SigpInfo *si =3D arg.host_ptr;
>  =20
>       cpu_synchronize_state(cs);
> -    scc->initial_cpu_reset(cs);
> +    scc->reset(cs, S390_CPU_RESET_INITIAL);
>       cpu_synchronize_post_reset(cs);
>       si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
>   }
> @@ -266,7 +266,7 @@ static void sigp_cpu_reset(CPUState *cs, run_on_cpu_d=
ata arg)
>       SigpInfo *si =3D arg.host_ptr;
>  =20
>       cpu_synchronize_state(cs);
> -    scc->cpu_reset(cs);
> +    scc->reset(cs, S390_CPU_RESET_NORMAL);
>       cpu_synchronize_post_reset(cs);
>       si->cc =3D SIGP_CC_ORDER_CODE_ACCEPTED;
>   }
>=20

Looks good and much cleaner to me :)

--=20

Thanks,

David / dhildenb


