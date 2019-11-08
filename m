Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD1C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA462178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7EjgwHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA462178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1lR-0003nj-9r
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT1ka-00034c-D4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT1kZ-00083H-Ak
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:44:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT1kZ-0007xi-6h
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573209858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6g7WQdtD2e4KIPQF/Bx1/zBWvK3hoLeP+/E+MpLsTjo=;
 b=K7EjgwHVLwSgVr87i3QNU4edviOuFzq6R7ap1gSwWU8YZBlIc+m/tCjxiTbakqcr46eoEi
 y/Jv4vIZ4FTUCQnx4UGkeLxtjMCxHQkUv9dFVdcEhOtIYQMxW/SV25gJCmSsd1QZKy8byj
 jKMxGGjCliEMGx0CqM5WM49vfEN3bGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-kC39y2NeOEeWsTHj_2tg8w-1; Fri, 08 Nov 2019 05:44:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7909107ACC3
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3639426DF1;
 Fri,  8 Nov 2019 10:44:11 +0000 (UTC)
Subject: Re: [qemu-web PATCH] documentation: link to nightly documentation
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191108100526.401847-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <77573e2e-2508-9386-89b8-d44b9e7f2ade@redhat.com>
Date: Fri, 8 Nov 2019 11:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108100526.401847-1-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kC39y2NeOEeWsTHj_2tg8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 11.05, Stefan Hajnoczi wrote:
> Link to the documentation built from qemu.git/master once a day.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This depends on qemu.git "[PATCH 0/3] docs: build an index page for the
> HTML docs".  We need that in order to build index.html.
>=20
>   documentation.md | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/documentation.md b/documentation.md
> index f4ef9f4..662750c 100644
> --- a/documentation.md
> +++ b/documentation.md
> @@ -3,6 +3,8 @@ title: QEMU documentation
>   permalink: /documentation/
>   ---
>  =20
> +The latest development version documentation is available [here](https:/=
/wiki.qemu.org/docs/index.html).

Why are we using wiki.qemu.org here? Generated docs are not part of the=20
Wiki, so this sounds confusing to me... Shouldn't this put somewhere on=20
the main www.qemu.org domain instead?

  Thomas


