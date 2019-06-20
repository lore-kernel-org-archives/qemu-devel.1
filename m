Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39737C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020E92083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020E92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtnq-00089h-2M
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdtjb-0005QY-AG
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdtjY-0002gM-62
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdtjX-0002fI-U5
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9EE0FA8CA
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 09:51:54 +0000 (UTC)
Received: from work-vm (ovpn-117-203.ams2.redhat.com [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A4215D9C6;
 Thu, 20 Jun 2019 09:51:53 +0000 (UTC)
Date: Thu, 20 Jun 2019 10:51:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190620095150.GD2907@work-vm>
References: <20190619201050.19040-1-armbru@redhat.com>
 <20190619201050.19040-7-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619201050.19040-7-armbru@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 20 Jun 2019 09:51:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/17] qom: Move HMP command handlers to
 qom/
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
Cc: kwolf@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> There are just two HMP commands related to QOM: qom-list and qom-set.
> Move their handlers from monitor/hmp-cmds.c to new qom/qom-hmp-cmds.c,
> where they are covered by MAINTAINERS section QOM.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I look forward to those gaining the qom_get at some stage!

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/monitor/hmp.h |  2 ++
>  monitor/hmp-cmds.c    | 50 +---------------------------------
>  qom/Makefile.objs     |  2 +-
>  qom/qom-hmp-cmds.c    | 62 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 66 insertions(+), 50 deletions(-)
>  create mode 100644 qom/qom-hmp-cmds.c
> 
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 1d095d5837..f46ccdaa35 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -16,6 +16,8 @@
>  
>  #include "qemu/readline.h"
>  
> +void hmp_handle_error(Monitor *mon, Error **errp);
> +
>  void hmp_info_name(Monitor *mon, const QDict *qdict);
>  void hmp_info_version(Monitor *mon, const QDict *qdict);
>  void hmp_info_kvm(Monitor *mon, const QDict *qdict);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index d94ab7563e..5641036dc3 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -60,7 +60,7 @@
>  #include <spice/enums.h>
>  #endif
>  
> -static void hmp_handle_error(Monitor *mon, Error **errp)
> +void hmp_handle_error(Monitor *mon, Error **errp)
>  {
>      assert(errp);
>      if (*errp) {
> @@ -2714,54 +2714,6 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
>      qapi_free_IOThreadInfoList(info_list);
>  }
>  
> -void hmp_qom_list(Monitor *mon, const QDict *qdict)
> -{
> -    const char *path = qdict_get_try_str(qdict, "path");
> -    ObjectPropertyInfoList *list;
> -    Error *err = NULL;
> -
> -    if (path == NULL) {
> -        monitor_printf(mon, "/\n");
> -        return;
> -    }
> -
> -    list = qmp_qom_list(path, &err);
> -    if (err == NULL) {
> -        ObjectPropertyInfoList *start = list;
> -        while (list != NULL) {
> -            ObjectPropertyInfo *value = list->value;
> -
> -            monitor_printf(mon, "%s (%s)\n",
> -                           value->name, value->type);
> -            list = list->next;
> -        }
> -        qapi_free_ObjectPropertyInfoList(start);
> -    }
> -    hmp_handle_error(mon, &err);
> -}
> -
> -void hmp_qom_set(Monitor *mon, const QDict *qdict)
> -{
> -    const char *path = qdict_get_str(qdict, "path");
> -    const char *property = qdict_get_str(qdict, "property");
> -    const char *value = qdict_get_str(qdict, "value");
> -    Error *err = NULL;
> -    bool ambiguous = false;
> -    Object *obj;
> -
> -    obj = object_resolve_path(path, &ambiguous);
> -    if (obj == NULL) {
> -        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> -                  "Device '%s' not found", path);
> -    } else {
> -        if (ambiguous) {
> -            monitor_printf(mon, "Warning: Path '%s' is ambiguous\n", path);
> -        }
> -        object_property_parse(obj, value, property, &err);
> -    }
> -    hmp_handle_error(mon, &err);
> -}
> -
>  void hmp_rocker(Monitor *mon, const QDict *qdict)
>  {
>      const char *name = qdict_get_str(qdict, "name");
> diff --git a/qom/Makefile.objs b/qom/Makefile.objs
> index 5fb43b842c..aae478fc21 100644
> --- a/qom/Makefile.objs
> +++ b/qom/Makefile.objs
> @@ -2,4 +2,4 @@ qom-obj-y = object.o container.o qom-qobject.o
>  qom-obj-y += object_interfaces.o
>  
>  common-obj-y = cpu.o
> -common-obj-$(CONFIG_SOFTMMU) += qom-qmp-cmds.o
> +common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> new file mode 100644
> index 0000000000..2028a21052
> --- /dev/null
> +++ b/qom/qom-hmp-cmds.c
> @@ -0,0 +1,62 @@
> +/*
> + * HMP commands related to QOM
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "monitor/hmp.h"
> +#include "qapi/qapi-commands-qom.h"
> +#include "qapi/qmp/qdict.h"
> +#include "monitor/monitor.h"
> +#include "qom/object.h"
> +#include "qapi/error.h"
> +
> +void hmp_qom_list(Monitor *mon, const QDict *qdict)
> +{
> +    const char *path = qdict_get_try_str(qdict, "path");
> +    ObjectPropertyInfoList *list;
> +    Error *err = NULL;
> +
> +    if (path == NULL) {
> +        monitor_printf(mon, "/\n");
> +        return;
> +    }
> +
> +    list = qmp_qom_list(path, &err);
> +    if (err == NULL) {
> +        ObjectPropertyInfoList *start = list;
> +        while (list != NULL) {
> +            ObjectPropertyInfo *value = list->value;
> +
> +            monitor_printf(mon, "%s (%s)\n",
> +                           value->name, value->type);
> +            list = list->next;
> +        }
> +        qapi_free_ObjectPropertyInfoList(start);
> +    }
> +    hmp_handle_error(mon, &err);
> +}
> +
> +void hmp_qom_set(Monitor *mon, const QDict *qdict)
> +{
> +    const char *path = qdict_get_str(qdict, "path");
> +    const char *property = qdict_get_str(qdict, "property");
> +    const char *value = qdict_get_str(qdict, "value");
> +    Error *err = NULL;
> +    bool ambiguous = false;
> +    Object *obj;
> +
> +    obj = object_resolve_path(path, &ambiguous);
> +    if (obj == NULL) {
> +        error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                  "Device '%s' not found", path);
> +    } else {
> +        if (ambiguous) {
> +            monitor_printf(mon, "Warning: Path '%s' is ambiguous\n", path);
> +        }
> +        object_property_parse(obj, value, property, &err);
> +    }
> +    hmp_handle_error(mon, &err);
> +}
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

