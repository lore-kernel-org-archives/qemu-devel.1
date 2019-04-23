Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC01C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE00218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE00218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ49t-0008TN-D4
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:45:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ466-0005CC-4D
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3sK-0003Wg-0D
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:26:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3sG-0002w0-VR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:26:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so1980167wmj.3
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vCeweTX6Y+6x7CvhicLJhsFjVf0244zoqgzHqsjZgj4=;
	b=NYVBJ9nEQ3EGd/+FiMZzSEyEdnDIHXbifBGlW+94p2k3J+zsskzgXNDA0prvbi0At3
	kApNyRDg0Ho0k7qGtGjsCZQ45zZrH/3kTd6qABl7ZMkGylmdp0BU/7DN3YXXxk5Xjsh0
	mU8Y33GUGZ8P3/0XSLWIowQwlEhkjwi7Zh5j7Kgypybs+W2N5ejSIb1VnV9cwZf7C72p
	4F3JGFSj3yybIk320B3ek4Rr8s2n1j3uUTpbkTky3YoW5UnknEb8UiKuYE177C9HmJ8O
	6m5ErQE2/xXHLwEK+AFlFzh65uT8SZDLxctXyjBk6Nt/ui8O00b9GaHVwzJfpP3uu21z
	13Fg==
X-Gm-Message-State: APjAAAVFk2Vn53QVsgN25fHSGoC3Ex3dalHjvbg9lUZ7eoP0IiD/5orw
	L/JmEXbyr2v94NG1299tsFtfPg==
X-Google-Smtp-Source: APXvYqyC5sE2zJMAjJYDbRsyKN1N3O9F5rXOC51HtzvxS3lZDba29gKb9Ngck/vVrdSE2Xno2bzbvg==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr3908985wmk.112.1556058391414; 
	Tue, 23 Apr 2019 15:26:31 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	f1sm13964005wrt.87.2019.04.23.15.26.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:26:30 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <20d39506-8b43-29f5-7b9e-881c94de16e8@redhat.com>
Date: Wed, 24 Apr 2019 00:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-3-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Use SupportStatusInfo for
 deprecation info
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, mprivozn@redhat.com,
	Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423222629.gy1EnyN3Ri7U8IFtMOQanvjemyqYzFZ0Ek-E1OUACho@z>

On 4/23/19 11:22 PM, Eduardo Habkost wrote:
> Use SupportStatusInfo to represent deprecation information of
> machine types.
> 
> Instead of using a generic "use XXX instead" message for humans,
> encode the suggested alternative in a machine-friendly way at the
> 'suggested_alternatives' field.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/boards.h |  7 ++++---
>  hw/i386/pc_piix.c   |  4 +++-
>  hw/ppc/prep.c       |  4 +++-
>  vl.c                | 13 +++++++++----
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index e231860666..243bf3c7ce 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -8,6 +8,8 @@
>  #include "hw/qdev.h"
>  #include "qom/object.h"
>  #include "qom/cpu.h"
> +#include "qapi/qapi-types-common.h"
> +
>  
>  /**
>   * memory_region_allocate_system_memory - Allocate a board's main memory
> @@ -105,8 +107,7 @@ typedef struct {
>  
>  /**
>   * MachineClass:
> - * @deprecation_reason: If set, the machine is marked as deprecated. The
> - *    string should provide some clear information about what to use instead.
> + * @support_status: Support and deprecation status of machine type.
>   * @max_cpus: maximum number of CPUs supported. Default: 1
>   * @min_cpus: minimum number of CPUs supported. Default: 1
>   * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
> @@ -169,7 +170,7 @@ struct MachineClass {
>      char *name;
>      const char *alias;
>      const char *desc;
> -    const char *deprecation_reason;
> +    SupportStatusInfo support_status;
>  
>      void (*init)(MachineState *state);
>      void (*reset)(void);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 8ad8e885c6..97bd401618 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -781,7 +781,9 @@ static void pc_i440fx_0_15_machine_options(MachineClass *m)
>  
>      pc_i440fx_1_0_machine_options(m);
>      m->hw_version = "0.15";
> -    m->deprecation_reason = "use a newer machine type instead";
> +    m->support_status.deprecated = true;
> +    m->support_status.has_suggested_alternative = true;
> +    m->support_status.suggested_alternative = g_strdup("pc");
>      compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
>  }
>  
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 847d320465..9a02b0eec4 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -587,7 +587,9 @@ static void ppc_prep_init(MachineState *machine)
>  
>  static void prep_machine_init(MachineClass *mc)
>  {
> -    mc->deprecation_reason = "use 40p machine type instead";
> +    mc->support_status.deprecated = true;
> +    mc->support_status.has_suggested_alternative = true;
> +    mc->support_status.suggested_alternative = g_strdup("40p");
>      mc->desc = "PowerPC PREP platform";
>      mc->init = ppc_prep_init;
>      mc->block_default_type = IF_IDE;
> diff --git a/vl.c b/vl.c
> index c696ad2a13..99b857ed2a 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2610,7 +2610,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>              }
>              printf("%-20s %s%s%s\n", mc->name, mc->desc,
>                     mc->is_default ? " (default)" : "",
> -                   mc->deprecation_reason ? " (deprecated)" : "");
> +                   mc->support_status.deprecated ? " (deprecated)" : "");
>          }
>      }
>  
> @@ -4308,9 +4308,14 @@ int main(int argc, char **argv, char **envp)
>       * called from configure_accelerator().
>       */
>  
> -    if (!qtest_enabled() && machine_class->deprecation_reason) {
> -        error_report("Machine type '%s' is deprecated: %s",
> -                     machine_class->name, machine_class->deprecation_reason);
> +    if (!qtest_enabled() && machine_class->support_status.deprecated) {
> +        error_report("Machine type '%s' is deprecated%s%s", machine_class->name,
> +                     machine_class->support_status.status_message ? ": " : "",
> +                     machine_class->support_status.status_message ?: "");
> +        if (machine_class->support_status.suggested_alternative) {
> +            error_report("Suggested solution: use '%s' machine type instead",

Maybe "Recommended alternative:"?
(Also consider renaming the SupportStatusInfo.suggested_alternative field).

> +                         machine_class->support_status.suggested_alternative);
> +        }
>      }
>  
>      /*
> 

