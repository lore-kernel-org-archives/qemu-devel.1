Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38200C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E9B20578
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAC4QckL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E9B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZuc-0002IP-5t
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:39:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZtg-0001eT-3v
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJZte-0000UN-TX
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:38:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hJZte-0000SP-Jz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:38:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id j13so8207218wmh.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 01:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=I4s4ozzcRqk3KtPckYEQQUIpVuZ6N5tSF8D4Ej/ks1k=;
	b=PAC4QckLZJFt3gBfJzxJttnDGt8rpFM5q87HDMr+EA4P2Mq9TIdENIPrgMhv2XdR11
	rVAgTs38RuPlyLE0AWkf2oZrA3fhS6ATIwU9LqqhQPf5RpI38VZQvtUnjzcR+pw7KocD
	FNfzIS4zMBqTSpkNG7A173T/+4VBuYfNanziP6+AjWXhzxPCEx48khTHrmgCKDHEqzd5
	uSBCcM8NnxhT/jq+UNo8ovbZUIZMuuD55w8f1BDmwc7mDmxPocJ1BGcs8KpMXhI5mX6A
	yk/k1ebflt9cOD7kt+A0Lh5As7T14MUHvsrvzSBSpNJ2TQ4CqOqHW5LR5/JYZlmJ6zzy
	dScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=I4s4ozzcRqk3KtPckYEQQUIpVuZ6N5tSF8D4Ej/ks1k=;
	b=LlnqahjrVqMKuoAkVEZtEm6bgCj5UwvHwoLFKzglLXBOrI4kcZH8U1HCHRaIyJiGTy
	vfZC4jatewVKajSA0tZ6D61lUp/BiyvWHbt4V8vsBY6Af6tyq/CwWqDdrbNnlyISBUMr
	7dkzcDIgOQr6u53tLPmxr4e/e8ywuUqmUxzikk4v8V+Ca1s+5Gmv6DyQ0WdtPqywQrhj
	vBdymwhJ9Gw2C3437lYVibRHj4sBjm91WF5Im7AqgPeUGvUeWkSX9ZJEXVBBMmuvmF+/
	O9NmXGRyo6xD5U8TPupYnTxxj9JQ16bZ2vM72Fs+qrqzWtbAfs4SyPWZw4uYA6L9UfxM
	OEAA==
X-Gm-Message-State: APjAAAVgE49ifhFqoGxVlpAQRFgKEFBvQs2n2P2jZp/woj3OrQ5Bw82Z
	luuP9fz+1CC6C9xtmByfcms=
X-Google-Smtp-Source: APXvYqwMRu9NGfiIh1WfVOk3rBiYKG2/sVIoPaOgCVDAq5FNG4rQbAt1CMnyWUMd0OR6GqYxClbvtA==
X-Received: by 2002:a1c:ac07:: with SMTP id v7mr2429861wme.49.1556181501217;
	Thu, 25 Apr 2019 01:38:21 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	17sm15804999wrk.91.2019.04.25.01.38.20
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 01:38:20 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:38:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190425083819.GE30231@stefanha-x1.localdomain>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
	<17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
	mtosatti@redhat.com, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com, pbonzini@redhat.com,
	nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425083819.WqpYX7GqOH-1Rnf-gQf4Ble-9fXGtVY16_PosoVZS0o@z>


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 07:38:57PM +0300, Liran Alon wrote:
>=20
>=20
> > On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >=20
> > On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
> >> Hi,
> >>=20
> >> This patch series aims to add supprot to migrate a VM with a vhost-scs=
i device.
> >>=20
> >> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backen=
d when a
> >> VM is stopped (As happens on migratino pre-copy completion).
> >>=20
> >> The 2nd patch adds ability to save/load vhost-scsi device state in VMS=
tate.
> >>=20
> >> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin =
to specify
> >> it's setup supports vhost-scsi migratino. For more detailed informatio=
n on why
> >> this is valid, see commit message of specific patch.
> >>=20
> >> Regards,
> >> -Liran
> >=20
> > Looks fine for vhost_scsi.ko.  I have not checked how this interacts
> > with vhost-user-scsi.
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Gentle Ping.

This should go either through Michael's virtio/vhost tree or Paolo's
SCSI tree.

Stefan

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwXH7AAoJEJykq7OBq3PIoZMH/i8cF/6RyjMqK/KE38KeS6fU
LgcrxlIz5QO6ejRaaRtTsjoMV5ewKrj5lVjUa+i86ONdnx4XTuG22J11QndAWhJD
26Zl2Hg8uEKi5OdVWoHRe+7XxCzyu5uPRF7Y1Cv64wUBX8qmEdjmkjlB3kOd5l0L
XEDNMn+fiTi6c4MGfjWjapL+cM/513PVkpRDKa93gcmiTdodi5WOwbu2+7TAOJS6
S19uQEcthNCzxyOWa2ZqVgkWfeJQCVQ92hT8Upok7JpRXyQkLv3ckQ/Ub7Zet7Md
6sTBNE3VQ7M+oJDmt0mGDPC5Hc68hJ0oZ2cv6s13FL7dhYk1O+lEtawcVfHS3yo=
=9V17
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--

