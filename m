Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E396CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66F2206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66F2206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTgW-00045B-TQ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1joTd7-0008VZ-Mg
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:17:33 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:38758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1joTd5-0006aa-D6
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:17:33 -0400
Received: from player789.ha.ovh.net (unknown [10.110.115.5])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 80B97137724
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 17:17:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id D030713C8999A;
 Thu, 25 Jun 2020 15:17:20 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004ed36285c-b12b-4d8b-abfc-7881e5cb4dde,A235D761C50461097149B413D00F49C422530979)
 smtp.auth=groug@kaod.org
Date: Thu, 25 Jun 2020 17:17:18 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/46] error: Document Error API usage rules
Message-ID: <20200625171718.528f8584@bahia.lan>
In-Reply-To: <20200624164344.3778251-3-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-3-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13837309857001871758
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekledgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueekjeekiefffedtveeukedvteejgeeivefhgfejgfdtleduvdfgfeelkeeuveeunecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.61.149; envelope-from=groug@kaod.org;
 helo=7.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 11:17:28
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

On Wed, 24 Jun 2020 18:43:00 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> This merely codifies existing practice, with one exception: the rule
> advising against returning void, where existing practice is mixed.
>=20
> When the Error API was created, we adopted the (unwritten) rule to
> return void when the function returns no useful value on success,
> unlike GError, which recommends to return true on success and false on
> error then.
>=20
> When a function returns a distinct error value, say false, a checked
> call that passes the error up looks like
>=20
>     if (!frobnicate(..., errp)) {
>         handle the error...
>     }
>=20
> When it returns void, we need
>=20
>     Error *err =3D NULL;
>=20
>     frobnicate(..., &err);
>     if (err) {
>         handle the error...
>         error_propagate(errp, err);
>     }
>=20
> Not only is this more verbose, it also creates an Error object even
> when @errp is null, &error_abort or &error_fatal.
>=20
> People got tired of the additional boilerplate, and started to ignore
> the unwritten rule.  The result is confusion among developers about
> the preferred usage.
>=20

This confusion is reinforced by the fact that the standard pattern:

    error_setg(errp, ...);
    error_append_hint(errp, ...);

doesn't work when errp is &error_fatal, which is a typical case of
an invalid command line argument, where it is valuable to suggest
something sensible to the user but error_setg() exits before we
could do so.

Fortunately, Vladimir's work will address that and eliminate the
temptation to workaround the issue with more boilerplate :)

> The written rule will hopefully reduce the confusion.
>=20
> The remainder of this series will update a substantial amount of code
> to honor the rule.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/qapi/error.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 1a5ea25e12..c3d84d610a 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -15,6 +15,32 @@
>  /*
>   * Error reporting system loosely patterned after Glib's GError.
>   *
> + * Rules:
> + *
> + * - Functions that use Error to report errors have an Error **errp
> + *   parameter.  It should be the last parameter, except for functions
> + *   taking variable arguments.
> + *
> + * - You may pass NULL to not receive the error, &error_abort to abort
> + *   on error, &error_fatal to exit(1) on error, or a pointer to a
> + *   variable containing NULL to receive the error.
> + *
> + * - The value of @errp should not affect control flow.
> + *
> + * - On success, the function should not use @errp.  On failure, it
> + *   should set a new error, e.g. with error_setg(errp, ...), or
> + *   propagate an existing one, e.g. with error_propagate(errp, ...).
> + *
> + * - Whenever practical, also return a value that indicates success /
> + *   failure.  This can make the error checking more concise, and can
> + *   avoid useless error object creation and destruction.  Note that
> + *   we still have many functions returning void.  We recommend
> + *   =E2=80=A2 bool-valued functions return true on success / false on f=
ailure,
> + *   =E2=80=A2 pointer-valued functions return non-null / null pointer, =
and
> + *   =E2=80=A2 integer-valued functions return non-negative / negative.
> + *
> + * How to:
> + *
>   * Create an error:
>   *     error_setg(errp, "situation normal, all fouled up");
>   *


