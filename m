Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A1520656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej2EdO41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A1520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjIhJ-0004X5-A7
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjIgV-0003Rl-G5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:35:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57115
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjIgU-0001Hz-6i
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591864536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w7hbBl6s3qfWLQv61qjnP4XlBE3OOYV0TiYlDKseb2A=;
 b=Ej2EdO4131+FqLV1FX1h3ezukUtylSMc9nKJFX681yBoHTCcEFwu8Pd762Fbly+XJaMdJE
 VoGwOmSofidzGKlFcUrjJ6831N/1msU+n3Pflj+9ISUqVUQPImidTeY/Ou187s/YPk0m3q
 PqGil8MU18aGUMlFwspksmRjDCOvaOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-WR-w2u49NRW7SDtIhR7J3A-1; Thu, 11 Jun 2020 04:35:32 -0400
X-MC-Unique: WR-w2u49NRW7SDtIhR7J3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58D99100A61F;
 Thu, 11 Jun 2020 08:35:30 +0000 (UTC)
Received: from localhost (ovpn-114-102.ams2.redhat.com [10.36.114.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFE5C7F4FD;
 Thu, 11 Jun 2020 08:35:29 +0000 (UTC)
Date: Thu, 11 Jun 2020 09:35:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] iotests: Add copyright line in qcow2.py
Message-ID: <20200611083528.GA22045@stefanha-x1.localdomain>
References: <20200609205944.3549240-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200609205944.3549240-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 03:59:44PM -0500, Eric Blake wrote:
> The file qcow2.py was originally contributed in 2012 by Kevin Wolf,
> but was not given traditional boilerplate headers at the time.  The
> missing license was just rectified (commit 16306a7b39) using the
> project-default GPLv2+, but as Vladimir is not at Red Hat, he did not
> add a Copyright line.  All earlier contributions have come from CC'd
> authors, where all but Stefan used a Red Hat address at the time of
> the contribution, and that copyright carries over to the split to
> qcow2_format.py (d5262c7124).
>=20
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> Commit ids above assume my bitmaps pull request does not have to be respu=
n...
> Based-on: <20200609205245.3548257-1-eblake@redhat.com>
> ---
>  tests/qemu-iotests/qcow2.py        | 2 ++
>  tests/qemu-iotests/qcow2_format.py | 1 +
>  2 files changed, 3 insertions(+)

The git history shows which lines were contributed by IBM and is more
detailed than a single copyright line at the top of the file. It's also
common to make smaller contributions, like the one I made here, without
adding a copyright line. In light of this I see no issue with adding a
Red Hat copyright line and there is no need to add one for IBM:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7h7M0ACgkQnKSrs4Gr
c8h1WwgAoKBV2brEPJSAAgwwDyMP0ScmoQu4DZqRGT7GXR0DS294hts/cZfzfa8W
9KMtt1OEw+Tgl4BM7mButk60E/nwXyU+diAQHLxwHpvWqbROakkO8iImA5V7cr6o
Ta2ubulS3H7G1mTbE8+IOL5ss6K1fcU2bpZpr/rF5j5qkc69lkq2obNQaTFpytu4
D6m0STF5xRacYeGuXJDGF1l0BZR0kQe+nMalhiRzaBdprpTj5Ng6gLWJ8hLmHSvP
n29WaRS1FYRw6vv8zwuhmfWOIZ8w+M7fnmPBRSYlNPQd+Os0sYPOF1wGC0sA/MSd
8EyQTuBsMbGmf52DYdVp/vPaMVHhPw==
=colo
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--


