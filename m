Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D8EC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A81320835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A81320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGdOm-0004cK-Rq
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 01:46:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdNb-0003uh-GA
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGdNa-0003ft-6A
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hGdNZ-0003fG-QS; Wed, 17 Apr 2019 01:45:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5AC0882EF;
	Wed, 17 Apr 2019 05:45:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D57A6013D;
	Wed, 17 Apr 2019 05:45:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3CC8B1138648; Wed, 17 Apr 2019 07:45:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-6-ehabkost@redhat.com>
Date: Wed, 17 Apr 2019 07:45:01 +0200
In-Reply-To: <20190417025944.16154-6-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Tue, 16 Apr 2019 23:59:44 -0300")
Message-ID: <87wojtyyle.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 17 Apr 2019 05:45:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/5] cpu: Add MachineState parameter to
 parse_features()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Like Xu <like.xu@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417054501.bzpnsKh370IcfV5RZMYZUzdXp_87l-AUGtJG0ofUXs4@z>

Eduardo Habkost <ehabkost@redhat.com> writes:

> The ppc implementation of parse_features() requires the machine
> object to be created before it gets called.  This is far from
> obvious when reading the code at main().
>
> Instead of making it call qdev_get_machine(), require the caller
> of parse_cpu_option() to provide the machine object.
>
> This makes the initialization dependency explicit at main(), and
> will let us move qdev_get_machine() to CONFIG_SOFTMMU in the
> future.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qom/cpu.h               | 5 +++--
>  target/ppc/cpu-qom.h            | 3 ++-
>  exec.c                          | 4 ++--
>  qom/cpu.c                       | 3 ++-
>  target/i386/cpu.c               | 3 ++-
>  target/ppc/translate_init.inc.c | 7 ++++---
>  target/sparc/cpu.c              | 3 ++-
>  vl.c                            | 3 ++-
>  8 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index e11b14d9ac..cbc8e103bb 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -164,7 +164,8 @@ typedef struct CPUClass {
>      /*< public >*/
>  
>      ObjectClass *(*class_by_name)(const char *cpu_model);
> -    void (*parse_features)(const char *typename, char *str, Error **errp);
> +    void (*parse_features)(MachineState *machine, const char *typename,
> +                           char *str, Error **errp);
>  
>      void (*reset)(CPUState *cpu);
>      int reset_dump_flags;
> @@ -697,7 +698,7 @@ CPUState *cpu_create(const char *typename);
>   * Returns: type of CPU to create or prints error and terminates process
>   *          if an error occurred.
>   */
> -const char *parse_cpu_option(const char *cpu_option);
> +const char *parse_cpu_option(MachineState *machine, const char *cpu_option);
>  
>  /**
>   * lookup_cpu_class:
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index be9b4c30c3..7891465554 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -167,7 +167,8 @@ typedef struct PowerPCCPUClass {
>      DeviceRealize parent_realize;
>      DeviceUnrealize parent_unrealize;
>      void (*parent_reset)(CPUState *cpu);
> -    void (*parent_parse_features)(const char *type, char *str, Error **errp);
> +    void (*parent_parse_features)(MachineState *machine, const char *type,
> +                                  char *str, Error **errp);
>  
>      uint32_t pvr;
>      bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr);
> diff --git a/exec.c b/exec.c
> index d359e709a6..1ca95df9d8 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -992,7 +992,7 @@ CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp)
>      return CPU_CLASS(oc);
>  }
>  
> -const char *parse_cpu_option(const char *cpu_option)
> +const char *parse_cpu_option(MachineState *machine, const char *cpu_option)
>  {
>      CPUClass *cc;
>      gchar **model_pieces;
> @@ -1002,7 +1002,7 @@ const char *parse_cpu_option(const char *cpu_option)
>  
>      cc = lookup_cpu_class(model_pieces[0], &error_fatal);
>      cpu_type = object_class_get_name(OBJECT_CLASS(cc));
> -    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
> +    cc->parse_features(machine, cpu_type, model_pieces[1], &error_fatal);
>      g_strfreev(model_pieces);
>      return cpu_type;
>  }
> diff --git a/qom/cpu.c b/qom/cpu.c
> index a8d2958956..c8a7b56148 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -291,7 +291,8 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
>      return cc->class_by_name(cpu_model);
>  }
>  
> -static void cpu_common_parse_features(const char *typename, char *features,
> +static void cpu_common_parse_features(MachineState *machine,
> +                                      const char *typename, char *features,
>                                        Error **errp)
>  {
>      char *val;
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d6bb57d210..f5e15ac5da 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3528,7 +3528,8 @@ static gint compare_string(gconstpointer a, gconstpointer b)
>  
>  /* Parse "+feature,-feature,feature=foo" CPU feature string
>   */
> -static void x86_cpu_parse_featurestr(const char *typename, char *features,
> +static void x86_cpu_parse_featurestr(MachineState *machine,
> +                                     const char *typename, char *features,
>                                       Error **errp)
>  {
>      char *featurestr; /* Single 'key=value" string being parsed */
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index 0bd555eb19..2ad223fcca 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10119,10 +10119,11 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
>      return oc;
>  }
>  
> -static void ppc_cpu_parse_featurestr(const char *type, char *features,
> +static void ppc_cpu_parse_featurestr(MachineState *ms,
> +                                     const char *type, char *features,
>                                       Error **errp)
>  {
> -    Object *machine = qdev_get_machine();
> +    Object *machine = OBJECT(ms);
>      const PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(object_class_by_name(type));
>  
>      if (!features) {
> @@ -10171,7 +10172,7 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
>      }
>  
>      /* do property processing with generic handler */
> -    pcc->parent_parse_features(type, features, errp);
> +    pcc->parent_parse_features(ms, type, features, errp);
>  }
>  
>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 4a4445bdf5..7e360de5ee 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -115,7 +115,8 @@ cpu_add_feat_as_prop(const char *typename, const char *name, const char *val)
>  }
>  
>  /* Parse "+feature,-feature,feature=foo" CPU feature string */
> -static void sparc_cpu_parse_features(const char *typename, char *features,
> +static void sparc_cpu_parse_features(MachineState *machine,
> +                                     const char *typename, char *features,
>                                       Error **errp)
>  {
>      GList *l, *plus_features = NULL, *minus_features = NULL;
> diff --git a/vl.c b/vl.c
> index c57e28d1da..e78c4d5a53 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4466,7 +4466,8 @@ int main(int argc, char **argv, char **envp)
>      /* parse features once if machine provides default cpu_type */
>      current_machine->cpu_type = machine_class->default_cpu_type;
>      if (cpu_option) {
> -        current_machine->cpu_type = parse_cpu_option(cpu_option);
> +        current_machine->cpu_type =
> +            parse_cpu_option(current_machine, cpu_option);
>      }
>      parse_numa_opts(current_machine);

Well, it's not quite as bad as the commit message made me expect: since
we assign to current_machine->cpu_type, we already have a dependence on
machine creation.

Regardless, replacing qdev_get_machine() by explicit data flow is an
improvement.  More so if it really lets us confine qdev_get_machine() to
CONFIG_SOFTMMU.

