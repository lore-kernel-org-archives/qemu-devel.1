Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D70C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9D52089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9D52089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGi8-0004ff-0w
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54256)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hZFj3-00059S-Ai
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hZFiz-00065s-8O
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:20:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hZFix-0005kR-42
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:20:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E294230C318C;
 Fri,  7 Jun 2019 14:19:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DFB47DE56;
 Fri,  7 Jun 2019 14:19:53 +0000 (UTC)
Date: Fri, 7 Jun 2019 16:19:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190607161949.7d5b56d4@redhat.com>
In-Reply-To: <20190607091116.49044-14-ysato@users.sourceforge.jp>
References: <20190607091116.49044-1-ysato@users.sourceforge.jp>
 <20190607091116.49044-14-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 07 Jun 2019 14:19:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v17 13/24] target/rx: Fix cpu types and
 names
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  7 Jun 2019 18:11:05 +0900
Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

> From: Richard Henderson <richard.henderson@linaro.org>
> 
> There was confusion here about abstract classes and naming cpus.
> We had registered a concrete class named "-rxcpu".  This was put
> into the default cpu fields, and matched, so basic tests worked.
> However, no value for -cpu could ever match in rx_cpu_class_by_name.
> 
> Rename the base class to "rx-cpu" and make it abstract.  This
> matches what we do for most other targets.  Create a new concrete
> cpu with the name "rx62n-rx-cpu".
My comments on v16 weren't addressed at all.

I don't see any valid reason for this patch to exist.
It should be split and merged with patches that introduce 'confusion'
so that broken code won't exist in the first place.

