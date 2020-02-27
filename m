Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03DC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD5F246A1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 18:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkYu6MGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD5F246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7NUB-0005SU-7e
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 13:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7NTP-0004Zm-KI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7NTN-00084j-O4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:01:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7NTN-00084c-Hy
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 13:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582826480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T+j4bN2/WJq3hO1MZI46vBrLWn7Bby6PVvgTHbIvagg=;
 b=hkYu6MGbaBn40yBvKy+R24K/J/sz1x9fyl8ZKZOiuzQzqqWhlHp0+P0gDR993Ao9FXukvO
 vZdFa8TxK48Ss3MUZdaDQsP/N4S2cZiTtWtxeKrTBY0T2VWsV0Rhgz5+QF7kCtEPzyN9zc
 qZ1DdzKBTWleVcfUgAuhOKztRP67q4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-UjH9S1zhNYG8PhRUbQ3lQw-1; Thu, 27 Feb 2020 13:01:17 -0500
X-MC-Unique: UjH9S1zhNYG8PhRUbQ3lQw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30C1F18B5F71;
 Thu, 27 Feb 2020 18:01:16 +0000 (UTC)
Received: from redhat.com (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70C8E19C69;
 Thu, 27 Feb 2020 18:01:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v2 10/13] migration/vmstate: Remove redundant statement in
 vmstate_save_state_v()
In-Reply-To: <20200226084647.20636-11-kuhn.chenqun@huawei.com> (kuhn chenqun's
 message of "Wed, 26 Feb 2020 16:46:44 +0800")
References: <20200226084647.20636-1-kuhn.chenqun@huawei.com>
 <20200226084647.20636-11-kuhn.chenqun@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 27 Feb 2020 19:01:08 +0100
Message-ID: <87o8tjdi57.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Reply-To: quintela@redhat.com
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<kuhn.chenqun@huawei.com> wrote:
> From: Chen Qun <kuhn.chenqun@huawei.com>
>
> The "ret" has been assigned in all branches. It didn't need to be
>  assigned separately.
>
> Clang static code analyzer show warning:
>   migration/vmstate.c:365:17: warning: Value stored to 'ret' is never rea=
d
>                 ret =3D 0;
>                 ^     ~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

I thought I had already reviewed it.

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued


