Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7C1C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02AC206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdnXkToR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02AC206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCrs-00052t-Ug
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 06:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iVCqg-0004Ss-QG
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iVCqf-000735-S1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:59:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iVCqf-00072s-O9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573729177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KKcS6cKcqtNwbOh8nAu1CVUkS9cGLICgyurtqZq8NO8=;
 b=VdnXkToRoWDvJxK0DokncvxJj5B4I7zfrR5bkMFh4AVY4VvMd7ROu9ju3QCJgTsLMLLSMB
 5sT4tJyv+bPexZ5wJg89TKJ4v9OQKzOAfCPsE2rqgKpGp50otCOZXq9NH+gNLRI9ClsBlu
 8TU+8EshQGcryrJ7GytplhP2aB4N0PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-Zv9qN0R-NQGgX3a3e_ft2Q-1; Thu, 14 Nov 2019 05:59:33 -0500
X-MC-Unique: Zv9qN0R-NQGgX3a3e_ft2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF3FB803076;
 Thu, 14 Nov 2019 10:59:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D0C960C2D;
 Thu, 14 Nov 2019 10:59:32 +0000 (UTC)
Date: Thu, 14 Nov 2019 10:59:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Bharat Singh <bharatlkmlkvm@gmail.com>
Subject: Re: Status of "vhost-user-blk device backend" mentioned on QEMU wiki
Message-ID: <20191114105931.GB580024@stefanha-x1.localdomain>
References: <ac9a9332-4089-f4e0-16e8-43bb165d6310@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ac9a9332-4089-f4e0-16e8-43bb165d6310@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Coiby Xu <coiby.xu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2019 at 02:21:44PM +0530, Bharat Singh wrote:
> I wanted to ask about the status (as in, is someone working on it or is it
> completed) of "vhost-user-blk device backend" project mentioned on QEMU
> wiki. If it isn't assigned to anyone, then I'd like to work on it.

Hi,
I just saw an email from Coiby Xu, who has already completed this
feature.  Maybe there is another feature you are interested in working
on?

Stefan

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3NM5IACgkQnKSrs4Gr
c8izAAf/eB0p9SDKm3mTvl7wHC94bsj8H8QjZ0JyleKW5jikCk92yiQlk7WTwYZL
SbOBigColPXtytBhqbRFsWRJTHr915cPS0enL57IFOli0H2QWkK+NrPhPSmkZgWU
HUwFEvTgkguKdrJP6W4yChZ2a9nVVnvSn1ECyAMWfXaKyW73q55EOP4X8Z90w1Gz
B1OdEuqIeC3Arlyeej7aT4IrBvh4hFxW42gZwjTN08fusw+n07+K7oQogJJz5pCF
BfeIF5g9DgSY3JaVfGDGgzjv1CdJiubmvByFw6uV5plNI1zzP0/w+TZQ81SRgOHd
RIWBKYk3EBP1CIDKZNcj6VEagJA/aA==
=Kw7j
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--


