Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC42CC3B198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774B7222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 12:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bg0WHPzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774B7222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38151 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2aTo-0006T6-Ms
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 07:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2aTG-0005uU-SO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2aTF-00020S-RT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:53:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2aTF-0001zu-Ne
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 07:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581684805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWTKVWHU5WeQD9v3RMsby/7fK1qZFDgBABCN8kPqwRk=;
 b=bg0WHPzXzI/F3q9Az9P+fCh/8o6KVxOq6DGOzO6hynlyY/MP0PSehgJh5dc42oOe84Lp/V
 itoayw27gLPStc3MRzhABtNMwBjh2rnlph1Ld7nqXc4Fhs/3lSr/U92bY3s9KfgQJmpWhp
 McntbNX3vkcd1O4WNxtr1vogGBwW6Bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-vhm97JeuOgyelQj_DmkZyQ-1; Fri, 14 Feb 2020 07:53:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DCC18017CC;
 Fri, 14 Feb 2020 12:53:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBE1A5C1C3;
 Fri, 14 Feb 2020 12:53:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5280211385C9; Fri, 14 Feb 2020 13:53:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 07/30] qapi/block-core.json: Use literal block for
 ascii art
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-8-peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 13:53:18 +0100
In-Reply-To: <20200213175647.17628-8-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 13 Feb 2020 17:56:24 +0000")
Message-ID: <87mu9lwcsh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: vhm97JeuOgyelQj_DmkZyQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> The ascii-art graph in the BlockLatencyHistogramInfo documentation
> doesn't render correctly, because the whitespace is collapsed.
>
> Use the '|' format that emits a literal 'example' block so the graph
> is displayed correctly.
>
> Strictly the texinfo generated is still wrong because each line
> goes into its own @example environment, but it renders better
> than what we had before.
>
> Fixing this rendering is a necessary prerequisite for the rST
> generator, which otherwise complains about the inconsistent
> indentation in the ascii-art graph.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: tweaked commit message, made graph still line up
> with preceding paragraph text
> ---
>  qapi/block-core.json | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ef94a296868..db9ca688d49 100644
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
> +# |      5|           *
> +# |      4|           *
> +# |      3| *         *
> +# |      2| *         *    *
> +# |      1| *    *    *    *
> +# |       +------------------
> +# |           10   50   100
>  #
>  # Since: 4.0
>  ##

Reviewed-by: Markus Armbruster <armbru@redhat.com>


