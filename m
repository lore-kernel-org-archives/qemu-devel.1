Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70FFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A522B2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYZsdDhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A522B2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8Ff-0006tP-TY
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8Er-00066T-I5
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:13:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8Eq-0000ab-0u
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590394415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWpbLIpY3ANbRmeGgO0qgrf3NCYquyPmcB1xDlh02nc=;
 b=GYZsdDhRj/vvnIRaFFVbAQUX1hj6oWuZmzZjVLJIr4V9/Xfs91WGcyjvQzXayYr8jNtktw
 0EaO/RrHyc3LnH611lwHglAfQNb+zhEIyM+DgdFEkgw/QNt/JUIqy1PiPZqrjKlNWiACPx
 tX+8VWNBmw9eHqkgE83MVqNCyNE+JTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-72jRDTHOOhaOH6DI-UHWwA-1; Mon, 25 May 2020 04:13:32 -0400
X-MC-Unique: 72jRDTHOOhaOH6DI-UHWwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B97A91005512;
 Mon, 25 May 2020 08:13:31 +0000 (UTC)
Received: from localhost (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1929B10013D9;
 Mon, 25 May 2020 08:13:27 +0000 (UTC)
Date: Mon, 25 May 2020 10:13:26 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 5/7] block/nvme: clarify that free_req_queue is protected
 by q->lock
Message-ID: <20200525081326.yq3rvswjityd3o5g@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-6-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-6-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="burcyt2fh7s7jkkg"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--burcyt2fh7s7jkkg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 06:11:36PM +0100, Stefan Hajnoczi wrote:
> Existing users access free_req_queue under q->lock. Document this.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--burcyt2fh7s7jkkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7LfiUACgkQ9GknjS8M
AjUDGA/9HUNh6Z0EgmpGwdCxMmcuZvbxQC4K5lXK5jNdB1u59Ldz4gqV+nGk5GRf
LEvBpZHDCVt3Mklkgr2CVd0oji7jyyY49xPhPpiN4ckKSZXPknq2xf+oMxQx85pW
REDiD2ZQYFKAOGpIPH9xaZxoO5BC7xLI1RcpY2h3RGLhZAfEBn3EinBm+cObsCik
TB3EcZueRG4k+669vDnCfodKf6LVSmGKRgcrxR2HdKsDYCWO4PyhchQiWgnQKup6
dfikTngcg3hR4x5NM/v23K4ZZMIXn29u6W1QSNx/GoNo4qNqZRy8N63qAyrk6GKn
KWedWMX6928LAQVRNASbR9zxXQYbJiIYNwaMC+DHmZQq5SBy4wrdb1MftxkMwWtE
La9Ad+ESxJMEfA3c2fktVTP1A/9BnX7IqsYjQbc2788lBy2IaBsLJrMqBFjCH0wl
Y9nzUl5Q+QvtnpcSCluhH7VDMcNJaayxY7Om6WimAVAuIASRtLPvSTwZvAgvpZ73
Cl0F1ge3IEt9bEuqzZ0T6YjERa+LgW5e4PYjz65Cd/oh/TmXEE5RuzQacVU4oo11
4BlsN8uoxb48SMvRWC9WTUVDjOIVFqPM/9CMXizwmfgHfvmtTUgidkL2zIDRaQA1
eQD+kQZ5+ojWn0EnDmZ1IwA/5LMDULJMFl3uxDQf0hK4te93ERo=
=4unE
-----END PGP SIGNATURE-----

--burcyt2fh7s7jkkg--