more below ...

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/cpu.h | 12 ++++++------
>  hw/rx/rx-virt.c |  2 +-
>  hw/rx/rx62n.c   |  2 +-
>  target/rx/cpu.c | 43 ++++++++++++++++++++++++++-----------------
>  4 files changed, 34 insertions(+), 25 deletions(-)
> 
> diff --git a/target/rx/cpu.h b/target/rx/cpu.h
> index 8c1a4e448d..a0b6975963 100644
> --- a/target/rx/cpu.h
> +++ b/target/rx/cpu.h
> @@ -24,14 +24,14 @@
>  #include "hw/registerfields.h"
>  #include "qom/cpu.h"
>  
> -#define TYPE_RXCPU "rxcpu"
> +#define TYPE_RX_CPU "rx-cpu"
>  
>  #define RXCPU_CLASS(klass)                                     \
> -    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RXCPU)
> +    OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
>  #define RXCPU(obj) \
> -    OBJECT_CHECK(RXCPU, (obj), TYPE_RXCPU)
> +    OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
>  #define RXCPU_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RXCPU)
> +    OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
>  
>  /*
>   * RXCPUClass:
> @@ -164,9 +164,9 @@ static inline RXCPU *rx_env_get_cpu(CPURXState *env)
>  
>  #define ENV_OFFSET offsetof(RXCPU, env)
>  
> -#define RX_CPU_TYPE_SUFFIX "-" TYPE_RXCPU
> +#define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
>  #define RX_CPU_TYPE_NAME(model) model RX_CPU_TYPE_SUFFIX
> -#define CPU_RESOLVING_TYPE TYPE_RXCPU
> +#define CPU_RESOLVING_TYPE TYPE_RX_CPU
>  
>  extern const char rx_crname[][6];
>  
> diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
> index 3deb7cb335..72a2989fcf 100644
> --- a/hw/rx/rx-virt.c
> +++ b/hw/rx/rx-virt.c
> @@ -88,7 +88,7 @@ static void rxvirt_class_init(ObjectClass *oc, void *data)
>      mc->desc = "RX QEMU Virtual Target";
>      mc->init = rxvirt_init;
>      mc->is_default = 1;
> -    mc->default_cpu_type = TYPE_RXCPU;
> +    mc->default_cpu_type = RX_CPU_TYPE_NAME("rx62n");
>  }
>  
>  static const TypeInfo rxvirt_type = {
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> index c6660b75b4..3a8fe7b0bf 100644
> --- a/hw/rx/rx62n.c
> +++ b/hw/rx/rx62n.c
> @@ -195,7 +195,7 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
>      }
>  
>      object_initialize_child(OBJECT(s), "cpu", &s->cpu,
> -                            sizeof(RXCPU), TYPE_RXCPU,
> +                            sizeof(RXCPU), RX_CPU_TYPE_NAME("rx62n"),
>                              errp, NULL);
>      object_property_set_bool(OBJECT(&s->cpu), true, "realized", errp);
>  
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 3268077d08..41fe1de4bb 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -74,13 +74,14 @@ static void rx_cpu_list_entry(gpointer data, gpointer user_data)
>      const char *typename = object_class_get_name(OBJECT_CLASS(data));
>      int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
>  
> -    qemu_printf("%.*s\n", len, typename);
> +    qemu_printf("  %.*s\n", len, typename);
>  }
>  
>  void rx_cpu_list(void)
>  {
> -    GSList *list;
> -    list = object_class_get_list_sorted(TYPE_RXCPU, false);
> +    GSList *list = object_class_get_list_sorted(TYPE_RX_CPU, false);
> +
> +    qemu_printf("Available CPUs:\n");
>      g_slist_foreach(list, rx_cpu_list_entry, NULL);
>      g_slist_free(list);
>  }
> @@ -88,15 +89,17 @@ void rx_cpu_list(void)
>  static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> -    char *typename = NULL;
> +    char *typename;
>  
> -    typename = g_strdup_printf(RX_CPU_TYPE_NAME(""));
> +    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
>      oc = object_class_by_name(typename);

again repeating v16: see alpha_cpu_class_by_name() as preferred
way to use this method.

> -    if (oc != NULL && object_class_is_abstract(oc)) {
> -        oc = NULL;
> -    }
> -
>      g_free(typename);
> +
> +    if (oc == NULL ||
> +        object_class_is_abstract(oc) ||
> +        !object_class_dynamic_cast(oc, TYPE_RX_CPU)) {
> +        return NULL;
> +    }
>      return oc;
>  }
>  
> @@ -166,7 +169,7 @@ static void rx_cpu_init(Object *obj)
>      qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
>  }
>  
> -static void rxcpu_class_init(ObjectClass *klass, void *data)
> +static void rx_cpu_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      CPUClass *cc = CPU_CLASS(klass);
> @@ -195,22 +198,28 @@ static void rxcpu_class_init(ObjectClass *klass, void *data)
>      cc->gdb_num_core_regs = 26;
>  }
>  
> -static const TypeInfo rxcpu_info = {
> -    .name = TYPE_RXCPU,
> +static const TypeInfo rx_cpu_info = {
> +    .name = TYPE_RX_CPU,
>      .parent = TYPE_CPU,
>      .instance_size = sizeof(RXCPU),
>      .instance_init = rx_cpu_init,
> -    .abstract = false,
> +    .abstract = true,
>      .class_size = sizeof(RXCPUClass),
> -    .class_init = rxcpu_class_init,
> +    .class_init = rx_cpu_class_init,
> +};
> +
> +static const TypeInfo rx62n_rx_cpu_info = {
> +    .name = RX_CPU_TYPE_NAME("rx62n"),
> +    .parent = TYPE_RX_CPU,
>  };
>  
> -static void rxcpu_register_types(void)
> +static void rx_cpu_register_types(void)
>  {
> -    type_register_static(&rxcpu_info);
> +    type_register_static(&rx_cpu_info);
> +    type_register_static(&rx62n_rx_cpu_info);
>  }
>  
> -type_init(rxcpu_register_types)
> +type_init(rx_cpu_register_types)
>  
>  static uint32_t extable[32];
>  


