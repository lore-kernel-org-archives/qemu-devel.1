Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4CEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6E420780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5Ds7kjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6E420780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzLH-0001bN-Qt
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzK5-0008Jg-GB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:32:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22233
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqzK3-0003Fv-2Z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593696734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KHYnzAP5FS1TP8QYjvfbRp1ZsvzHbiY2is674K7qsJg=;
 b=L5Ds7kjdqyvk1IV/GepSL1kuKz2TWtj/YA4HSCJwgqCOiGx0v5nTRi0sD7V7pNIfCxTpK8
 jXg9RM39Jpi9egfl4nuN5GOV1+OjlX8XL4pZ2Qx82YPMn3qTU3zggi4YOALmJsnBAfkxbM
 r/53IX2lpp2jUjpYfN9i6nDaKUkySvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-oXKMqXtTM023SFYWqzqL0g-1; Thu, 02 Jul 2020 09:32:09 -0400
X-MC-Unique: oXKMqXtTM023SFYWqzqL0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 091C1100A8EB;
 Thu,  2 Jul 2020 13:32:07 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8AC1778A6;
 Thu,  2 Jul 2020 13:32:00 +0000 (UTC)
Date: Thu, 2 Jul 2020 14:31:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 20/21] multi-process: add the concept description to
 docs/devel/qemu-multiprocess
Message-ID: <20200702133159.GF152912@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <0dfdf845d65ed4b3976b4bb7f884a1fa92b6f153.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0dfdf845d65ed4b3976b4bb7f884a1fa92b6f153.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:09:42AM -0700, elena.ufimtseva@oracle.com wrote:
> diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
> new file mode 100644
> index 0000000000..406728854c
> --- /dev/null
> +++ b/docs/devel/multi-process.rst
> @@ -0,0 +1,957 @@
> +Multi-process QEMU
> +===================
> +
> +QEMU is often used as the hypervisor for virtual machines running in the
> +Oracle cloud. Since one of the advantages of cloud computing is the
> +ability to run many VMs from different tenants in the same cloud
> +infrastructure, a guest that compromised its hypervisor could
> +potentially use the hypervisor's access privileges to access data it is
> +not authorized for.
> +
> +QEMU can be susceptible to security attacks because it is a large,
> +monolithic program that provides many features to the VMs it services.
> +Many of these features can be configured out of QEMU, but even a reduced
> +configuration QEMU has a large amount of code a guest can potentially
> +attack. Separating QEMU reduces the attack surface by aiding to
> +limit each component in the system to only access the resources that
> +it needs to perform its job.

This document does not reflect the functionality, internals, or syntax
implemented in this patch series closely. It can still be useful as
background reading for someone interested in diving into the code, but
please add a disclaimer at the top to avoid confusion:

  This is the design document for multi-process QEMU. It does not
  necessarily reflect the status of the current implementation, which
  may lack features or be considerably different from what is described
  in this document. This document is still useful as a description of
  the goals and general direction of this feature.

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl794c8ACgkQnKSrs4Gr
c8jmnAf/bol2YUaG6gtYV/wTvDsG5fEptA4+K8i3ieyITkR3OAprX7Owu+HNTdCP
mDPsEwT+J7+j/QWAkpKRD7GMfqYkX7JjALueD8+YEtVRUIQuRJJpmaE1UMgs+c7N
kt/kZ0jOvj16ex68f11PK0Gtk9BtEMBGVLx80PciXbeLB7kc7yueQs84bN9QfG2n
RRNo3AwKGilKI/609s7DR2oy5xU1siaQrGZOKgthMiANZeN0BbhgyESbWuya6077
U52b7TQVBnPsMvdAosEYmWqkuVs6vEISuTGtPvBw9NU1RtAYNyf8NmGNvf0i118+
R6UREdGc2xKle0AEbIx/zojU/K9slA==
=zMP7
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--


