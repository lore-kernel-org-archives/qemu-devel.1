Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D086EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370582072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370582072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIu2b-0005gT-9V
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kIu0X-0003iL-Ci
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:31:30 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:51579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kIu0V-0004hw-0o
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:31:29 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.41])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id A23AE62AB6D2;
 Thu, 17 Sep 2020 15:31:22 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 17 Sep
 2020 15:31:22 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0046c5362cc-fc10-439c-84b0-668675f15c93,
 CCC0D77BD3F1F8C36E09B026C91493862201CFF2) smtp.auth=groug@kaod.org
Date: Thu, 17 Sep 2020 15:31:21 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] qom: Correct error values in two contracts
Message-ID: <20200917153121.66a4f2f9@bahia.lan>
In-Reply-To: <20200917125540.597786-3-armbru@redhat.com>
References: <20200917125540.597786-1-armbru@redhat.com>
 <20200917125540.597786-3-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: ac1e7d9e-af97-40ad-8cd5-ebbfa15896c5
X-Ovh-Tracer-Id: 7289638947077921187
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdeggdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegvhhgrsghkohhsthesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 09:31:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 17 Sep 2020 14:55:40 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> object_property_get_bool()'s contract claims it returns NULL on error.
> Pasto; it returns false.
> 
> object_property_get_int()'s contract claims it returns "negative".  It
> actually returns -1.  All the other object_property_get_FOO()
> contracts specify the exact error value, so do the same here.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/qom/object.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index f75547a3fe..d0a3332c1f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1624,7 +1624,7 @@ bool object_property_set_bool(Object *obj, const char *name,
>   * @name: the name of the property
>   * @errp: returns an error if this function fails
>   *
> - * Returns: the value of the property, converted to a boolean, or NULL if
> + * Returns: the value of the property, converted to a boolean, or false if
>   * an error occurs (including when the property value is not a bool).
>   */
>  bool object_property_get_bool(Object *obj, const char *name,
> @@ -1649,7 +1649,7 @@ bool object_property_set_int(Object *obj, const char *name,
>   * @name: the name of the property
>   * @errp: returns an error if this function fails
>   *
> - * Returns: the value of the property, converted to an integer, or negative if
> + * Returns: the value of the property, converted to an integer, or -1 if
>   * an error occurs (including when the property value is not an integer).
>   */
>  int64_t object_property_get_int(Object *obj, const char *name,


