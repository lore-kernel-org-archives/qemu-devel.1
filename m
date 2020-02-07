Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBDAC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8DE221741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3LmUNOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DE221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izzMN-0007ZJ-W6
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izzLi-00078L-MA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izzLg-0003SW-Ox
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:50:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60759
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izzLg-0003RK-KQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581065451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXBZMEFBSosf4xLzlVuuDj7a8A8RrfJMAhVBws1w5tA=;
 b=E3LmUNOVxkfRgnMXdxGaxrCjc6+yITCr3LQ0ju4cMZA7UfmOYTEgM3Gyz7iFkNDCkf2JuC
 yGU32LpSArNFx30RvL+HWlYskSQAN/inlziiyzDRbpxzMmi1uTVCB/mx9HTz+RSaOOX2Yq
 r9yL/9JcUuS+tIUCQ34EPhcDCdx8fcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-ATn5YG0NMCyJNOEBakkqpw-1; Fri, 07 Feb 2020 03:50:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF154801E76;
 Fri,  7 Feb 2020 08:50:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 987CD87B00;
 Fri,  7 Feb 2020 08:50:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29C5711386A7; Fri,  7 Feb 2020 09:50:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 07/29] qapi/block-core.json: Use literal block for ascii
 art
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-8-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 09:50:40 +0100
In-Reply-To: <20200206173040.17337-8-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:18 +0000")
Message-ID: <87tv42u6fz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ATn5YG0NMCyJNOEBakkqpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

> The ascii-art graph in the BlockLatencyHistogramInfo
> documentation doesn't render correctly in either the HTML
> or the manpage output, because in both cases the whitespace
> is collapsed.

Plain text and PDF output is just as bad.  Suggest "doesn't render
correctly, because the whitespace is collapsed".

> Use the '|' format that emits a literal 'example' block
> so the graph is displayed correctly.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ef94a296868..372f35ee5f0 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -550,13 +550,13 @@
>  #        For the example above, @bins may be something like [3, 1, 5, 2]=
,
>  #        and corresponding histogram looks like:
>  #
> -#        5|           *
> -#        4|           *
> -#        3| *         *
> -#        2| *         *    *
> -#        1| *    *    *    *
> -#         +------------------
> -#             10   50   100
> +# |       5|           *
> +# |       4|           *
> +# |       3| *         *
> +# |       2| *         *    *
> +# |       1| *    *    *    *
> +# |        +------------------
> +# |            10   50   100

Wow, we're acquiring a second use of the '|' feature.

It's actually broken, because the doc generator puts each | line in its
own @example environment.

Doesn't really matter, because PATCH 26 replaces it by rST markup that
actually works.  A note in the commit message could make sense, though.

But instead of making it differently broken until PATCH 26 fixes it for
good, I'd simply leave it broken until then :)

If you decide to keep the patch: can we keep the table aligned with the
preceding paragraph?  Like this:

   # |      5|           *
   # |      4|           *
   # |      3| *         *
   # |      2| *         *    *
   # |      1| *    *    *    *
   # |       +------------------
   # |           10   50   100

>  #
>  # Since: 4.0
>  ##


