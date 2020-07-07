Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50733C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF25206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF25206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jstV3-00017q-Cw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jstUV-0000iC-SF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:42:55 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:59459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jstUT-0007Xk-NW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:42:55 -0400
Received: from player786.ha.ovh.net (unknown [10.110.208.44])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 184CA21D8D1
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 21:42:50 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id A4B39144DB712;
 Tue,  7 Jul 2020 19:42:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002e4195d9f-1e2e-42f1-adfc-2102b706d2fb,E152094F47616500A3A802F2EB970733BF761B34)
 smtp.auth=groug@kaod.org
Date: Tue, 7 Jul 2020 21:42:38 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 02/45] error: Improve error.h's big comment
Message-ID: <20200707214238.15ac8fc4@bahia.lan>
In-Reply-To: <20200707160613.848843-3-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
 <20200707160613.848843-3-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15004305108617042318
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehgddufeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.39.161; envelope-from=groug@kaod.org;
 helo=15.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 15:42:51
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

On Tue,  7 Jul 2020 18:05:30 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Add headlines to the big comment.
> 
> Explain examples for NULL, &error_abort and &error_fatal argument
> better.
> 
> Tweak rationale for error_propagate_prepend().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/qapi/error.h | 51 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 15 deletions(-)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index e8960eaad5..6d079c58b7 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -15,6 +15,8 @@
>  /*
>   * Error reporting system loosely patterned after Glib's GError.
>   *
> + * = Creating errors =
> + *
>   * Create an error:
>   *     error_setg(&err, "situation normal, all fouled up");
>   *
> @@ -27,6 +29,8 @@
>   *     error_setg(&err, "invalid quark\n" // WRONG!
>   *                "Valid quarks are up, down, strange, charm, top, bottom.");
>   *
> + * = Reporting and destroying errors =
> + *
>   * Report an error to the current monitor if we have one, else stderr:
>   *     error_report_err(err);
>   * This frees the error object.
> @@ -40,6 +44,30 @@
>   *     error_free(err);
>   * Note that this loses hints added with error_append_hint().
>   *
> + * Call a function ignoring errors:
> + *     foo(arg, NULL);
> + * This is more concise than
> + *     Error *err = NULL;
> + *     foo(arg, &err);
> + *     error_free(err); // don't do this
> + *
> + * Call a function aborting on errors:
> + *     foo(arg, &error_abort);
> + * This is more concise and fails more nicely than
> + *     Error *err = NULL;
> + *     foo(arg, &err);
> + *     assert(!err); // don't do this
> + *
> + * Call a function treating errors as fatal:
> + *     foo(arg, &error_fatal);
> + * This is more concise than
> + *     Error *err = NULL;
> + *     foo(arg, &err);
> + *     if (err) { // don't do this
> + *         error_report_err(err);
> + *         exit(1);
> + *     }
> + *
>   * Handle an error without reporting it (just for completeness):
>   *     error_free(err);
>   *
> @@ -47,6 +75,11 @@
>   * reporting it (primarily useful in testsuites):
>   *     error_free_or_abort(&err);
>   *
> + * = Passing errors around =
> + *
> + * Errors get passed to the caller through the conventional @errp
> + * parameter.
> + *
>   * Pass an existing error to the caller:
>   *     error_propagate(errp, err);
>   * where Error **errp is a parameter, by convention the last one.
> @@ -54,11 +87,10 @@
>   * Pass an existing error to the caller with the message modified:
>   *     error_propagate_prepend(errp, err,
>   *                             "Could not frobnicate '%s': ", name);
> - *
> - * Avoid
> - *     error_propagate(errp, err);
> + * This is more concise than
> + *     error_propagate(errp, err); // don't do this
>   *     error_prepend(errp, "Could not frobnicate '%s': ", name);
> - * because this fails to prepend when @errp is &error_fatal.
> + * and works even when @errp is &error_fatal.
>   *
>   * Create a new error and pass it to the caller:
>   *     error_setg(errp, "situation normal, all fouled up");
> @@ -70,15 +102,6 @@
>   *         handle the error...
>   *     }
>   *
> - * Call a function ignoring errors:
> - *     foo(arg, NULL);
> - *
> - * Call a function aborting on errors:
> - *     foo(arg, &error_abort);
> - *
> - * Call a function treating errors as fatal:
> - *     foo(arg, &error_fatal);
> - *
>   * Receive an error and pass it on to the caller:
>   *     Error *err = NULL;
>   *     foo(arg, &err);
> @@ -86,8 +109,6 @@
>   *         handle the error...
>   *         error_propagate(errp, err);
>   *     }
> - * where Error **errp is a parameter, by convention the last one.
> - *
>   * Do *not* "optimize" this to
>   *     foo(arg, errp);
>   *     if (*errp) { // WRONG!


