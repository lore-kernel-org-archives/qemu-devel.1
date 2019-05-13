Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DFCC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7F920879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 15:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7F920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59293 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQD2M-0000M8-PT
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 11:38:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQD0w-00082E-CS
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQD0v-0001pC-BG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 11:37:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hQD0r-0001n3-CE; Mon, 13 May 2019 11:37:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67AD6309266D;
	Mon, 13 May 2019 15:37:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BBEA60C4D;
	Mon, 13 May 2019 15:37:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9B99B11385E4; Mon, 13 May 2019 17:37:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Jones <drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-14-drjones@redhat.com>
Date: Mon, 13 May 2019 17:37:09 +0200
In-Reply-To: <20190512083624.8916-14-drjones@redhat.com> (Andrew Jones's
	message of "Sun, 12 May 2019 10:36:24 +0200")
Message-ID: <87tvdye57e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 13 May 2019 15:37:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 13/13] target/arm/kvm: host cpu: Add
 support for sve-vls-map
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, abologna@redhat.com, qemu-arm@nongnu.org,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andrew Jones <drjones@redhat.com> writes:

> Allow the host cpu type to enable SVE in guests with the sve-vls-map
> cpu property.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.c   |  1 +
>  target/arm/cpu.h   |  2 ++
>  target/arm/cpu64.c | 12 +++++++++---
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ea0e24bba8b6..a5c01ff42c78 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2222,6 +2222,7 @@ static void arm_host_initfn(Object *obj)
>      ARMCPU *cpu =3D ARM_CPU(obj);
>=20=20
>      kvm_arm_set_cpu_features_from_host(cpu);
> +    aarch64_add_sve_vls_map_property(obj);
>      arm_cpu_post_init(obj);
>  }
>=20=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f0d0ce759ba8..13731ccb39f3 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -976,11 +976,13 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, u=
int8_t *buf, int reg);
>  void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>  void aarch64_sve_change_el(CPUARMState *env, int old_el,
>                             int new_el, bool el0_a64);
> +void aarch64_add_sve_vls_map_property(Object *obj);
>  #else
>  static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) =
{ }
>  static inline void aarch64_sve_change_el(CPUARMState *env, int o,
>                                           int n, bool a)
>  { }
> +void aarch64_add_sve_vls_map_property(Object *obj) { }

qemu/target/arm/cpu.h:985:6: error: no previous prototype for =E2=80=98aarc=
h64_add_sve_vls_map_property=E2=80=99 [-Werror=3Dmissing-prototypes]
 void aarch64_add_sve_vls_map_property(Object *obj) { }
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Did you forget static inline?

>  #endif
>=20=20
>  target_ulong do_arm_semihosting(CPUARMState *env);
[...]

