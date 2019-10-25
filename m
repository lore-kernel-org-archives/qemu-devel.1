Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FA7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B49421872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWZI4uDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B49421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO91H-0004pv-AF
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iO8Td-0002CB-TN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 18:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iO8Tc-0006kv-Bo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 18:54:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iO8Tc-0006km-8w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 18:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572044075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhJBZS7GjyHFoyCOLiylFHhrUbvoBA3BnjjH89QqH9E=;
 b=jWZI4uDidkx9hgOytjrYLMttPrJexH7JEIjyzFB5THgm4O2REM2tRgbHjxFdK1+JGsWAVj
 ArwbpzoC7u/X7gvVkQVnemteoo50UaJWLa2PFHQQ0uCLS1vMnmXMDsz4JNKirhdzTNR7G5
 NbIvpErjnjuoiqjw3U+Jfy5uAG/Ug/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-vq2WYIvZMX-a6vB-um0t1A-1; Fri, 25 Oct 2019 18:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BABF4100551E;
 Fri, 25 Oct 2019 22:54:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-26.ams2.redhat.com
 [10.36.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 319D3600CD;
 Fri, 25 Oct 2019 22:54:27 +0000 (UTC)
Subject: Re: [PATCH] buildfix: update texinfo menu
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20191023101956.19120-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <837b9dc6-1292-c182-8a66-408f0ffe6e0c@redhat.com>
Date: Sat, 26 Oct 2019 00:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023101956.19120-1-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vq2WYIvZMX-a6vB-um0t1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 12:19, Gerd Hoffmann wrote:
> Build error message:
> qemu-doc.texi:34: node `Top' lacks menu item for `Recently removed featur=
es' despite being its Up target
>=20
> Fixes: 3264ffced3d0 ("dirty-bitmaps: remove deprecated autoload parameter=
")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  qemu-doc.texi | 1 +
>  1 file changed, 1 insertion(+)
>=20
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
>=20

Tested-by: Laszlo Ersek <lersek@redhat.com>

(Applied it on top of ee70fc26a561, and now the tree builds.)

Thanks!
Laszlo


