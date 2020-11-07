Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF1C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB8620878
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxLxeeYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB8620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbGTE-0001qI-Ph
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 00:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbGSf-0001Q8-RM
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbGSd-0001Q9-Fp
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604725702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xPVcjxGNSCti1IF4TqarPkWoANl0PPv3OiQ2x0o9kV8=;
 b=YxLxeeYj0reLZznXetmur2We3UJntphteXeynN0zYR1YZnOcZg+nIoQmyOVvlE2iWG+JMj
 gQ/d+4t40y5w9XqmW8L/Ogs8njLrmT7T6wwGCVTfQJoT/ewtsMVXISa99U1fokZmGs9QMG
 lab0vLwwyTWRiv4SEUFPcP2lgckgIgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-J7EMbZS1P9WBSp110Hnj1w-1; Sat, 07 Nov 2020 00:08:19 -0500
X-MC-Unique: J7EMbZS1P9WBSp110Hnj1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED27A801FCC
 for <qemu-devel@nongnu.org>; Sat,  7 Nov 2020 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-47.rdu2.redhat.com
 [10.10.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 337E25D9CA;
 Sat,  7 Nov 2020 05:08:18 +0000 (UTC)
Date: Sat, 7 Nov 2020 00:08:16 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 07/11] qapi/introspect.py: Unify return type of
 _make_tree()
Message-ID: <20201107050816.GC2208@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-8-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-8-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2020 at 03:42:47PM -0400, John Snow wrote:
> Returning two different types conditionally can be complicated to
> type. Let's always return a tuple for consistency.

This seems like a standalone change.

> Prohibit the use of
> annotations with dict-values in this circumstance. It can be implemented
> later if and when the need for it arises.

And this seems like another change.

- Cleber.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+mK70ACgkQZX6NM6Xy
CfPQHg/+MhkGC2udCRDL44HGP535dGuDoGE+e+bR65Rl+R1ikH/EmDQWfl2M0DLL
TaR2DHeBf/4pZvfVX4uK4epRziwXLBJF5Mp9vBJEVib99SHqih+tRoAPFFlsdop/
szP5B4AMO7Xr+PDoz6lvsSrP539+soXI4jwKQbr9XHwKhNK6x0zOkeVZyEIvZBxv
JBXxxOsUhSPJ3E1BvmzvBOS3AfisGhuWQX3rG/zV8mxAXlsb0pTfhVK7XIkT2Omz
scK1qPd1muJwZZOWTDQVL5Qd2W2GqHm9dIed3q973IckQf+d4INLUdYHgSuLs4fy
nnHeuYxsGqG20TfiaY+gtWifTpitIa0+WCsCVKZ5qcfZIM6jYhjez+gsyl4KdSNs
nyeEk1p1pJF6hWcJZhWn42wd0Bq1UjNz1NqDPVcKeVS8Xz7CE8AxLsy0QH4b98Q7
QxKZtOzTcACsIfU1Ar/VFYnvg3owVAapzKW9eolOkyafREge3K5FDVF7ug9j3jWh
F2nKlUECLVLH+noSL2OcERdL1gmePSBS1KzOiXzjXjvmilBbc4u3V7ZZXKcnHNVJ
0XlMBYDelHJvmUT9+z0f2eog0l4FIjF2XPfmbc+2DxV6ArEj9BQQYaOe8TOT8sDQ
5Eu/swJYDJPv8wJ+3dDt2Fguz+6r57WTrTFbLAv4aKgn3WeZ5yo=
=R4Pa
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--


