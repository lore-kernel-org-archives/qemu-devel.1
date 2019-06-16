Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DCDC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 18:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7C920870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 18:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7C920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcaEI-0001cL-LK
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 14:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hcaBZ-0007WW-Lg
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hcZyS-0004CY-PW
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:33:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hcZyS-00047Y-Je
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:33:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91CFA3082E63;
 Sun, 16 Jun 2019 18:33:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5842218A26;
 Sun, 16 Jun 2019 18:33:46 +0000 (UTC)
Date: Sun, 16 Jun 2019 20:33:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190616203344.24eadaaf@redhat.com>
In-Reply-To: <20190616142836.10614-6-ysato@users.sourceforge.jp>
References: <20190616142836.10614-1-ysato@users.sourceforge.jp>
 <20190616142836.10614-6-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sun, 16 Jun 2019 18:33:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v20 05/24] target/rx: simplify
 rx_cpu_class_by_name
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 16 Jun 2019 23:28:17 +0900
Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
THere is no point in sending it as separate patch,
If you'd merged this patch into 3/24 I'd ack it.
So pls merge it there.

> ---
>  target/rx/cpu.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index a6dde613ab..e3d76af55d 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -72,9 +72,8 @@ static void rx_cpu_reset(CPUState *s)
>  static void rx_cpu_list_entry(gpointer data, gpointer user_data)
>  {
>      const char *typename = object_class_get_name(OBJECT_CLASS(data));
> -    int len = strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
>  
> -    qemu_printf("%.*s\n", len, typename);
> +    qemu_printf("%s\n", typename);
>  }
>  
>  void rx_cpu_list(void)
> @@ -88,25 +87,12 @@ void rx_cpu_list(void)
>  static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> -    char *typename;
>  
>      oc = object_class_by_name(cpu_model);
> -    if (oc != NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) != NULL &&
> -        !object_class_is_abstract(oc)) {
> -        return oc;
> -    }
> -
> -    typename = g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
> -    oc = object_class_by_name(typename);
> -    if (oc != NULL && object_class_is_abstract(oc)) {
> +    if (object_class_dynamic_cast(oc, TYPE_RX_CPU) == NULL ||
> +        object_class_is_abstract(oc)) {
>          oc = NULL;
>      }
> -    g_free(typename);
> -
> -    if (!oc) {
> -        /* default to rx62n */
> -        oc = object_class_by_name(TYPE_RX62N_CPU);
> -    }
>  
>      return oc;
>  }


