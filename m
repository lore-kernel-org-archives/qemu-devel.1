Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B78C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864BA2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864BA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOwQ-0002ZM-Fb
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHOul-0001PV-BR
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHOui-0005K4-JC
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHOui-0005J9-BB; Mon, 07 Oct 2019 05:02:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 935D086663;
 Mon,  7 Oct 2019 09:02:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FCFA5C1D4;
 Mon,  7 Oct 2019 09:02:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 70FCD1138648; Mon,  7 Oct 2019 11:02:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] xive: Make some device types not user creatable
References: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
Date: Mon, 07 Oct 2019 11:02:26 +0200
In-Reply-To: <157017473006.331610.2983143972519884544.stgit@bahia.lan> (Greg
 Kurz's message of "Fri, 04 Oct 2019 09:38:50 +0200")
Message-ID: <87lftxhqsd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 07 Oct 2019 09:02:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> Some device types of the XIVE model are exposed to the QEMU command
> line:
>
> $ ppc64-softmmu/qemu-system-ppc64 -device help | grep xive
> name "xive-end-source", desc "XIVE END Source"
> name "xive-source", desc "XIVE Interrupt Source"
> name "xive-tctx", desc "XIVE Interrupt Thread Context"
>
> These are internal devices that shouldn't be instantiable by the
> user. By the way, they can't be because their respective realize
> functions expect link properties that can't be set from the command
> line:
>
> qemu-system-ppc64: -device xive-source: required link 'xive' not found:
>  Property '.xive' not found
> qemu-system-ppc64: -device xive-end-source: required link 'xive' not found:
>  Property '.xive' not found
> qemu-system-ppc64: -device xive-tctx: required link 'cpu' not found:
>  Property '.cpu' not found
>
> Hide them by setting dc->user_creatable to false in their respective
> class init functions.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xive.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 29df06df1136..6c54a35fd4bb 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -670,6 +670,7 @@ static void xive_tctx_class_init(ObjectClass *klass, void *data)
>      dc->realize = xive_tctx_realize;
>      dc->unrealize = xive_tctx_unrealize;
>      dc->vmsd = &vmstate_xive_tctx;
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo xive_tctx_info = {
> @@ -1118,6 +1119,7 @@ static void xive_source_class_init(ObjectClass *klass, void *data)
>      dc->props   = xive_source_properties;
>      dc->realize = xive_source_realize;
>      dc->vmsd    = &vmstate_xive_source;
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo xive_source_info = {
> @@ -1853,6 +1855,7 @@ static void xive_end_source_class_init(ObjectClass *klass, void *data)
>      dc->desc    = "XIVE END Source";
>      dc->props   = xive_end_source_properties;
>      dc->realize = xive_end_source_realize;
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo xive_end_source_info = {

These all need a comment like the existing ->user_creatable = false
have.

Your commit message mentions link properties.  Based on that:

    /*
     * Reason: link property 'NAME-OF-PROP' needs to be wired up.
     */

Rather minimal, though.  Several existing similar cases are a bit more
specific, which is nice:

    /*
     * Reason: part of WHATEVER, needs to be wired up by FUNCTION().
     */

or if there is or could be more than one FUNCTION():

    /*
     * Reason: part of WHATEVER, needs to be wired up, e.g. by FUNCTION().
     */

David queued your patch already.  If it goes into master without such
comments, please post them as a follow-up patch.

