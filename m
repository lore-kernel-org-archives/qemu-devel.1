Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22409C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF299206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 09:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aug9XIhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF299206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ibu-00083t-7g
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 05:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0ibJ-0007dV-SO
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:42:17 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0ibI-000428-5s
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 05:42:17 -0400
Received: by mail-wm1-x343.google.com with SMTP id g10so1769748wmc.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vz7wp36EtTBX+0pdF91SG6j/vIUUVxEELFnyzyNN2MA=;
 b=aug9XIhCF7a3EzbDdSt5OBxrfNAGuALzZK6XoKVcZyFwURTG5gdO4+ODVFErc9/zpG
 VJVyO5LALPS25eqbJXpZRK9lQzA07RuQiR5KMea7DcJeqRsWRDp9NKGaV35RXxr89AcG
 ixyA2G5icL6JE5t6wUGIr1c4IPgec3sJrw8hEVaH7/Tt4kQSb2mtNzLzqEz3m6TufQsh
 LwLBpnK9Yjc95CrEhjM7Ix1iaTWsqPuhZ0YOouGFaOUsyoqs8PQYLZ5oOs6zTXEErlsT
 j3Ol8dvMTlAbD8kng6q9DaGqY6ej3GBcU9dKFWU2GTggCDQV7MNEq+U11Oz5VhQIh0yL
 NPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vz7wp36EtTBX+0pdF91SG6j/vIUUVxEELFnyzyNN2MA=;
 b=NZPmX9L7+aYbz9puaIVltDww92ppqVFyL7KY5E1wcIA0dIHvBOw8gUN2FXQ7Oc9LMa
 h66F00lZI4n1JgyWrj5ArQZksTsJ6NCvLyYzil7ufXODtpOTnCoWEpBNTrzTi/H7IECu
 uPvay3QaqqrG6ro2esOEm7+4pjTDZ+btT8mzbF3vhRcQQ5JizFEfdbp7G0vaw+AR8IBP
 HaaghRlR0AOKN4V1g2SPvl6CHNp42LdziAqJGscVAaUTEzVfyUpzmYAWDMguiRdufRGC
 Jr8icJ4SuZN1CYNky9aNPoXb5m9Lrc+66fBuCKZrQUNJh47Lswmlg08XSOijjYZBdcHP
 bmwA==
X-Gm-Message-State: AOAM531Smq1NwvPCE/C3UKRfvuzs7o3aJMx3JyOXniMBBCJOzvns52YF
 gxEmuMnWfMsgoQlob2+MUZk=
X-Google-Smtp-Source: ABdhPJwSzHvZFdLQiXegk2Q3aFnmX5PE3xBpG+3kNaGyyWT46JhUMCWvV8KmBVwMcWP5JDDpoXeFhw==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr8012149wmh.85.1596015734693;
 Wed, 29 Jul 2020 02:42:14 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n12sm4725464wrg.77.2020.07.29.02.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 02:42:13 -0700 (PDT)
Date: Wed, 29 Jul 2020 10:42:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC 0/2] virtio-rng: add a control queue
Message-ID: <20200729094212.GB35835@stefanha-x1.localdomain>
References: <20200123151700.1367857-1-lvivier@redhat.com>
 <20200124110240.GH736986@stefanha-x1.localdomain>
 <e4b0d666-c2a8-6d95-28f4-b51fe80ef73a@redhat.com>
 <20200129154300.GB157595@stefanha-x1.localdomain>
 <eeb362c9-24e8-49ef-4194-617e8a2881a9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <eeb362c9-24e8-49ef-4194-617e8a2881a9@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 03:45:26PM +0200, Laurent Vivier wrote:
> On 29/01/2020 16:43, Stefan Hajnoczi wrote:
> > On Fri, Jan 24, 2020 at 03:05:18PM +0100, Laurent Vivier wrote:
> >> On 24/01/2020 12:02, Stefan Hajnoczi wrote:
> >>> On Thu, Jan 23, 2020 at 04:16:58PM +0100, Laurent Vivier wrote:
> >>>> The kernel needs sometime to be able to cancel an ongoing command.
> >>>>
> >>>> For instance, if the virtio-rng device uses the egd backend
> >>>> and this backend doesn't provide data, the buffer provided by the
> >>>> kernel is kept as long as it is needed.
> >>>>
> >>>> On the kernel side, a read blocks until the buffer returns from QEMU.
> >>>>
> >>>> As the read is done with a mutex held, all the hw_random interface
> >>>> hangs and we cannot switch to another hw_random backend.
> >>>>
> >>>> So this series adds a control queue to the virtio-rng device to allow
> >>>> to flush the virtio-rng input queue to release the kernel mutex and
> >>>> to allow to switch to another device.
> >>>>
> >>>> The kernel side series can be found at:
> >>>>
> >>>> https://github.com/vivier/linux/commits/virtio-rng-ctrl
> >>>>
> >>>> Laurent Vivier (2):
> >>>>   virtio-rng: prepare the introduction of a control queue
> >>>>   virtio-rng: add a control queue
> >>>>
> >>>>  hw/core/machine.c                           |  1 +
> >>>>  hw/virtio/trace-events                      |  6 ++
> >>>>  hw/virtio/virtio-rng.c                      | 99 ++++++++++++++++++=
---
> >>>>  include/hw/virtio/virtio-rng.h              |  5 +-
> >>>>  include/standard-headers/linux/virtio_rng.h | 14 +++
> >>>>  5 files changed, 111 insertions(+), 14 deletions(-)
> >>>
> >>> Where can I find the VIRTIO specification for this new virtqueue?
> >>
> >> I didn't update the specs.
> >>
> >> Is https://github.com/oasis-tcs/virtio-spec.git the document to update?
> >=20
> > Yes, please.
>=20
> I've updated the specs,
>=20
> Following
> https://github.com/oasis-tcs/virtio-spec/blob/master/CONTRIBUTING.md,
> I've opened an issue:
>=20
> https://github.com/oasis-tcs/virtio-spec/issues/83
>=20
> Is this the good process?

Please post spec changes to the virtio-comment@lists.oasis-open.org
mailing list:
https://github.com/oasis-tcs/virtio-spec/#providing-feedback

Thanks,
Stefan

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hRHQACgkQnKSrs4Gr
c8jx7QgAgO6Pzak09keIRWKobhm6bYa1Z/kf1PH5gJonm0oRWFQkTg+qtmfWsYy6
TmU8KX4vzIRUaJ2t0c66ybrAwFYU2F7Ez8C6Y0J1RtrpqAQTg0rhrtfeBPm/PvDr
JcU5bdEvZzeZ1QQFz25wS7xPHPf07BWeeKnWhcuS9VcAN3xnmFQaiXy02Wzfsdes
M2/4gFE6UXaaD+JsvqpSv1xf9j9AFXwqsfXNa6ys6WdcpvIiZQrau15cAnXvSz8K
+3iE0vxwapRW9eiJ/OU+bppBrYXRwGerZRd+FeQ/ovkhIXV3RqlUKK8+BZiEyd7G
5GAtWZkqOYOi+l1See2QlaYEgU10kA==
=/htO
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

