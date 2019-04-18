Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DE6C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24139214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24139214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39687 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5AS-0006F1-Ec
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:25:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH58h-00050Y-Lp
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH58g-0004yr-Pg
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hH58g-0004yB-KG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDF8B306BB87;
	Thu, 18 Apr 2019 11:23:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C2B9608C7;
	Thu, 18 Apr 2019 11:23:31 +0000 (UTC)
Date: Thu, 18 Apr 2019 13:23:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418132327.3a6cc19d@redhat.com>
In-Reply-To: <20190418040103.15314-1-ehabkost@redhat.com>
References: <20190418040103.15314-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 18 Apr 2019 11:23:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hppa: Delete unused hppa_cpu_list()
 function
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418112327.5KbKlN6XKGJEtT8M9QXawC_jMtW200F6c5WgCKawdb8@z>

On Thu, 18 Apr 2019 01:01:03 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> hppa_cpu_list() is dead code and is never called.  Delete it.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/hppa/cpu.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 00bf444620..b3b1826209 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -110,28 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>  }
>  
> -static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
> -{
> -    ObjectClass *oc = data;
> -    CPUListState *s = user_data;
> -
> -    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
> -}
> -
> -void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> -{
> -    CPUListState s = {
> -        .file = f,
> -        .cpu_fprintf = cpu_fprintf,
> -    };
> -    GSList *list;
> -
> -    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
> -    (*cpu_fprintf)(f, "Available CPUs:\n");
> -    g_slist_foreach(list, hppa_cpu_list_entry, &s);
> -    g_slist_free(list);
> -}
> -
>  static void hppa_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);


