Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E35AC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A880B208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcqd6QZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A880B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAgV-0007sy-Ih
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAeu-0006YS-3l
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQAes-0005Xy-FG
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602081789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DxGBYO9AWdASCxgbZPBk7mCFtUtLZ/Bw2+Fg7HHNpb0=;
 b=Pcqd6QZNsiFwvrs5kyCCL/Pa+2jzQnK4tPfAobD9CEYH6bLBOoVyy9p1PQaOx/F44l+zNL
 ddGDRRBLFTwbfSSIDb5aLMvfZQEy9B3mWTH9VjOwQc/iO0+Gwu9tcz5y46IIHNlmKsru3y
 Fk+vwQ+Wczi/eTPSxqG58GE4JCeHIKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-TJhUgXw9OUCmC4rDtKXTMA-1; Wed, 07 Oct 2020 10:43:06 -0400
X-MC-Unique: TJhUgXw9OUCmC4rDtKXTMA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EBDF100F7BA;
 Wed,  7 Oct 2020 14:43:02 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BACB6CE51;
 Wed,  7 Oct 2020 14:43:01 +0000 (UTC)
Date: Wed, 7 Oct 2020 15:43:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v10 00/19] Initial support for multi-process Qemu
Message-ID: <20201007144300.GE113587@stefanha-x1.localdomain>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please prefix names with "x-" to mark the command-line interface
experimental and subject to change. That way users know that there is no
backwards compatibility (for now).

 -machine x-remote
 -object x-remote-object
 -device x-pci-proxy-dev

Thanks,
Stefan

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl990/QACgkQnKSrs4Gr
c8hKqwgAilbBjFlQTFfdHGAPU6Ny/ths3RbZuQSesccGKyUHaevTOA4SOTCXBYIi
sMiwuKpzbIGWlc6xXUrB7NcuaBDoDMPcPpM8hWqFtNRYifcMsrsbxXhQve5buAoI
I4whezo0G6YBgYdq4ABoZYah0T4EvCG0hbpNoDmrsrGafOSUu8zp4EYaE0WjQetG
seyCvLDq33E/GP0N46nDV0sqzkszxCpcapUdTvDlAj7GfGyghL00hAkj8HnpBfmJ
y7bHny3taWWbzI/vvwRZzq3xqxWeQASLueE9EFwvrOZ8herid/qAIapmhncer+Y+
itVMcVnJhcayf/kClFC9stTMPgUJKQ==
=r/aN
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--


