Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CF0C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7134A20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDeNafiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7134A20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBx9-00020R-Kh
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ipBwO-0001Jk-6R
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ipBwN-0003sN-99
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:04:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ipBwN-0003rk-3j
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578492246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=e8FzwxoryTE/H+15qOw4ZsXHen3CDk4268t+T3R0ZwQ=;
 b=HDeNafiP83+7ariUFiolUCMW6Pc89uN5gN0qdUxWe7B6uYh02tDfSeTA2Ki7Q75r8y/DGQ
 lSw7WsnA0GB6Q5J4kuqIpOGQkhMIOwBIoJPqGfcLWdUIKdOrPS2RjzST2WdNEWemThuPGC
 36HldlrWZVj3LidTvUYd3c5zi6SR4BA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-ra2pw_kkMyq-kqDBIQL8yw-1; Wed, 08 Jan 2020 09:04:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A458D801E6C
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 14:04:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-114.ams2.redhat.com [10.36.117.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAD5419C70;
 Wed,  8 Jan 2020 14:04:01 +0000 (UTC)
Subject: Re: [PATCH v2] tests: fix test-qga on macosx
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1578490555-6363-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4d7c7dee-fd50-f310-29be-c22bc6ed3d10@redhat.com>
Date: Wed, 8 Jan 2020 15:03:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1578490555-6363-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ra2pw_kkMyq-kqDBIQL8yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/2020 14.35, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Fix Unix socket connection & skip commands that are not implemented.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/Makefile.include |  2 +-
>  tests/test-qga.c       | 25 ++++++++++++++++++-------
>  2 files changed, 19 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


