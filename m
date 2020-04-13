Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF9BC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B8A20732
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBcTYSSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B8A20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO3nb-00078U-ES
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 14:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jO3mr-0006hx-2q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jO3mp-0001L5-Mp
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:26:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jO3mp-0001KS-JS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586802382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjn8AyBY3aK5+UZ/LAxYooCbcmHwRwDb4g3tyyHQD8M=;
 b=EBcTYSSms1WWz8NmRdz6fsKmXTUVO8Yr9nmy47upOjHiPSVRe9L5con21sL/XOpGTPNq2v
 6ZdVmnCkQA5G5sqWDo0BaNRzt3JfdZ4Y/QN3fQ+YDpJIgQ2qK/Y9W2QbHyJRTrqGrSqRwe
 8TBvLA1Vf0+QfV3abBoHdCJIBU+qY6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-eIG1L0UDM0u52ncAmOc2Cw-1; Mon, 13 Apr 2020 14:26:20 -0400
X-MC-Unique: eIG1L0UDM0u52ncAmOc2Cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7ACB800D53;
 Mon, 13 Apr 2020 18:26:19 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B203799DFD;
 Mon, 13 Apr 2020 18:26:19 +0000 (UTC)
Subject: Re: [PATCH] .gitignore: include common build sub-directories
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200413162902.7985-1-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2c489489-f459-f029-029e-74bfbfc70e49@redhat.com>
Date: Mon, 13 Apr 2020 13:26:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200413162902.7985-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 11:29 AM, Alex Benn=C3=A9e wrote:
> As out-of-tree builds become more common (or rather building in a
> subdir) we can add a lot of load to "git ls-files" as it hunts down
> sub-directories that are irrelevant to the source tree. This is
> especially annoying if you have a prompt that attempts to summarise
> the current git status on command completion.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .gitignore | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/.gitignore b/.gitignore
> index 0c5af83aa74..7757dc08a08 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -141,6 +141,8 @@ cscope.*
>   tags
>   TAGS
>   docker-src.*
> +build
> +builds

Would 'build-*' be worth adding as well?

The idea makes sense to me (as I've already done the same in my=20
./git/info/exclude locally),
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


