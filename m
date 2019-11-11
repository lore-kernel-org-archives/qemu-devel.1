Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D9C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4CB214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 13:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OluSYCWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4CB214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU9RD-0008M5-8N
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 08:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iU9QL-0007jX-B7
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iU9QI-0003Ak-V7
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:08:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59488
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iU9QI-0003AL-Oj
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 08:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573477681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPNxLK4SKpvM7kP7td2nkqXnhYdsW4i1hbcJItF8vPc=;
 b=OluSYCWKRYa0vf0L1fQC7ZeF/XNwCd6KCv95zeViDos1PGtfO1JtS98E/mGyCi6WoabGWs
 4Mv1P/LVhxDM/G4lBTRc10x+G3iJMDvHxfp4QKGcfsrtfsDjK4HAi/dLvSl7vPmWREW4JM
 5t9NoXV28+90osqm0eqTzIUtShACCoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-dlWnMTT9MU-cC_-MzzY7zg-1; Mon, 11 Nov 2019 08:08:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A14A6107ACC5;
 Mon, 11 Nov 2019 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-162.ams2.redhat.com
 [10.36.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9414600C6;
 Mon, 11 Nov 2019 13:07:58 +0000 (UTC)
Subject: Re: [PATCH] tests/migration: use the common library function
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191111125530.26579-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cd4917d6-75b7-2c47-0c6b-07dda077c52e@redhat.com>
Date: Mon, 11 Nov 2019 14:07:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191111125530.26579-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: dlWnMTT9MU-cC_-MzzY7zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/2019 13.55, Alex Benn=C3=A9e wrote:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Could you please add at least a short patch description? (Why is this
change necessary / a good idea?)

 Thanks,
  Thomas


> ---
>  tests/migration/stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index 0c239646934..915389b53ae 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -31,7 +31,7 @@ const char *argv0;
> =20
>  static int gettid(void)
>  {
> -    return syscall(SYS_gettid);
> +    return qemu_get_thread_id();
>  }
> =20
>  static __attribute__((noreturn)) void exit_failure(void)
>=20


