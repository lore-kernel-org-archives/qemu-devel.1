Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0DBC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF531206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbGMR4Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF531206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkCO-0002rm-3A
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jLkBR-00016b-Jw
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jLkBQ-0007ir-IS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:06:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jLkBQ-0007iP-EF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586250372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tfVifKiE2xfn7n26VgR9OimJ9M+oBz6Al+CpoPMqLJQ=;
 b=FbGMR4FxLbbGRTzRneKwEDwmoffrTRVMiKeuHH2ffrE/KQjusRVVc8a+E3/HxuOftdUeJw
 FZ3YJuVQoDVqAETBhV7uVCkUMQLO+PCWTmSCdWlvZwWAt3cv+L9P3bl/DTE4nKBC96O04M
 OGXaWmGjHiR5oy6kwe19TK1arV9kC1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-6PIRzA6TPK64_4L4qMSrYA-1; Tue, 07 Apr 2020 05:06:09 -0400
X-MC-Unique: 6PIRzA6TPK64_4L4qMSrYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09989DB20;
 Tue,  7 Apr 2020 09:06:09 +0000 (UTC)
Received: from localhost (ovpn-113-168.ams2.redhat.com [10.36.113.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CA639DD96;
 Tue,  7 Apr 2020 09:06:05 +0000 (UTC)
Date: Tue, 7 Apr 2020 10:06:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] atomics: update documentation for C11
Message-ID: <20200407090604.GB247777@stefanha-x1.localdomain>
References: <20200406191320.13371-1-pbonzini@redhat.com>
 <20200406191320.13371-3-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200406191320.13371-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2020 at 03:13:18PM -0400, Paolo Bonzini wrote:
> -The semantics of these primitives map to Java volatile variables,
> -and are strongly related to memory barriers as used in the Linux
> -kernel (see below).
> -
> -As long as you use atomic_mb_read and atomic_mb_set, accesses cannot
> -be reordered with each other, and it is also not possible to reorder
> -"normal" accesses around them.
> -
> -However, and this is the important difference between
> -atomic_mb_read/atomic_mb_set and sequential consistency, it is important
> -for both threads to access the same volatile variable.  It is not the
> -case that everything visible to thread A when it writes volatile field f
> -becomes visible to thread B after it reads volatile field g. The store
> -and load have to "match" (i.e., be performed on the same volatile
> -field) to achieve the right semantics.
> -
> -
> -These operations operate on any type that is as wide as an int or smaller.
> +which however are deprecated.

Please indicate why they are deprecated and advise which alternative is
preferred.  This will help readers understand the current best practices
and make a decision about whether to avoid the deprecated APIs.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6MQnwACgkQnKSrs4Gr
c8iMuQgAvbA+Qhz2HN0hehNjeb5jPHAnzY3Sc2lzz0FtIssdzyjD/lXkoCI5t+yr
0enOBN4J5wvUv+qYm0WOLjZ1xIzmr2pbditsONVb8o6TsvVnId4/tt/SihmNCCzM
jrkxqjhQWRC20A/GCVlBNwIzmZrA3TYeUF4UusXXAs1d2IiYgPUr8fWzU+j+3NLM
jwDdBWC9k884oXvmeagdDIcM1Pk3BjX4qst2Vs+JvdC+A+WGa+ZQ/AErSrsKP/mj
vKUrA7UUUTIPBBENMJBEsfZGZBBqfTs7l85G3VtbKlQMNPuupLDzYW57h74gxyP+
FYVZYMPg9mSpStupoHT6343Y3XQ7kQ==
=1bHI
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


