Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B5BC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 18:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 882C120870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 18:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882C120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcZgG-0001cg-JE
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 14:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53937)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hcZfL-00019y-3U
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hcZfK-0005lY-2l
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:14:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hcZfJ-0005jU-Tm
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 14:14:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F2243092656;
 Sun, 16 Jun 2019 18:14:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 232FB90C63;
 Sun, 16 Jun 2019 18:13:59 +0000 (UTC)
Date: Sun, 16 Jun 2019 20:13:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190616201355.531ba10f@redhat.com>
In-Reply-To: <20190616142836.10614-4-ysato@users.sourceforge.jp>
References: <20190616142836.10614-1-ysato@users.sourceforge.jp>
 <20190616142836.10614-4-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Sun, 16 Jun 2019 18:14:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v20 03/24] target/rx: CPU definition
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

On Sun, 16 Jun 2019 23:28:15 +0900
Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20190607091116.49044-4-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use newer QOM style, split cpu-qom.h, restrict access to
>  extable array, use rx_cpu_tlb_fill() extracted from patch of
>  Yoshinori Sato 'Convert to CPUClass::tlb_fill']
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
[...]

> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> new file mode 100644
> index 0000000000..4147c5c939
> --- /dev/null
> +++ b/target/rx/cpu.c
[...]

> +static void rx_cpu_list_entry(gpointer data, gpointer user_data)
> +{
> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data));
> +    int len =3D strlen(typename) - strlen(RX_CPU_TYPE_SUFFIX);
> +
> +    qemu_printf("%.*s\n", len, typename);
> +}
> +
> +void rx_cpu_list(void)
> +{
> +    GSList *list;
> +    list =3D object_class_get_list_sorted(TYPE_RX_CPU, false);
> +    g_slist_foreach(list, rx_cpu_list_entry, NULL);
> +    g_slist_free(list);
> +}
> +
> +static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
> +{
> +    ObjectClass *oc;
> +    char *typename;
> +
> +    oc =3D object_class_by_name(cpu_model);
> +    if (oc !=3D NULL && object_class_dynamic_cast(oc, TYPE_RX_CPU) !=3D =
NULL &&
> +        !object_class_is_abstract(oc)) {
> +        return oc;
> +    }
> +
> +    typename =3D g_strdup_printf(RX_CPU_TYPE_NAME("%s"), cpu_model);
> +    oc =3D object_class_by_name(typename);
> +    if (oc !=3D NULL && object_class_is_abstract(oc)) {
> +        oc =3D NULL;
> +    }
> +    g_free(typename);
> +
> +    if (!oc) {
> +        /* default to rx62n */
> +        oc =3D object_class_by_name(TYPE_RX62N_CPU);
> +    }
please address comments made on v19 version of the patch
and reply with fixed v21 here (assuming it doesn't break follow up patches)

> +    return oc;
> +}
> +
[...]


