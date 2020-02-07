Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBCC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9E720838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoetbI8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9E720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06ui-0000wR-QX
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j06u2-00006f-LS
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j06u1-0002lH-GW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:54:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j06u1-0002i5-Bt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581094488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uto9m0BK9EtH6gbRLss570VwBoLLJtvQwBixpElY1iM=;
 b=KoetbI8swdcC1neBrEkAdZeJQH0MqICifPNzh6UO233jkzBIMpT3t1N1tE9gfSxcnYMfwP
 Wput1o4Jw5frln5TZnrQfYS4kGNCeC2bNmumZgDuOTcWMecTqVw14GolA6nIZbol3Kfqfq
 EN/DMiToOGf/QgdITvPqQgNuNyOQN1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-XkYn6fx3Op2WWhZ8CD7mVQ-1; Fri, 07 Feb 2020 11:54:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D00E8010F5;
 Fri,  7 Feb 2020 16:54:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CCE72654D;
 Fri,  7 Feb 2020 16:54:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B012611386A7; Fri,  7 Feb 2020 17:54:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 18/29] qapi/migration.json: Replace _this_ with *this*
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-19-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 17:54:37 +0100
In-Reply-To: <20200206173040.17337-19-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:29 +0000")
Message-ID: <87a75unxrm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XkYn6fx3Op2WWhZ8CD7mVQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
> we use _this_ inline markup to mean italics.

Nitpick: _this_ does not mean italics, it means emphasis.  See
qapi-code-gen.txt section "Documentation markup".  doc.py maps it to
@emph{this}, which Texinfo commonly renders in italics when the output
format supports that.

>                                               rST doesn't recognize
> that markup and emits literal underscores.  Switch to *this* instead;
> for the texinfo output this will be bold, and for rST it will go back
> to being italics.

Likewise, *this* doesn't mean italics in rST, it means emphasis.

With the Texinfo doc pipeline, the patch changes the markup of this from
emphasis to strong.

The change will be undone when we switch to rST, where it means emphasis
again.

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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

I don't like the commit message, but that's not enough to withhold my
Reviewed-by: Markus Armbruster <armbru@redhat.com>


