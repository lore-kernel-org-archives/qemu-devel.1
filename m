Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D1BC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B13208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wyz+5o0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B13208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxZB-00055U-4P
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxY3-0004ZT-At
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxY1-0005pU-JO
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603461360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QkAqy5qIQgC/o0NnajP1fmojtzwO4H6Aq15mlBr5qyU=;
 b=Wyz+5o0EeMV0v9LXPRC86srtI8xQNcH5Ihskre6jbQodGwYXAljOpQvFnDEVj8vPPLp6UQ
 LDB4hU4Y7OJEkSBe2C0qbL9gNsZNK6GJ4aJvDh38W8eboegpAYubwyslc/uGGNKY5dDj2I
 R8UCnalY1ih57OOt/8JENNJ9Y3P/9NU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-tYAoVqrKMD-RS8OZhmW4fA-1; Fri, 23 Oct 2020 09:55:56 -0400
X-MC-Unique: tYAoVqrKMD-RS8OZhmW4fA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BD30801AB3;
 Fri, 23 Oct 2020 13:55:54 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1965C1CF;
 Fri, 23 Oct 2020 13:55:44 +0000 (UTC)
Date: Fri, 23 Oct 2020 14:55:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v11 08/19] multi-process: Associate fd of a PCIDevice
 with its object
Message-ID: <20201023135543.GE812157@stefanha-x1.localdomain>
References: <cover.1602784930.git.jag.raman@oracle.com>
 <956a7c7931dabee483b4d815c9ef9b3f28130d72.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <956a7c7931dabee483b4d815c9ef9b3f28130d72.1602784930.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
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

--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 02:05:01PM -0400, Jagannathan Raman wrote:
> Associate the file descriptor for a PCIDevice in remote process with
> DeviceState object.
>=20
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  MAINTAINERS                  |   2 +
>  hw/i386/meson.build          |   1 +
>  hw/i386/remote-msg.c         |   1 +
>  hw/i386/remote-obj.c         | 154 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/i386/remote-obj.h |  42 ++++++++++++
>  5 files changed, 200 insertions(+)
>  create mode 100644 hw/i386/remote-obj.c
>  create mode 100644 include/hw/i386/remote-obj.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+S4N8ACgkQnKSrs4Gr
c8iw/Qf/ULrwQAQRAk/BoA1CEWJDDPrrRCgJkRrLZDebl7cksoV96xUMT3zMCC+c
LdveUg4kMJlfooCZNG+BDWNpRgLvC8CgU4k0aOLLqXddJCDpUT2EU7+1LwTnH1DT
wEfqB5tvlsKtZCWliQzT+jRrniX2XyLOCOh9nufVVlpaW1AJ2F+405uZenbmSIxt
lUBe58KBdPLtJTCDWdlk29UD/eXBuhPk+kWq4jqmRIq1VQCPXRwVtgmntAVPVSZN
uDeeh4QE/Q66YKyPXCTpGy/y3QzI58M2Fpbu31N2+rQrSgI6CJ8yeXS4trI1mIWI
lQrozFFW3CojRsqm8q6sA8CB8nwxHg==
=3nGk
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--


