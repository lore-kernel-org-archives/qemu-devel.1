Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4883CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA9720684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiTSvTtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA9720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYxX-0002lp-7y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNYwY-00014j-HL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNYwX-00047F-JP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:58:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNYwX-000470-G8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571907485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgj2kHCBhfIDMrtcNYT+KUTTqnro5jh/Ax+LK3eL7Bc=;
 b=AiTSvTtXQvYaYDY5btx7AX9/AqtSCtezws4fA1pH7QMVP1J44hpia74XwZ4/h40ktDVblK
 r5cA8s3uToINi6SFS3zlaGUlrhpYNF7AdIq/1HsMeS2OVi/vMgHxR1a4Q8/0l30Y9Df1Mg
 I/S80ZvE1b+/CwgJtwo/tyNxBew2RV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-JTeIz7qKOUmyyWix7KMF7A-1; Thu, 24 Oct 2019 04:57:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B85095E9;
 Thu, 24 Oct 2019 08:57:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2508362A8A;
 Thu, 24 Oct 2019 08:57:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C7021138619; Thu, 24 Oct 2019 10:57:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] buildfix: update texinfo menu
References: <20191023101956.19120-1-kraxel@redhat.com>
Date: Thu, 24 Oct 2019 10:57:52 +0200
In-Reply-To: <20191023101956.19120-1-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Wed, 23 Oct 2019 12:19:56 +0200")
Message-ID: <87ftjitt9r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: JTeIz7qKOUmyyWix7KMF7A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> Build error message:
> qemu-doc.texi:34: node `Top' lacks menu item for `Recently removed featur=
es' despite being its Up target
>
> Fixes: 3264ffced3d0 ("dirty-bitmaps: remove deprecated autoload parameter=
")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  qemu-doc.texi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 3c5022050f0f..3ddf5c0a6865 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -44,6 +44,7 @@
>  * Security::
>  * Implementation notes::
>  * Deprecated features::
> +* Recently removed features::
>  * Supported build platforms::
>  * License::
>  * Index::

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Cc'ing qemu-trivial.


