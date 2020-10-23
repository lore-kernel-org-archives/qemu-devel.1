Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A877DC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D0208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmZu0zjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5D0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxZo-0005zE-1c
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxZ7-0005BH-Ej
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxZ4-0005xu-Ee
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603461425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3QyhM3VFwpSS49kBU6XHgkzGDIs0st2rzZCJVGIXMc=;
 b=NmZu0zjbNkSwUkDh9rzOIeW+Dx9eoIWbapMZCRwKEN2zmma180nph6hyxG3hyS9CfY3VXW
 O2r/kouLsVIauY8BtpouQgEl/zHPCTnZrImhs+x02mH1eNfGSpJvOsLX/7G4oYyBMZMpaL
 lzF9y20Oi3ZpEInKCrIjBnmq7RfuvC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-AmymmtTwME-19vkxJ-bjuA-1; Fri, 23 Oct 2020 09:57:03 -0400
X-MC-Unique: AmymmtTwME-19vkxJ-bjuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5099C18C89E6;
 Fri, 23 Oct 2020 13:56:47 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA53F5C1CF;
 Fri, 23 Oct 2020 13:56:46 +0000 (UTC)
Date: Fri, 23 Oct 2020 14:56:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v11 10/19] multi-process: introduce proxy object
Message-ID: <20201023135645.GF812157@stefanha-x1.localdomain>
References: <cover.1602784930.git.jag.raman@oracle.com>
 <d761d6e7baeb6b848241effcd98fd5e42da1974a.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <d761d6e7baeb6b848241effcd98fd5e42da1974a.1602784930.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 02:05:03PM -0400, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>=20
> Defines a PCI Device proxy object as a child of TYPE_PCI_DEVICE.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> ---
>  MAINTAINERS            |  2 ++
>  hw/pci/meson.build     |  1 +
>  hw/pci/proxy.c         | 98 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/pci/proxy.h | 36 +++++++++++++++++++
>  4 files changed, 137 insertions(+)
>  create mode 100644 hw/pci/proxy.c
>  create mode 100644 include/hw/pci/proxy.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+S4R0ACgkQnKSrs4Gr
c8g3mgf/UJwpnAUHQ2VzVTUrzieg6OgHxjejLhY7Kko28kMw06KGitVmMA1DBAZz
K9LY1zm1Rut7ZTQL9joJ2UcyvWFB9j1OljawAbrCiolXnv44vzsr3MMCPenq4cmR
h8qIHy+TORXdBZdT8XgmQ2VOf+OHzgyGLEwAI+C1vh+0mePMe4hImYxP7JW7FlR+
44cU5csebvyabNbvcf36uhz7GNrYeF97qbwSWo8kg9DIqTDtx9IludDXUfTd/XFE
rI7YZlhNNgNAVolRLMDKFA0+Ykyi8Ps8mV3ofzPW7uNmh9Sd0N7xhKHmIQ4SUWA3
ivDUN8Xr+WdlWtI+PWEIAgpXmx+6yg==
=o0Sy
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--


