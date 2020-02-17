Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51775C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1916D20836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcmdwyb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1916D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eiq-00022z-B2
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j3eiI-0001dm-Pd
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j3eiH-0003Mg-20
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:37:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j3eiG-0003M8-T8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581939439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRZ1UDAQ1p6/YSsI6P/0wcLs1ai4smUlPUPG9vEs9/4=;
 b=gcmdwyb+qjgG8Yxl54iw20tGMbvjyC3HYlwyrb9KxLH1RaJYFokiZePHjb9vgTQVxVOkAF
 wJWg1xgQWlwuIQw5T/w60AZOxpYuwx/24Z5Ms1Ror+o5Xb6x1TNptwFen0DeK4VkH8HBGo
 EBDzy/cg0Blxk1UdINQM1A2/23JicrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-PtY0Cq0gPz6txA82lymFOA-1; Mon, 17 Feb 2020 06:37:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37931107ACC4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:37:17 +0000 (UTC)
Received: from work-vm (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64F209053C;
 Mon, 17 Feb 2020 11:37:10 +0000 (UTC)
Date: Mon, 17 Feb 2020 11:37:08 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
Message-ID: <20200217113708.GG3434@work-vm>
References: <20200217094240.9927-1-philmd@redhat.com>
 <20200217094240.9927-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200217094240.9927-2-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PtY0Cq0gPz6txA82lymFOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Fix warning reported by Clang static code analyzer:
>=20
>     CC      tools/virtiofsd/passthrough_ll.o
>   tools/virtiofsd/passthrough_ll.c:1083:5: warning: Value stored to 'save=
rr' is never read
>       saverr =3D ENOMEM;
>       ^        ~~~~~~
>=20
> Fixes: 7c6b66027
> Reported-by: Clang Static Analyzer
> Reviewed-by: J=E1n Tomko <jtomko@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Thanks, you might want to snd that to the upstream libfuse
(different context); it looks like it's the same there.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

> ---
>  tools/virtiofsd/passthrough_ll.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index c635fc8820..e9e71d5fc2 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1080,8 +1080,6 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_i=
no_t parent,
>          return;
>      }
> =20
> -    saverr =3D ENOMEM;
> -
>      saverr =3D lo_change_cred(req, &old);
>      if (saverr) {
>          goto out;
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


