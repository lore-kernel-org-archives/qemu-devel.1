Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB55C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980DC206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1f85pHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980DC206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIG4h-00066H-A3
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iI8Kz-0004nl-KM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iI8Ky-0002sC-Hx
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:32:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:53247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iI8Ky-0002s0-Bb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:32:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id r19so1670681wmh.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Y/X7QhKZj+nhiHe0CGkpGzEy53sX749PipgilVay7xA=;
 b=a1f85pHXwUF9s0YOmjJUauwnNYQH02RP2SYKyrxTUeESRdhUpOwoyNPPD6EYbXs8XZ
 60BG6/63rMP66yq3mPl3ilmarjmMkloqmz/pw0o23G3IoexBUDdeBq0qxWuDPurqJ8gp
 ppXC3QbRKjbbk5cvz1gRMH1K7E6Q72Hp9LCtaYbJhDyAovk3nE0VTfpIRyUeevZLH52z
 gDO7+RjfjBgyBFgEP+7Xfm+B0iumC2GpwmI6s/OKqsWbdLXsfJH1CrCoK+ioLuZgTUwH
 xUFebWcBPM+iSDa+UghVEOmVppIEYLT2lwoneEnPxeu5J2F0HDvP4R89wFkeP75LtRL9
 R0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Y/X7QhKZj+nhiHe0CGkpGzEy53sX749PipgilVay7xA=;
 b=K33yDgU0mGGmJXYvLf8n6pUIIcje2Zr0BAmFkpaWXYRJzIyK7eToMf41m9s2YAFdqb
 Ym5QSRp4KWcN3wzdpjmYpHlN1CQsRAtiHjjfBpqtj12dARyOzyBrakmpu9dVSxgYk5tp
 reSqwMTpSJQxKq+YkowP24RMk5rGvCWFAOC44QYLYlQA12DKD3ukt9Q4ShtcWSRJNysf
 QLcSXkAFzkPQdCrcnyZr7WE1Pv1DwdxW+lBMqBvnJHzsMhFZWLGITPF3aB7zSP0G3hoo
 3oqwMJJcLB6h9aW2h3rzOVvByC0NJ9ZJSXZVwK+7lDa2xpjBjdtgil0Ki2TKD5ZFWlP8
 iKFw==
X-Gm-Message-State: APjAAAVgpLImxDsroIyhJDu4nDOcasLTxdWwBjr+dbIdSC0hmArgynyM
 ds78aweSrAGUlouI/8WUg24=
X-Google-Smtp-Source: APXvYqzN9MloznbIOox6twjsiPBAphjsK/elbss9npzb5arAL6bnpxsSLEZuhUaXDbk/AZJ8d78NVA==
X-Received: by 2002:a1c:8148:: with SMTP id c69mr1927111wmd.41.1570613571124; 
 Wed, 09 Oct 2019 02:32:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t203sm1736139wmf.42.2019.10.09.02.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 02:32:50 -0700 (PDT)
Date: Wed, 9 Oct 2019 10:32:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: freebsd@tango.lu
Subject: Re: Easy way to track Qcow2 space consumption
Message-ID: <20191009093249.GA5747@stefanha-x1.localdomain>
References: <ab1bd1a234b7b9d18433d539f179f602@tango.lu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <ab1bd1a234b7b9d18433d539f179f602@tango.lu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 08:01:11PM +0200, freebsd@tango.lu wrote:
> Hello List,
>=20
> I'm using a fairly old KVM version
>=20
> ii  pve-qemu-kvm                          2.2-28
> amd64        Full virtualization on x86 hardware
>=20
> don't see much point upgrading either since everything works but I could
> still use a feature to keep track of the actual space used by the VMs
> without SSHing into all of them and doing a df -h.
>=20
> The VM images (especially the DBs with high rw operation will just grow a=
nd
> grow with time), for this to free up space the standard process was:
>=20
> 1, Zero-fill the drive (dd if=3D/dev/zero of=3D/some/file until you run o=
ut of
> space)
> 1B, sdelete -z c: < windows VM
> 2, Shut down the VM
> 3, cd to where the images for the VM are kept and run qemu-img convert -O
> qcow2 original_image.qcow2 deduplicated_image.qcow2
>=20
> I wonder if there were any improvements done in the KVM for addressing th=
is
> space issue. A lot of us using qcow2 because it's easier to backup due to
> the small size (eg: a basic configured webserver might only uses 3-4 Gb v=
s a
> 40GB preallocated empty image full of 0s).

Hi,
I'm CCing the QEMU mailing list and Kevin Wolf, the qcow2 maintainer.

QEMU and qcow2 have support for the discard/trim command that allows the
guest to report unused regions of the disk.  virtio-scsi and recent
virtio-blk devices support this feature.

Set the -drive discard=3Dunmap QEMU command-line option in order to enable
discard.

Run the fstrim(8) Linux command inside the guest.  Other operating
systems may have equivalent commands.

You should find that the qcow2 file has fewer allocated blocks after
this operation.  Consider this an efficient replacement for zero filling
the device.  It is still necessary to shutdown the VM and use qemu-img
convert unless you want to switch to a fancier online backup process
using block job commands.

Stefan

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2dqUAACgkQnKSrs4Gr
c8hN9ggAl/t7FZcEs1kfWHdFrgsfEYH7eDLGdWtg2BqBEqx7IcFo1ObGd5EhEgyF
YPUeqAeZ1U4jtoAhedvozgg9rLZROfFuisduIZqaJOxvSChGZaweK0WYyb7/xu3m
5yOhV1tfA6UnzXI7KdZO21TrI5O6zlQ78GrRbG22BskOPCHYIiNlh6l14Iq5NxMh
dhS+gdIGjxUmXKvHqGWN0tox0I5lKUHp2eE6NlSFCGHkIfucYtXRvvV6Mo17kRd+
6Dm1Eq58StBt6SrMYKtR0QSHXGYRFt24+YvzLbZxBveFY8VS39pXqR1s+s0zB2/q
8GFlIaptHRLBxrOI2UwzdFE/31eSXw==
=XlrS
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

