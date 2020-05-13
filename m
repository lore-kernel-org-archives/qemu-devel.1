Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E593CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C63420575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMz+C/Ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C63420575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYoN1-0006ZG-3P
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 06:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYoMS-00064a-4b
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:11:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYoMQ-0007jK-Pt
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589364692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSh+q1KMwW5853wu13bAysdcHor9DkMt4zlQqPlfUTI=;
 b=UMz+C/HoVu059h2olXG1rE+5d3UF1pwohzzO4Z8HFDojVxs+r89Nj0LdUTrWfzDFFJD4Xa
 Cf5zV9emd6h2xOtrix+IdzjdbNgT1HGA8U6lufDsW8OS95YMoDJP4IWvpGsuvv3uYBG0k4
 mcNhoThD5+g8zChKN92y+/8Khirm8wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-zyoBsHWeO7WEc8nXu_3dBQ-1; Wed, 13 May 2020 06:11:30 -0400
X-MC-Unique: zyoBsHWeO7WEc8nXu_3dBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BB8053;
 Wed, 13 May 2020 10:11:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-80.ams2.redhat.com [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4A371A923;
 Wed, 13 May 2020 10:11:27 +0000 (UTC)
Date: Wed, 13 May 2020 12:11:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH] block/replication.c: Avoid cancelling the job twice
Message-ID: <20200513101126.GC6202@linux.fritz.box>
References: <20200511090801.7ed5d8f3@luklap>
MIME-Version: 1.0
In-Reply-To: <20200511090801.7ed5d8f3@luklap>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.05.2020 um 09:08 hat Lukas Straub geschrieben:
> If qemu in colo secondary mode is stopped, it crashes because
> s->backup_job is canceled twice: First with job_cancel_sync_all()
> in qemu_cleanup() and then in replication_stop().
>=20
> Fix this by assigning NULL to s->backup_job when the job completes
> so replication_stop() and replication_do_checkpoint() won't touch
> the job.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Thanks, applied to the block branch.

Kevin

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl67x84ACgkQfwmycsiP
L9YLbA/+NkbT0W+VsbVIP9D4zWyZ9sAFJr3i9abyXkZQjp6MV2EOY0YNW2H1P1a1
mMIT/eT1CcPXwWTJcncu/IHYXjMvVjUsl0p4HQ5Zpx5TaRRdmHMYhFXHK8u26zGn
FPMwfF7uIOZifHlZfkvDPjjOWtnwfCp6lq8AGkjHjd2MT8GreNB8nF9yTvp10YIc
t03HYmq9Z2xke8mzoD36VGMc3BghO+J9XvwBXOV6x6RdofZgrwIQA+YTCXIKnE/2
8H8yxauoE4mf+9r4GR807GbySXfQgiE8BzTmBPq/GhcdSj40UyQtiDCCLV0kSu4V
sUMkf4Ag9hwcIvhDkYzZBQ6Q0PpBwJ5Z5fENx9SiGc+sYhEbEuQDMRsCzsH1vrq1
TaQ4zVkeA0/EqR0oUv14gwAgTsHsFkQKPdeym9vAI7vPwC8+c/fC/0bqNsF6jni6
ZpdnXXwi7BAStBr+n//zz4TR3cpHlLWbsRVqjDOJzFGIokcdTNgkQ3ARqSHwK+qk
nrKrezxCF5lEGZja3YhWxOXKOj18nQTn3qaLKE4wHitA/60SQQTrabSilB47oiKy
oHrfo+GgWQXgPuAMEdQIwsdMrfQLbQDLalV3AzsR/Ogrn6BdoEPBqc5UZhJSia9S
53EgWFLFRh2et/ljUbYUEah9Slb7/nRHfauOwXhj4cPicY0NFHo=
=nH38
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


