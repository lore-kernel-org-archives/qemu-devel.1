Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F80C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C2420663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhdRcRFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C2420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWETB-0008I5-HC
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 03:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWESO-0007pk-3G
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:27:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWESN-000800-5W
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588750021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukZvBaJcjfanvRdd8s/wZeUSdCGocPufD1TpLfgKz/Q=;
 b=VhdRcRFdx/7TgOW5+WojnFqxg+VwOdVwjlzUM1c8zCt0t3guVNznon+HU5IKQyohTaFRkw
 C/MXbJ0U+dzvp8xf+rOaFpQCNq0niK7K9K1K1gligZPZuNQYJiPCMwBhBL5KnY5dBmZre1
 LGmIMAdiaXTgYyspMxmv6gVEcpxHkVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-yrcMnSqPMh2_Xqdm5-8yNw-1; Wed, 06 May 2020 03:25:42 -0400
X-MC-Unique: yrcMnSqPMh2_Xqdm5-8yNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0697B1005510;
 Wed,  6 May 2020 07:25:41 +0000 (UTC)
Received: from localhost (ovpn-113-195.rdu2.redhat.com [10.10.113.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C86766061C;
 Wed,  6 May 2020 07:25:34 +0000 (UTC)
Date: Wed, 6 May 2020 09:25:33 +0200
From: Sergio Lopez <slp@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 00/13] microvm: add acpi support
Message-ID: <20200506072533.ik3qgcuxnpc7shtz@dritchie>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505100010-mutt-send-email-mst@kernel.org>
 <aedc8f5e-b348-1c30-95eb-75a748ccafa1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aedc8f5e-b348-1c30-95eb-75a748ccafa1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ourj2vwkn4egge5l"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ourj2vwkn4egge5l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 04:16:00PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 5/5/20 4:04 PM, Michael S. Tsirkin wrote:
> > On Tue, May 05, 2020 at 03:42:52PM +0200, Gerd Hoffmann wrote:
> > > I know that not supporting ACPI in microvm is intentional.  If you st=
ill
> > > don't want ACPI this is perfectly fine, you can use the usual -no-acp=
i
> > > switch to toggle ACPI support.
> > >=20
> > > These are the advantages you are going to loose then:
> > >=20
> > >    (1) virtio-mmio device discovery without command line hacks (tweak=
ing
> > >        the command line is a problem when not using direct kernel boo=
t).
> > >    (2) Better IO-APIC support, we can use IRQ lines 16-23.
> > >    (3) ACPI power button (aka powerdown request) works.
> > >    (4) machine poweroff (aka S5 state) works.
> >=20
> > Questions
> >=20
> > - what's the tradeoff in startup time?
> > - what should be the default?
> >=20
> > Based on above I'd be inclined to say default should stay no acpi and
> > users should enable acpi with an option.
>=20
> As this machine was added to have the least minimum hardware required, I'=
d
> keep the default with no ACPI and have user requiring it to use an option=
.
> My 2 cents obviously.

I also share this opinion. And I would prefer it to be a machine type
option, defaulting to "off", but I guess that's a matter of taste.

Sergio.

> >=20
> > > Together with seabios patches for virtio-mmio support this allows to
> > > boot standard fedora images (cloud, coreos, workstation live) with th=
e
> > > microvm machine type.
> > >=20
> > > git branch for testing (including updated seabios):
> > > =09https://git.kraxel.org/cgit/qemu/log/?h=3Dsirius/microvm
> > >=20
> > > changes in v2:
> > >    * some acpi cleanups are an separate patch series now.
> > >    * switched to hw reduced acpi & generic event device.
> > >    * misc fixes here and there.
> > >=20
> > > cheers,
> > >    Gerd
> > >=20
> > > Gerd Hoffmann (13):
> > >    acpi: make build_madt() more generic.
> > >    acpi: create acpi-common.c and move madt code
> > >    acpi: madt: skip pci override on pci-less systems (microvm)
> > >    acpi: move acpi_build_facs to acpi-common.c
> > >    acpi: move acpi_init_common_fadt_data to acpi-common.c
> > >    acpi: move acpi_align_size to acpi-common.h
> > >    acpi: fadt: add hw-reduced sleep register support
> > >    acpi: generic event device for x86
> > >    microvm: add minimal acpi support
> > >    microvm: disable virtio-mmio cmdline hack
> > >    microvm: add acpi_dsdt_add_virtio() for x86
> > >    microvm: make virtio irq base runtime configurable
> > >    microvm/acpi: use GSI 16-23 for virtio
> > >=20
> > >   hw/i386/acpi-common.h                  |  38 ++++
> > >   hw/i386/acpi-microvm.h                 |   6 +
> > >   include/hw/acpi/acpi-defs.h            |   2 +
> > >   include/hw/acpi/generic_event_device.h |  10 +
> > >   include/hw/i386/microvm.h              |  10 +-
> > >   hw/acpi/aml-build.c                    |   4 +-
> > >   hw/i386/acpi-build.c                   | 198 +-------------------
> > >   hw/i386/acpi-common.c                  | 206 ++++++++++++++++++++
> > >   hw/i386/acpi-microvm.c                 | 249 ++++++++++++++++++++++=
+++
> > >   hw/i386/generic_event_device_x86.c     | 114 +++++++++++
> > >   hw/i386/microvm.c                      |  36 +++-
> > >   hw/i386/Kconfig                        |   1 +
> > >   hw/i386/Makefile.objs                  |   3 +
> > >   13 files changed, 676 insertions(+), 201 deletions(-)
> > >   create mode 100644 hw/i386/acpi-common.h
> > >   create mode 100644 hw/i386/acpi-microvm.h
> > >   create mode 100644 hw/i386/acpi-common.c
> > >   create mode 100644 hw/i386/acpi-microvm.c
> > >   create mode 100644 hw/i386/generic_event_device_x86.c
> > >=20
> > > --=20
> > > 2.18.4
> >=20
> >=20
>=20

--ourj2vwkn4egge5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl6yZmwACgkQ9GknjS8M
AjUX0A//dwBMKscMzy/9PgrZ5jD+lKl5pH82GNb+cvraKoSW+NLx0yG4xOfYud7E
orhyVQLw7jRNrV92nijvXCfQPtt60+PQU0wkuIq5mGciJNFnESV4M2x0W/aCNbDh
HU67x5UB1j8iiC5/E7SX6NnDfhhqzMvTzeYIb4wO6HcyL3Jxr5+pKvxf1onp4M/l
UlKP4dnK1XZ+G/YLh8jJ5ql4YBeLzGp6IAQPWWkFRaT0S9uFbWxmdvrdiRuzyBR/
0X0m505+qM2wwI7x7HXSCIjJVu2yKIBCbcG0TKJ8l0O8ySiY8fSfcHeSdgHaY/mq
Tqlwmk4uNIRFm+zrMco6bBG5oW6A1T1zdPXVi0BGlkzW2i9SuBZOZk9+8nE3gC2P
qMiSXlrYfRppKeAuS729hDVyEuVFMB9CiVmeYeZCOKyKRMt7K7ePTXE0ENTKpD1a
bF+47kAN7ZYmZeOf5eyR6Vr2B8CF17BRCwk2KMZApB1aJSI6CBt+dZ/CTGm+ZGTy
LmjLU70xLitjBsx9nGcjRlL3w9Kbe8ycKQWEdJ48LgwE/Tlw3j4KoJBgdnPHMmjg
df8Mu6KTg7fXKTRKoxksp5VX8J/bZHPCUSL0pezfmCj0qNfGL05LM0/CFYq+MkGf
aFWno/bm36fOMuBG2ggfvscPm2/BdYE7+jHlZRlTrUPnmtOOwnA=
=Fqwf
-----END PGP SIGNATURE-----

--ourj2vwkn4egge5l--


