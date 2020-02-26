Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC83C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC0C21927
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC0C21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6w91-0004ri-3P
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6w8E-0003tf-Qd
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6w8D-00026H-E8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:49:42 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:49646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6w8D-00024F-7C
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:49:41 -0500
Received: from player778.ha.ovh.net (unknown [10.110.115.5])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id AFAD2935BD
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 13:49:37 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 3FC9EFCE242F;
 Wed, 26 Feb 2020 12:49:30 +0000 (UTC)
Date: Wed, 26 Feb 2020 13:49:27 +0100
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH] spapr: Fix Coverity warning while validating nvdimm
 options
Message-ID: <20200226134927.3cc5b6fb@bahia.home>
In-Reply-To: <158271897341.44994.2741557659975232894.stgit@lep8c.aus.stglabs.ibm.com>
References: <158271897341.44994.2741557659975232894.stgit@lep8c.aus.stglabs.ibm.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7593350447057574229
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.227
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
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 06:10:38 -0600
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> Fixes Coverity issue,
>       CID 1419883:  Error handling issues  (CHECKED_RETURN)
>            Calling "qemu_uuid_parse" without checking return value
> 
> nvdimm_set_uuid() already verifies if the user provided uuid is valid or
> not. So, need to check for the validity during pre-plug validation again.
> 

Ok but since nvdimm_set_uuid() fills nvdimm->uuid why do you need to parse
the string again in the first place ?

> As this a false positive in this case, assert if not valid to be safe.
> 
> Reported-by: Coverity (CID 1419883)
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  hw/ppc/spapr_nvdimm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> index 74eeb8bb74..051727536e 100644
> --- a/hw/ppc/spapr_nvdimm.c
> +++ b/hw/ppc/spapr_nvdimm.c
> @@ -44,7 +44,7 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
>      }
>  
>      uuidstr = object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP, NULL);
> -    qemu_uuid_parse(uuidstr, &uuid);
> +    g_assert(qemu_uuid_parse(uuidstr, &uuid) == 0);

Like assert(), g_assert() is a macro that can be turned into a nop at
compile time:

#ifdef G_DISABLE_ASSERT
#define g_assert_not_reached()          G_STMT_START { (void) 0; } G_STMT_END
#define g_assert(expr)                  G_STMT_START { (void) 0; } G_STMT_END
#else /* !G_DISABLE_ASSERT */
#define g_assert_not_reached()          G_STMT_START { g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, NULL); } G_STMT_END
#define g_assert(expr)                  G_STMT_START { \
                                             if G_LIKELY (expr) ; else \
                                               g_assertion_message_expr (G_LOG_DOMAIN, __FILE__, __LINE__, G_STRFUNC, \
                                                                         #expr); \
                                        } G_STMT_END
#endif /* !G_DISABLE_ASSERT */

One should avoid putting expressions with side-effects in g_assert() because
the code may not be called at all if G_DISABLE_ASSERT is defined...

>      g_free(uuidstr);
>  
>      if (qemu_uuid_is_null(&uuid)) {

... and uuid would be uninitialized here :-\

If you need to use g_assert(), please do something like:

    ret = qemu_uuid_parse(uuidstr, &uuid);
    g_assert(!ret);

> 
> 


