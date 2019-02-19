Received: from eggs.gnu.org ([209.51.188.92]:38485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwB48-0003TG-BJ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwB40-0006Md-A5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:28:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwB3z-0006LK-RI
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:28:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so9908143wrg.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 11:28:19 -0800 (PST)
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9c77bb1-b392-06f7-c42d-471d12c75e0d@redhat.com>
Date: Tue, 19 Feb 2019 20:28:16 +0100
MIME-Version: 1.0
In-Reply-To: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, dovgaluk@ispras.ru, armbru@redhat.com, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com, natalia.fursova@ispras.ru, arikalo@wavecomp.com

On 2/19/19 8:15 PM, Aleksandar Markovic wrote:
> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> This patch enables QMP-based querying of the available CPU types for
> MIPS and MIPS64 platforms.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Aleksandar, FYI I tested v1 and your v2 that way:

$ mips64el-softmmu/qemu-system-mips64el -S \
    -qmp tcp:localhost:4444,server,nowait

$ telnet localhost 4444
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 3},
"package": "v3.1.0-1924-gc7b700fafb"}, "capabilities": ["oob"]}}

{ "execute": "qmp_capabilities" }
{"return": {}}

{ "execute": "query-cpu-definitions" }
{"return": [{"name": "24KEc", "typename": "24KEc-mips64-cpu", "static":
false}, {"name": "MIPS64R2-generic", "typename":
"MIPS64R2-generic-mips64-cpu", "static": false}, {"name": "VR5432",
"typename": "VR5432-mips64-cpu", "static": false}, {"name": "M14Kc",
"typename": "M14Kc-mips64-cpu", "static": false}, {"name": "20Kc",
"typename": "20Kc-mips64-cpu", "static": false}, {"name": "4Km",
"typename": "4Km-mips64-cpu", "static": false}, {"name": "mips64dspr2",
"typename": "mips64dspr2-mips64-cpu", "static": false}, {"name":
"I6400", "typename": "I6400-mips64-cpu", "static": false}, {"name":
"Loongson-2E", "typename": "Loongson-2E-mips64-cpu", "static": false},
{"name": "I6500", "typename": "I6500-mips64-cpu", "static": false},
{"name": "4KEcR1", "typename": "4KEcR1-mips64-cpu", "static": false},
{"name": "74Kf", "typename": "74Kf-mips64-cpu", "static": false},
{"name": "24Kf", "typename": "24Kf-mips64-cpu", "static": false},
{"name": "5KEc", "typename": "5KEc-mips64-cpu", "static": false},
{"name": "P5600", "typename": "P5600-mips64-cpu", "static": false},
{"name": "I7200", "typename": "I7200-mips64-cpu", "static": false},
{"name": "M14K", "typename": "M14K-mips64-cpu", "static": false},
{"name": "5KEf", "typename": "5KEf-mips64-cpu", "static": false},
{"name": "24Kc", "typename": "24Kc-mips64-cpu", "static": false},
{"name": "4KEm", "typename": "4KEm-mips64-cpu", "static": false},
{"name": "4Kc", "typename": "4Kc-mips64-cpu", "static": false}, {"name":
"5Kc", "typename": "5Kc-mips64-cpu", "static": false}, {"name":
"4KEmR1", "typename": "4KEmR1-mips64-cpu", "static": false}, {"name":
"R4000", "typename": "R4000-mips64-cpu", "static": false}, {"name":
"5Kf", "typename": "5Kf-mips64-cpu", "static": false}, {"name":
"mips32r6-generic", "typename": "mips32r6-generic-mips64-cpu", "static":
false}, {"name": "4KEc", "typename": "4KEc-mips64-cpu", "static":
false}, {"name": "34Kf", "typename": "34Kf-mips64-cpu", "static":
false}, {"name": "Loongson-2F", "typename": "Loongson-2F-mips64-cpu",
"static": false}]}

See: https://wiki.qemu.org/Documentation/QMP

Regards,

Phil.

> ---
> 
> v1->v2:
> 
>   - rebased to the latest QAPI code
> 
>  qapi/target.json     |  4 ++--
>  target/mips/helper.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/target.json b/qapi/target.json
> index da7b4be..1d4d54b 100644
> --- a/qapi/target.json
> +++ b/qapi/target.json
> @@ -499,7 +499,7 @@
>              'static': 'bool',
>              '*unavailable-features': [ 'str' ],
>              'typename': 'str' },
> -  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X)' }
> +  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
>  
>  ##
>  # @query-cpu-definitions:
> @@ -511,4 +511,4 @@
>  # Since: 1.2.0
>  ##
>  { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
> -  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X)' }
> +  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index 944f094..c44cdca 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/cpu_ldst.h"
>  #include "exec/log.h"
>  #include "hw/mips/cpudevs.h"
> +#include "qapi/qapi-commands-target.h"
>  
>  enum {
>      TLBRET_XI = -6,
> @@ -1470,3 +1471,35 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIPSState *env,
>  
>      cpu_loop_exit_restore(cs, pc);
>  }
> +
> +static void mips_cpu_add_definition(gpointer data, gpointer user_data)
> +{
> +    ObjectClass *oc = data;
> +    CpuDefinitionInfoList **cpu_list = user_data;
> +    CpuDefinitionInfoList *entry;
> +    CpuDefinitionInfo *info;
> +    const char *typename;
> +
> +    typename = object_class_get_name(oc);
> +    info = g_malloc0(sizeof(*info));
> +    info->name = g_strndup(typename,
> +                           strlen(typename) - strlen("-" TYPE_MIPS_CPU));
> +    info->q_typename = g_strdup(typename);
> +
> +    entry = g_malloc0(sizeof(*entry));
> +    entry->value = info;
> +    entry->next = *cpu_list;
> +    *cpu_list = entry;
> +}
> +
> +CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
> +{
> +    CpuDefinitionInfoList *cpu_list = NULL;
> +    GSList *list;
> +
> +    list = object_class_get_list(TYPE_MIPS_CPU, false);
> +    g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
> +    g_slist_free(list);
> +
> +    return cpu_list;
> +}
> 
