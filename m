Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3CDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125B420775
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125B420775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joT8U-00007U-6e
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1joT75-0006o7-Ab
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:44:27 -0400
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:38102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1joT6y-0004yj-UC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 10:44:23 -0400
Received: from player770.ha.ovh.net (unknown [10.110.103.168])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 1EAE01CCE3B
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 16:44:09 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 1B09C13D64279;
 Thu, 25 Jun 2020 14:44:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002dd72e5f9-0eaf-4382-9416-e24206c09db1,A235D761C50461097149B413D00F49C422530979)
 smtp.auth=groug@kaod.org
Date: Thu, 25 Jun 2020 16:44:00 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 01/46] error: Improve examples in error.h's big comment
Message-ID: <20200625164400.5f63e74d@bahia.lan>
In-Reply-To: <20200624164344.3778251-2-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-2-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13274641379156859278
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekledgkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.127.22; envelope-from=groug@kaod.org;
 helo=1.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 10:44:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 18:42:59 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Show errp instead of &err where &err is actually unusual.  Add a
> missing declaration.  Add a second error pileup example.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/error.h | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index ad5b6e896d..1a5ea25e12 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -16,15 +16,15 @@
>   * Error reporting system loosely patterned after Glib's GError.
>   *
>   * Create an error:
> - *     error_setg(&err, "situation normal, all fouled up");
> + *     error_setg(errp, "situation normal, all fouled up");
>   *
>   * Create an error and add additional explanation:
> - *     error_setg(&err, "invalid quark");
> - *     error_append_hint(&err, "Valid quarks are up, down, strange, "
> + *     error_setg(errp, "invalid quark");
> + *     error_append_hint(errp, "Valid quarks are up, down, strange, "
>   *                       "charm, top, bottom.\n");
>   *
>   * Do *not* contract this to
> - *     error_setg(&err, "invalid quark\n"
> + *     error_setg(errp, "invalid quark\n" // WRONG!
>   *                "Valid quarks are up, down, strange, charm, top, bottom.");
>   *
>   * Report an error to the current monitor if we have one, else stderr:
> @@ -108,12 +108,23 @@
>   *     }
>   *
>   * Do *not* "optimize" this to
> + *     Error *err = NULL;
>   *     foo(arg, &err);
>   *     bar(arg, &err); // WRONG!
>   *     if (err) {
>   *         handle the error...
>   *     }
>   * because this may pass a non-null err to bar().
> + *
> + * Likewise, do *not*
> + *     Error *err = NULL;
> + *     if (cond1) {
> + *         error_setg(err, ...);

s/err/&err

> + *     }
> + *     if (cond2) {
> + *         error_setg(err, ...); // WRONG!

ditto

With that fixed:

Reviewed-by: Greg Kurz <groug@kaod.org>

> + *     }
> + * because this may pass a non-null err to error_setg().
>   */
>  
>  #ifndef ERROR_H


