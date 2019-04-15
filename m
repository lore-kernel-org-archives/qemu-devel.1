Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42088C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB66E20675
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUVWPbFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB66E20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFy4C-0000kR-4h
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 05:38:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFy3O-0000T9-Rq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFy3N-0005BU-Ml
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:37:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hFy3N-00059V-Cs
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:37:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id z11so19854453wmi.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=mDTs/4FxhXIZJQNdG1+nO+WJ+J4Q879oj+Gag8GjZCA=;
	b=mUVWPbFkL4CXK0afL7StTQItY067GrSXRqqxSDuaYpX43z8r1f5tkg6NmtVujwh3JL
	5Cn5xKqLHuIDPOC4gyr4g5VmFmUqA5lnES5SfTrnsOjgal7u41JXPBgatOALZnKOHTgm
	wGAuC8RWYvvO+Oz3h0hSTzwVImzLBiuGJCawqsLRlYd55qfitwknMAqinNMK5w93e11A
	WOCVKR691s5IL5yjj5iH4b4FyltAe+DI/lwwLBzDO7OkwhM/joLYO9gPqqqhpijs3bAI
	ZUEvofa8pEsdAwsRXamJMeHcIrSF4gM5SUy5xILIDqb9LyzjX3PmUtrwwGrtt5IT7mNg
	n6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=mDTs/4FxhXIZJQNdG1+nO+WJ+J4Q879oj+Gag8GjZCA=;
	b=RBMeATwM36eKzW2xZL8xeW0KyIOj+LdAxHDTGNkuhI/rxnSBzXlrOIHfO25Jc2HCA4
	k2UXsUNet76jYBXZD00DTkAXDIfIuVIUeuitu8RgltoAoXNnnlBvzHQc9K3jCsuDRxYI
	exsxyyYnxWrTU4TCl4Eao+nEyayx4/5clCQsaTtf3OjX07xZ+uFcWeGRckG2I7KXSfI/
	4KKuvcgU1iYhQdvXRCjtCk4DeW0nDmLIp74pERZVeqJ/Cn4bNm+pA+AsZ8TXWzNwNlH8
	TJWriojsTtTSTahHyl1XBcTIJpGimQLwMzoS96LHyef1HTjJWp5uA57CoxzVVs/3Qbbi
	2u/A==
X-Gm-Message-State: APjAAAVQP1Fdo75VjC9ifF/5j7DIDvrjpBEZfw8GHihziDiRkRjCqBaR
	oSY3U4D5bSyYtKyOInrWPPI=
X-Google-Smtp-Source: APXvYqz5GuzLnCA8BnZie0St0EnUfjB9vbWiwjaFShoa1hO9fVEOimIbz18L0l8ECNxTxaCqcPCSyw==
X-Received: by 2002:a7b:c053:: with SMTP id u19mr18229864wmc.63.1555321047883; 
	Mon, 15 Apr 2019 02:37:27 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	f1sm14867327wml.28.2019.04.15.02.37.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 02:37:26 -0700 (PDT)
Date: Mon, 15 Apr 2019 10:37:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190415093725.GB29134@stefanha-x1.localdomain>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
	<20190409142925.GG16944@stefanha-x1.localdomain>
	<AC01E2C2-1944-42C5-A944-220EE6F8A489@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <AC01E2C2-1944-42C5-A944-220EE6F8A489@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
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
Cc: Nir Weiner <nir.weiner@oracle.com>, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415093725.KAwdxn-JKAynaKOlK49el6826T6bXGqHUS_FsrP59WY@z>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 01:45:06AM +0300, Liran Alon wrote:
>=20
>=20
> > On 9 Apr 2019, at 17:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >=20
> > On Thu, Mar 21, 2019 at 09:55:42AM +0200, Nir Weiner wrote:
> >> Originally migration was not possible with vhost-scsi because
> >> as part of migration, the source host target SCSI device state
> >> needs to be saved and loaded into the destination host target SCSI
> >> device. This cannot be done by QEMU.
> >>=20
> >> As this can be handled either by external orchestrator or by having
> >> shared-storage (i.e. iSCSI), there is no reason to limit the
> >> orchestrator from being able to explictly specify it wish to enable
> >> migration even when VM have a vhost-scsi device.
> >>=20
> >> Liran Alon (1):
> >>  vhost-scsi: Allow user to enable migration
> >>=20
> >> Nir Weiner (2):
> >>  vhost-scsi: The vhost device should be stopped when the VM is not
> >>    running
> >>  vhost-scsi: Add vmstate descriptor
> >>=20
> >> hw/scsi/vhost-scsi.c                  | 57 ++++++++++++++++++++++-----
> >> include/hw/virtio/vhost-scsi-common.h |  1 +
> >> 2 files changed, 48 insertions(+), 10 deletions(-)
> >=20
> > What happens when migration is attempted while there is in-flight I/O in
> > the vring?
> >=20
> > Stefan
>=20
> What do you define as =E2=80=9Cin-flight I/O=E2=80=9D? I think there is a=
 need to separate the discussion here to multiple cases:
