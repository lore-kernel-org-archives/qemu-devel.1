Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6190BC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A8221479
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A8221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH54Z-0001Kh-7j
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:19:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH52a-0008C7-Ei
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH4ta-0004nb-KZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hH4ta-0004nJ-C1; Thu, 18 Apr 2019 07:07:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 673863002E05;
	Thu, 18 Apr 2019 11:07:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 05CE0600C2;
	Thu, 18 Apr 2019 11:07:53 +0000 (UTC)
Date: Thu, 18 Apr 2019 13:07:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418130753.1dbf0b6b@redhat.com>
In-Reply-To: <20190417025944.16154-2-ehabkost@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 18 Apr 2019 11:07:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] cpu: Rename parse_cpu_model() to
 parse_cpu_option()
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
	Like Xu <like.xu@linux.intel.com>, Markus Armbruster <armbru@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418110753.BUWIST7fPQGurfEM9u_WZfTU3GlANNNiv9crdpDShY8@z>

On Tue, 16 Apr 2019 23:59:40 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The "model[,option...]" string parsed by the function is not just
> a CPU model.  Rename the function and its argument to indicate it
> expects the full "-cpu" option to be provided.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/qom/cpu.h |  6 +++---
>  bsd-user/main.c   |  2 +-
>  exec.c            |  4 ++--
>  linux-user/main.c |  2 +-
>  vl.c              | 18 +++++++++---------
>  5 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 1d6099e5d4..d28c690b27 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -689,15 +689,15 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
>  CPUState *cpu_create(const char *typename);
>  
>  /**
> - * parse_cpu_model:
> - * @cpu_model: The model string including optional parameters.
> + * parse_cpu_option:
> + * @cpu_option: The -cpu option including optional parameters.
>   *
>   * processes optional parameters and registers them as global properties
>   *
>   * Returns: type of CPU to create or prints error and terminates process
>   *          if an error occurred.
>   */
> -const char *parse_cpu_model(const char *cpu_model);
> +const char *parse_cpu_option(const char *cpu_option);
>  
>  /**
>   * cpu_has_work:
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 0d3156974c..a6c055f5fb 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -903,7 +903,7 @@ int main(int argc, char **argv)
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);
>  
> -    cpu_type = parse_cpu_model(cpu_model);
> +    cpu_type = parse_cpu_option(cpu_model);
>      cpu = cpu_create(cpu_type);
>      env = cpu->env_ptr;
>  #if defined(TARGET_SPARC) || defined(TARGET_PPC)
> diff --git a/exec.c b/exec.c
> index 6ab62f4eee..840677f15f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -982,14 +982,14 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  #endif
>  }
>  
> -const char *parse_cpu_model(const char *cpu_model)
> +const char *parse_cpu_option(const char *cpu_option)
>  {
>      ObjectClass *oc;
>      CPUClass *cc;
>      gchar **model_pieces;
>      const char *cpu_type;
>  
> -    model_pieces = g_strsplit(cpu_model, ",", 2);
> +    model_pieces = g_strsplit(cpu_option, ",", 2);
>  
>      oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
>      if (oc == NULL) {
> diff --git a/linux-user/main.c b/linux-user/main.c
> index a0aba9cb1e..20e0f51cfa 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -660,7 +660,7 @@ int main(int argc, char **argv, char **envp)
>      if (cpu_model == NULL) {
>          cpu_model = cpu_get_model(get_elf_eflags(execfd));
>      }
> -    cpu_type = parse_cpu_model(cpu_model);
> +    cpu_type = parse_cpu_option(cpu_model);
>  
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);
> diff --git a/vl.c b/vl.c
> index c696ad2a13..c57e28d1da 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3002,7 +3002,7 @@ int main(int argc, char **argv, char **envp)
>      const char *optarg;
>      const char *loadvm = NULL;
>      MachineClass *machine_class;
> -    const char *cpu_model;
> +    const char *cpu_option;
>      const char *vga_model = NULL;
>      const char *qtest_chrdev = NULL;
>      const char *qtest_log = NULL;
> @@ -3081,7 +3081,7 @@ int main(int argc, char **argv, char **envp)
>      QLIST_INIT (&vm_change_state_head);
>      os_setup_early_signal_handling();
>  
> -    cpu_model = NULL;
> +    cpu_option = NULL;
>      snapshot = 0;
>  
>      nb_nics = 0;
> @@ -3133,7 +3133,7 @@ int main(int argc, char **argv, char **envp)
>              switch(popt->index) {
>              case QEMU_OPTION_cpu:
>                  /* hw initialization will check this */
> -                cpu_model = optarg;
> +                cpu_option = optarg;
>                  break;
>              case QEMU_OPTION_hda:
>              case QEMU_OPTION_hdb:
> @@ -4050,8 +4050,8 @@ int main(int argc, char **argv, char **envp)
>          qemu_set_hw_version(machine_class->hw_version);
>      }
>  
> -    if (cpu_model && is_help_option(cpu_model)) {
> -        list_cpus(stdout, &fprintf, cpu_model);
> +    if (cpu_option && is_help_option(cpu_option)) {
> +        list_cpus(stdout, &fprintf, cpu_option);
>          exit(0);
>      }
>  
> @@ -4299,9 +4299,9 @@ int main(int argc, char **argv, char **envp)
>       * Global properties get set up by qdev_prop_register_global(),
>       * called from user_register_global_props(), and certain option
>       * desugaring.  Also in CPU feature desugaring (buried in
> -     * parse_cpu_model()), which happens below this point, but may
> +     * parse_cpu_option()), which happens below this point, but may
>       * only target the CPU type, which can only be created after
> -     * parse_cpu_model() returned the type.
> +     * parse_cpu_option() returned the type.
>       *
>       * Machine compat properties: object_set_machine_compat_props().
>       * Accelerator compat props: object_set_accelerator_compat_props(),
> @@ -4465,8 +4465,8 @@ int main(int argc, char **argv, char **envp)
>  
>      /* parse features once if machine provides default cpu_type */
>      current_machine->cpu_type = machine_class->default_cpu_type;
> -    if (cpu_model) {
> -        current_machine->cpu_type = parse_cpu_model(cpu_model);
> +    if (cpu_option) {
> +        current_machine->cpu_type = parse_cpu_option(cpu_option);
>      }
>      parse_numa_opts(current_machine);
>  


