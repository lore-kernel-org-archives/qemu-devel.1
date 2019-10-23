Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F29CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C736821906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3XRNkuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C736821906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHUG-0006qU-Rs
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fziglio@redhat.com>) id 1iNHQF-0004uI-Ge
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fziglio@redhat.com>) id 1iNHQD-0001t4-Ch
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:15:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1iNHQD-0001sM-8m
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571840131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3AzTSNr1+bk6xk5v0Le7KK49kHWtcEpCGbM+FPTOwU=;
 b=e3XRNkuRc7F0JvYsG8GLw1E8Jki6m3zLkksUC8ihIL79qArnlu83v8YksgsJLgvkgCfgiT
 5DwKMIkca1jOpWt89iFKiZbTP0u9Vf6WhHf5hBffo6wOWGcABWhKg2v1mHJJiZ1ib7WFBT
 fQ4S7PHX59kF83AhdiURRSn1zg4ldaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-nenBWSG8O6OLiKMt30O_qg-1; Wed, 23 Oct 2019 10:15:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4E511800E02;
 Wed, 23 Oct 2019 14:15:26 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98B8560E1C;
 Wed, 23 Oct 2019 14:15:26 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8A53C18089C8;
 Wed, 23 Oct 2019 14:15:26 +0000 (UTC)
Date: Wed, 23 Oct 2019 10:15:26 -0400 (EDT)
From: Frediano Ziglio <fziglio@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <1860840671.8198083.1571840126307.JavaMail.zimbra@redhat.com>
In-Reply-To: <c2836c58-5a3c-2356-6e94-9b2341ab2194@redhat.com>
References: <20191023122652.2999-1-fziglio@redhat.com>
 <20191023122652.2999-3-fziglio@redhat.com>
 <5f20705e-60bc-08d5-8b6e-72438afabefe@vivier.eu>
 <c2836c58-5a3c-2356-6e94-9b2341ab2194@redhat.com>
Subject: Re: [PATCH 3/3] qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
MIME-Version: 1.0
X-Originating-IP: [10.34.247.51, 10.4.195.29]
Thread-Topic: qemu-timer: reuse MIN macro in qemu_timeout_ns_to_ms
Thread-Index: gWCTqNw1TUvyNnqka61UjZmh0LtxXw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: nenBWSG8O6OLiKMt30O_qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>=20
> On 10/23/19 8:42 AM, Laurent Vivier wrote:
> > Le 23/10/2019 =C3=A0 14:26, Frediano Ziglio a =C3=A9crit=C2=A0:
> >> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> >> ---
> >>   util/qemu-timer.c | 6 +-----
> >>   1 file changed, 1 insertion(+), 5 deletions(-)
> >>
> >> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> >> index d428fec567..094a20a05a 100644
> >> --- a/util/qemu-timer.c
> >> +++ b/util/qemu-timer.c
> >> @@ -322,11 +322,7 @@ int qemu_timeout_ns_to_ms(int64_t ns)
> >>       ms =3D DIV_ROUND_UP(ns, SCALE_MS);
> >>  =20
> >>       /* To avoid overflow problems, limit this to 2^31, i.e. approx 2=
5
> >>       days */
> >> -    if (ms > (int64_t) INT32_MAX) {
> >> -        ms =3D INT32_MAX;
> >> -    }
> >> -
> >> -    return (int) ms;
> >> +    return (int) MIN(ms, (int64_t) INT32_MAX);
> >>   }
>=20
> Why so many casts?  It should also work as:
>=20
> return MIN(ms, INT32_MAX);
>=20

This was former version. Laurent pointed out that MIN macro
is using ternary operator which is expected to find the same time
on second and third part so the cast inside the MIN macro.
The cast before MIN was kept from previous code.

Frediano


