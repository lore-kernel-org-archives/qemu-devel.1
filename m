Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D11C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83432085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8fTs0XR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83432085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTU4q-0000Ah-35
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTU3K-0006Sc-EX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jTU37-0001Zt-Lz
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:29:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jTU37-0001Zm-6Z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588094975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjLZiMJtkxna//iWAP9OKMf5lUzJsN4GQsNpHy4kxLU=;
 b=U8fTs0XRpbSNCdNQ3gBsdxAvJfZ8/ze0XUCh+MBgHaVk/Nzm5BDMW8rsW87VC1nYfDdhUY
 ch8sQU8c9TsIpAVYeQ4VsLpLiFmNsKcZqKGm2ME8rrD3ht65f30spNQ9NIFbPJKLy7zunI
 ZPZmiCGheW0A0nGZTpzhd6IMjoi6nm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-FIIFAPM2PlC5stz837Q2Xw-1; Tue, 28 Apr 2020 13:29:29 -0400
X-MC-Unique: FIIFAPM2PlC5stz837Q2Xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75FBA8BF361;
 Tue, 28 Apr 2020 17:29:27 +0000 (UTC)
Received: from localhost (ovpn-112-246.ams2.redhat.com [10.36.112.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 038625F7FD;
 Tue, 28 Apr 2020 17:29:21 +0000 (UTC)
Date: Tue, 28 Apr 2020 18:29:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200428172920.GA111124@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:35PM -0700, elena.ufimtseva@oracle.com wrote:
> We will post separate patchsets for the following improvements for
> the experimental Qemu multi-process:
>  - Live migration;
>  - Asynchronous communication channel;
>  - Libvirt support;
>=20
> We welcome all your ideas, concerns, and questions for this patchset.

This patch series does two things:
1. It introduces the remote device infrastructure.
2. It creates the remote device program and the associated build changes
   (makefiles, stubs, etc).

There are many patches and it's likely that a bunch more revisions will
be necessary before this can be merged.

I want to share an idea to reduce the scope and get patches merged more
quickly.  It looks like the series can be reduced to 21 patches using
this approach.

I suggest dropping the remote device program from this patch series (and
maybe never bringing it back).  Instead, use the softmmu target for the
remote device.

Why?  Because the remote device program is just a QEMU that uses the
remote machine type and has no vCPUs:

  $ qemu-system-x86_64 -chardev id=3Dchar0,... \
                       -M remote,chardev=3Dchar0 \
=09=09       -device lsi53c810 \
=09=09       -drive if=3Dnone,id=3Ddrive0,file=3Dvm.img,format=3Draw \
=09=09       -device scsi-hd,drive=3Ddrive0

This will use the remote machine type, interrupt controller, and PCI bus
that you have created.

The remote machine type should default to no vCPUs and no memory
creation (the memory comes via the mpqemu link communications channel).

At this point qemu-system-x86_64 contains a lot of code that you don't
want in the final remote device program.  Let's ignore that for a
second.

Now you can submit a 21-patch series containing just the remote device
infrastructure.  This will be easier to merge.

Returning to code size, the next step is to reduce the binary.  QEMU has
a Kconfig-style system for optional features and dependencies.  It's a
better approach than creating a separate make target because it
eliminates the duplication and mess in the makefiles.

For example, you can disable TCG and KVM so that your binary has no
ability to execute guest code.  Currently ./configure disallows this but
I've tried it and it works.

You can add a new default-configs/ file that disables CONFIG_ISAPC,
CONFIG_I440FX, etc.  When you compile QEMU most of hw/ will not be built
anymore.  At this point you have a smaller binary that is still a
softmmu target so the makefiles are shared with the regular
qemu-system-x86_64.

There will be some code for which there is no Kconfig option yet.
Further improvements can be made by adding Kconfig options for any code
that you wish to eliminate.  Instead of writing makefile changes like
you did in this patch series you would be adding Kconfig options.  The
nice thing is that this work isn't specific to the remote device program
- anyone can use the new Kconfig options to reduce the size of their
QEMU.  So not only is it less messy than duplicating the makefiles,
but it also benefits everyone.

The downside to doing this is that it will take a while to eliminate all
code that you don't want via Kconfig.  However, your initial patch
series can be merged sooner and I think this direction is also cleaner.

I hope I've explained the idea properly :).  We can continue reviewing
the current series if you prefer, but I think it would be quicker to
drop the remote device program.

Stefan

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6oZ/AACgkQnKSrs4Gr
c8ixDggAvcYABvA60MSHudGl5IuQe4pqsF+3FRCtxCDzWV/YViYudZtuMPjAexfg
o7mjAdihwZmx5PmW1AAk7iC0mUlsbLiXGQNA2WCB9mj06af1isvORsfbQ4aEIamI
G8zqLeO3tFAAu49rq4WP8EB9ao4DhVHLGnGFu2PubqONwFwraL2KTaREoBYxODH/
C/dH3rhBzP8PKf6G2iXgCO8nSMmBodJRDmz6kNNHRmgNXQyLrP5o19rWDzpifCGs
xoywBiYnI11zALbrMnTv7WbCvvGkCjgLLwNSTpESW5Tcqb+L9PnCIJ7jsQNRApr+
LST+QtsvAbDbqDeq7XjxdBHQ+A52NQ==
=f8bM
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--


