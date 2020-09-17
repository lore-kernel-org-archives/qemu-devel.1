Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CFAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8712072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8712072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItwV-0007zV-1d
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kItul-0006Zj-Ei
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:25:31 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:33945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kItuh-0003dj-RG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:25:31 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.237])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id A61D65C1DF62;
 Thu, 17 Sep 2020 15:25:24 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 17 Sep
 2020 15:25:24 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00464c4044d-e763-4534-ac90-23428163af54,
 CCC0D77BD3F1F8C36E09B026C91493862201CFF2) smtp.auth=groug@kaod.org
Date: Thu, 17 Sep 2020 15:25:23 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] qom: Clean up object_property_get_enum()'s error value
Message-ID: <20200917152523.0f1b8900@bahia.lan>
In-Reply-To: <20200917125540.597786-2-armbru@redhat.com>
References: <20200917125540.597786-1-armbru@redhat.com>
 <20200917125540.597786-2-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 38e7bd24-37c1-4693-b8ac-d2046fec639d
X-Ovh-Tracer-Id: 7188870907993561507
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegvhhgrsghkohhsthesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 14:55:39 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> object_property_get_enum() is the only object_property_FOO() that is
> documented to return an undefined value on error.  It does no such
> thing, actually: it returns 0 on some errors, and -1 on others.
> 
> Needlessly complicated.  Always return -1 on error, and adjust the
> contract.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/qom/object.h       | 6 +++---
>  qom/object.c               | 6 +++---
>  tests/check-qom-proplist.c | 2 ++
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 056f67ab3b..f75547a3fe 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1687,9 +1687,9 @@ uint64_t object_property_get_uint(Object *obj, const char *name,
>   * @typename: the name of the enum data type
>   * @errp: returns an error if this function fails
>   *
> - * Returns: the value of the property, converted to an integer, or
> - * undefined if an error occurs (including when the property value is not
> - * an enum).
> + * Returns: the value of the property, converted to an integer (which
> + * can't be negative), or -1 on error (including when the property
> + * value is not an enum).
>   */
>  int object_property_get_enum(Object *obj, const char *name,
>                               const char *typename, Error **errp);
> diff --git a/qom/object.c b/qom/object.c
> index 387efb25eb..cecad35b99 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1564,21 +1564,21 @@ int object_property_get_enum(Object *obj, const char *name,
>      EnumProperty *enumprop;
>  
>      if (prop == NULL) {
> -        return 0;
> +        return -1;
>      }
>  
>      if (!g_str_equal(prop->type, typename)) {
>          error_setg(errp, "Property %s on %s is not '%s' enum type",
>                     name, object_class_get_name(
>                         object_get_class(obj)), typename);
> -        return 0;
> +        return -1;
>      }
>  
>      enumprop = prop->opaque;
>  
>      str = object_property_get_str(obj, name, errp);
>      if (!str) {
> -        return 0;
> +        return -1;
>      }
>  
>      ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 1571606c1c..1b76581980 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -491,6 +491,7 @@ static void test_dummy_getenum(void)
>                                     "av",
>                                     "BadAnimal",
>                                     &err);
> +    g_assert(val == -1);
>      error_free_or_abort(&err);
>  
>      /* A non-enum property name */
> @@ -498,6 +499,7 @@ static void test_dummy_getenum(void)
>                                     "iv",
>                                     "DummyAnimal",
>                                     &err);
> +    g_assert(val == -1);
>      error_free_or_abort(&err);
>  
>      object_unparent(OBJECT(dobj));


