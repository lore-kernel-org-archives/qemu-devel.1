Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576AEC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2542720720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjbQIga7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2542720720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04Es-000664-Bp
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j04Cc-0002Hd-2r
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j04CX-0008Ns-1d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:01:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j04CU-0008L7-6M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581084101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoDS1or+vhNSfw1HUju5r2RTd90BR8aIipjKbTeKoug=;
 b=YjbQIga7xpmNZt2thNb3owqxZWo81MG5FFiF8ERFDauX0v67rkX4nlglrOZigurn5LhtbQ
 +h/XMPnY0V2DsOeoz08c8t+TsIITOhVOeFmMJ3gTbEHiSqn4g5EEPu8QwAt7Uybm71xkEb
 fcsb/GLp7LzeHQxeGiifd/VOAHttZB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-A82EdqvvMTaKn2x-ZKYqlw-1; Fri, 07 Feb 2020 09:01:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29FB280256F;
 Fri,  7 Feb 2020 14:01:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A652790D7;
 Fri,  7 Feb 2020 14:01:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8002C11386A7; Fri,  7 Feb 2020 15:01:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/3] MAINTAINERS: Cover qapi/block{-core}.json in 'Block
 layer core' section
References: <20200207103012.27049-1-philmd@redhat.com>
 <20200207103012.27049-3-philmd@redhat.com>
Date: Fri, 07 Feb 2020 15:01:13 +0100
In-Reply-To: <20200207103012.27049-3-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 7 Feb 2020 11:30:11
 +0100")
Message-ID: <87blqaqyxi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: A82EdqvvMTaKn2x-ZKYqlw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> List this file in the proper section, so maintainers get
> notified when it is modified.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 903831e0a4..e269e9092c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1842,6 +1842,8 @@ S: Supported
   Block layer core
   M: Kevin Wolf <kwolf@redhat.com>
   M: Max Reitz <mreitz@redhat.com>
   L: qemu-block@nongnu.org
   S: Supported
>  F: block*
>  F: block/
>  F: hw/block/
> +F: qapi/block.json
> +F: qapi/block-core.json
>  F: include/block/
>  F: qemu-img*
>  F: docs/interop/qemu-img.rst

This is in addition to

    Block QAPI, monitor, command line
    M: Markus Armbruster <armbru@redhat.com>
    S: Supported
    F: blockdev.c
    F: block/qapi.c
    F: qapi/block*.json
    F: qapi/transaction.json
    T: git https://repo.or.cz/qemu/armbru.git block-next

I'm not sure this section makes much sense anymore.

Should qapi/transaction.json also be added to "Block layer core"?  Or
should it go into John's section "Block Jobs"?


