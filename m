Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31814C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 19:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E842C206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 19:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bflEXksA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E842C206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iW3W0-0002M4-W7
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 14:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iW3V5-0001tB-Mx
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 14:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iW3V1-0000IP-LO
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 14:12:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iW3V1-0000HZ-BS
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 14:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573931563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGK0HYzgaZFAaJKVYFpuXmaFO24s3QOASrQOvmAo250=;
 b=bflEXksAaS619iWnC6jGvR6Q+/JN2QldIoFfhOBbmNC3+j/oSIIv/w7ZjSr31AtCyaHWqF
 +PHjwsT8z053P7riODi/3MSFFFAjw73ZBkTN24zylse+x0cJ5EQuPmL8JI92BwkskAnrT2
 swG3Ecgc6+PSPbw0woi3oEL635xghOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-TJwfwqXJOwqjy9u30OUatw-1; Sat, 16 Nov 2019 14:12:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE10802683;
 Sat, 16 Nov 2019 19:12:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-40.ams2.redhat.com
 [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9FBD5DA82;
 Sat, 16 Nov 2019 19:12:35 +0000 (UTC)
Subject: Re: [PATCH] buildfix: update texinfo menu
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191023101956.19120-1-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ba8b74e7-8c37-dc76-a77e-33448b698777@redhat.com>
Date: Sat, 16 Nov 2019 20:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023101956.19120-1-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TJwfwqXJOwqjy9u30OUatw-1
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

Can this patch be included in v4.2.0-rc2 please?

Thanks!
Laszlo


