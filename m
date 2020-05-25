Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBEAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E47206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2/sEYZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E47206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8CX-0004e8-H5
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8Bx-00049w-M4
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:10:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41253
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8Bx-00009A-06
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590394236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WpmhaDjmMIk1hn/kAPkXVwmF6mV+3gYcJ0nPTAIIj4Y=;
 b=G2/sEYZg6o5h+0I4flqoyLBU7/yKMLQXGXwUSahiXNGPp4HyQ4a0NWYvY/vuRUxLXPSzZ4
 +yALEomnDuySpCxjoJjLA3TMgfjqbMhvsOaQpmYnbqr16h8JQXpvN/zCpKHbH7+VKElLOg
 vhF41ELftmoqV3aN7g24RZU5RMoIYaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-oJ5-pcx5OieltpZIIMbFHw-1; Mon, 25 May 2020 04:10:34 -0400
X-MC-Unique: oJ5-pcx5OieltpZIIMbFHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E6F4460;
 Mon, 25 May 2020 08:10:33 +0000 (UTC)
Received: from localhost (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 964A05C1B2;
 Mon, 25 May 2020 08:10:29 +0000 (UTC)
Date: Mon, 25 May 2020 10:10:28 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 4/7] block/nvme: switch to a NVMeRequest freelist
Message-ID: <20200525081028.nzi7qcvmnrasw2wv@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-5-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3y5m36smqb4yamuc"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 00:06:24
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

--3y5m36smqb4yamuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 06:11:35PM +0100, Stefan Hajnoczi wrote:
> There are three issues with the current NVMeRequest->busy field:
> 1. The busy field is accidentally accessed outside q->lock when request
>    submission fails.
> 2. Waiters on free_req_queue are not woken when a request is returned
>    early due to submission failure.
> 2. Finding a free request involves scanning all requests. This makes
>    request submission O(n^2).
>=20
> Switch to an O(1) freelist that is always accessed under the lock.
>=20
> Also differentiate between NVME_QUEUE_SIZE, the actual SQ/CQ size, and
> NVME_NUM_REQS, the number of usable requests. This makes the code
> simpler than using NVME_QUEUE_SIZE everywhere and having to keep in mind
> that one slot is reserved.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 81 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 27 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--3y5m36smqb4yamuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7LfXMACgkQ9GknjS8M
AjWxIg/8DbDH9G2nsNiCuh+2MFNT58clGj7cZdM1r63zuU/8O1xnwQslxoA3ub/9
iZJBm2k+Mfmrd7eL3IFpMIBL2ZrptRGVJVJraiuHakOyS5PNegR0un7k63r5vMHW
FjfBNgTO/0c2zVGFHB5cx4OlzkJDXIgQ1c4Taw/iCscBT8XkGzBksSRqBLiXfujs
H1auhs76XmhO1oyI9VliyGmbSbZ5K4Z23QMI44JiRPl8OK/qc6lar8EyusztvKcU
TGmIa2ToTUTs0QdJlsaUn1h1Rnm8Zbbm+RJ6U8ZaMj3edQJATl3cYOeQ1XSNgAG6
gk8tlXCfW18gskQozqG6qAcOiPVeAy8wCicyWaou3xYWZ6pk0bbdDy+/knkNySPG
hw6YiLj9M3zmr5xjctH6CawjTuD9HBLcFcfHUrT+5toNhgug2SyBzeO9+0UQPV4Q
7WQsyNVpXF6UqkfmtpA462PGch9LpGotSEM+AqKLzXRufPxAK4B0SCzNBZwYgQRV
p12oGwto0fyFq262F3LMyiC2wMqnNeSN9fneHHl7wQV2mhd8epoG9JnV2PTzUKLr
+Si7GVpL2J1PRs2H+wQAJpoUKruM96kCTTTeQpMkjvhjmZfbaFd/XI6Y+VCQQwyx
a3RSYcxkMWW0o9XfNGW/fCUc06xbSm4QXSMjaCU9eUABQ53QEuo=
=5yOY
-----END PGP SIGNATURE-----

--3y5m36smqb4yamuc--


