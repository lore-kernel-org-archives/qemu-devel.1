Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59675C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FCA2187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE6qjg7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FCA2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2c4y-0000Jy-Da
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2c4E-0007tS-3r
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2c4C-0004Aw-0c
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:35:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2c4B-0004AV-T8
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581690939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouWW8HXh3m+GIL+1Zdj/JLLr6O2RA7928vMQsPsVAc8=;
 b=KE6qjg7DP0YmXoZj3f/lLadIaAIy+g9RvtvLshmZ98cTWGyeD11zEx3rLggHymqde6Qop0
 h3kmDkg1tCMGPvZVh10uhzixfUV8MuCM+ye4qYOltCYmsi0mV2mFBOAEeHbUr20FMCu19h
 HxSzMot7dc3sQBKSdFmqevRZ0HHgu/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Xg_LjFujMa6m9kIV2YV_Nw-1; Fri, 14 Feb 2020 09:35:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E45C1902EA9;
 Fri, 14 Feb 2020 14:35:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56DE286814;
 Fri, 14 Feb 2020 14:35:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02CEE11385C9; Fri, 14 Feb 2020 15:35:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 17/30] qapi/migration.json: Replace _this_ with *this*
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-18-peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 15:35:28 +0100
In-Reply-To: <20200213175647.17628-18-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 13 Feb 2020 17:56:34 +0000")
Message-ID: <874kvttexb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Xg_LjFujMa6m9kIV2YV_Nw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> The MigrationInfo::setup-time documentation is the only place where
> we use _this_ inline markup for emphasis, commonly rendered in
> italics.  rST doesn't recognize that markup and emits literal
> underscores.
>
> Switch to *this* instead.  Changes markup to strong emphasis with
> Texinfo, commonly rendered as bold.  With rST, it will go right back
> to emphasis / italics.
>
> rST also uses **this** for strong (commonly rendered bold) where
> Texinfo uses *this*. We have one place in the doc comments
> which uses strong/bold markup, in qapi/introspect.json:
>     Note: the QAPI schema is also used to help define *internal*
>
> When we switch to rST that will be rendered as emphasis / italics.
> Markus (who wrote that) thinks that using emphasis / italics
> there is an improvement, so we leave that markup alone.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> v1->v2: updated commit message. Paras 1 and 2 are from Markus;
> paras 3 and 4 are new, and mention a non-change agreed in
> the thread off the cover letter of the v1 patch series.

I appreciate your diligent notes here.  Thanks!

> ---
>  qapi/migration.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 11033b7a8e6..52f34299698 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -178,8 +178,8 @@
>  #                     expected downtime in milliseconds for the guest in=
 last walk
>  #                     of the dirty bitmap. (since 1.3)
>  #
> -# @setup-time: amount of setup time in milliseconds _before_ the
> -#              iterations begin but _after_ the QMP command is issued. T=
his is designed
> +# @setup-time: amount of setup time in milliseconds *before* the
> +#              iterations begin but *after* the QMP command is issued. T=
his is designed
>  #              to provide an accounting of any activities (such as RDMA =
pinning) which
>  #              may be expensive, but do not actually occur during the it=
erative
>  #              migration rounds themselves. (since 1.6)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