>=20
> 1) The I/O request was written to vring but guest have not yet written to=
 doorbell:
> This is the simplest case. No state is lost as the vring is migrated from=
 source host to dest host as part of guest memory migration.
> Also, the vring properties (E.g. Guest base address) is transferred from =
source host to dest host as part of vhost-scsi VMState.
> (See patch 2/3 of series which adds VMSTATE_VIRTIO_DEVICE to vhost-scsi V=
MState which will cause virtio_save() to save vring on migration stream).
>=20
> 2) The I/O request was written to vring and the guest have written to doo=
rbell:
> The I/O request was submitted and processed by the vhost-scsi backend. Th=
erefore, the I/O request was sent to the remote TGT server.
> If the the TGT server has performed the write and returned ACK but the AC=
K was not received by guest, then guest is expected to initiate the write a=
gain.
> (Similar to what happens for a momentary TGT server downtime / network do=
wntime). So this isn=E2=80=99t suppose to be an issue.

This scenario doesn't fit into the virtio-scsi model since each
virtio-scsi request requires a response.  Otherwise there is a vring
descriptor leak.

If the migration scheme can leak vring descriptors then it is incorrect.
Especially repeated migrations could cause the vring to become totally
filled with leaked descriptors.

I think the case you've described cannot happen based on the
drivers/vhost/scsi.c code.  It seems that clearing the endpoint flushes
and waits for inflight requests to complete.  The
VHOST_SCSI_CLEAR_ENDPOINT ioctl blocks until the remote target has
returned an ACK for all in-flight requests.

This patch series needs a clear explanation of how the running
vhost_scsi.ko instance is quiesced such that:

1. Requests in-flight to the remote target are completed before
   migration handover.  (Fancier approaches to live migration are
   possible but this patch series doesn't seem to implement them, so we
   need at least this basic guarantee for correctness.)
2. No further I/O requests are submitted to the remote target after the
   vm stops running.
3. No further guest memory access takes place after the vm stops running.

These properties are critical for correct vhost live migration and I'm
not confident yet based on this patch series.  Please review the code
(including kernel vhost code) and include an explanation in code
comments (if possible) or commit descriptions.

Thanks,
Stefan

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctFDVAAoJEJykq7OBq3PIJLUH+gO2QYBPbKJ3Isz9qeabZUGh
TaVau4OexyGiEKjQEO7B8OKG8RiYK+EdzYLvmXxm8Vj/bJnePmdFMyBJtDoNOPaw
qFWEE8KNzDP8I6ZoBOwbpUeGfKMoGwxMIGXGgWMSseIkxB9jkwVdLZ8QS6utPuI6
rWk3pLcZA7drahYq5ngRb7n5dfWtys1P041L/DPaMhvKncxZP1ge9D1ETMb4Wcis
6YbywsjHIk+ft9IkRBbj6MwgSUYa6mVIeTBNusRl3iI0Ux5+Zc6PGElVy5yK6GWL
3MaBJ8dFnnAztRM49AOEW4a7GfPn1IQ6mo9W1UOLwNoD6R+6nT+eIZJDWDecyhU=
=Ms6X
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

