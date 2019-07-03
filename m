Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953FEC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EB121882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nblo87h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EB121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibgP-0005No-NL
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hibaK-0000Gv-7L
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hibaI-0001rk-NQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:29:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hibaI-0001oh-8v
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:29:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so1572483wme.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 02:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0VQIdhRt7QU6cz7jhJl3r46rRPA1e7U3Np2p2pEGy3g=;
 b=Nblo87h1lBXXWJEll1Sgst+kqi1W2gWjxN/S+1AKupdUdH+1e9UIPyGikF+Xi/6CK0
 o7XgpSRxpiiGmFx1g2c1cJIepExlRtT7UuMIB+syC99eB6+IEqe9v8P4TxwEdQVce493
 T7s438GmUKckxhfgep3dYB2R7e6FS6eGUpcE6WIb8//k3mrGh4ej5wHpYCPxt+4zludk
 u0vDp2l0IPNig5yq38wO4R1eLeS6WBJ576dudbfBrHR0QHgmT9sY7DggzJM5SeWO4i9T
 d9Mp2agmpkRQ5qz91hbbt/Odf1spddNhFvd/HYu5RTNmqcsJ62DIYjOAqRqKAaBd/yw7
 CXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0VQIdhRt7QU6cz7jhJl3r46rRPA1e7U3Np2p2pEGy3g=;
 b=s2yZEGc/1/tDGUDIhhKIZcVxHpBaPxNomaECr8ST5G6R5EFWZjuB8U4PhOTuvBSNji
 omlNb5MxlqmP8LhfEm+tN73DEtiRJUiJNJx7Bw/v4fRaB570wYZpE/SzAlX60F4mf1jy
 pNCOvWxYSqquZoxcI5StY0x2afYeNYoY3BGhs608Vn716a4Q0Fb3dhFmgFmskKO773dK
 QhGYhphI3QqseywQFhE8n88IcWFA9RPMXxbRu2cZxqvqfLNPNkQdYYCcaoG09M3quSKz
 eLuMQIWAZO4koQ8pfEQiS/+MNM+YTvhbeKXm0AhmOwN+03MEaibU5m/B6exvG8OF62X4
 OGNw==
X-Gm-Message-State: APjAAAUGicb6yi+FF+mIlW5/T6lXf0KVDsSSCBORqc/ysFvaFyejVo/c
 I4yDzJmnN2Nl9pczoJQna4s=
X-Google-Smtp-Source: APXvYqzsFSqOdzY+9Ze52Ivq/xyTNB0LEGpcuVggKK9kLlOEusoN/swDF91g2xTrZnudWTNAWf2rXg==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr7555926wmf.60.1562146188810;
 Wed, 03 Jul 2019 02:29:48 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w14sm1212905wrt.51.2019.07.03.02.29.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 02:29:47 -0700 (PDT)
Date: Wed, 3 Jul 2019 10:29:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190703092946.GC11844@stefanha-x1.localdomain>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
 <20190701083710.GA18173@stefanha-x1.localdomain>
 <94a3da17-c1c5-b9ce-8e92-4d346ed98782@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <94a3da17-c1c5-b9ce-8e92-4d346ed98782@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] FAULT INJECTION FRAMEWORK
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, ehabkost@redhat.com,
 sakisp@xilinx.com, mark.burton@greensocs.com, armbru@redhat.com,
 qemu-devel@nongnu.org, edgari@xilinx.com, crosa@redhat.com,
 pbonzini@redhat.com, luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 12:16:44PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 7/1/19 10:37 AM, Stefan Hajnoczi wrote:
> > On Fri, Jun 28, 2019 at 02:45:29PM +0200, Damien Hedde wrote:
> >> This series adds a python framework aiming to provide some ways to do =
fault
> >> injection in a running vm. In its current state, it allows to easily i=
nteract
> >> with memory, change gpios and qom properties.
> >>
> >> The framework consists in a python script based on the qmp existing mo=
dule
> >> which allows to interact with the vm.
> >=20
> > How does this compare to qtest?  There seems to be a lot of overlap
> > between them.
> >=20
> > Why is it called "fault injection"?  The commands seem to be
> > general-purpose device testing functions (like qtest and libqos), not
> > functions for testing error code paths as would be expected from a fault
> > injection framework.
>=20
> I understand qtest is to test QEMU, while this framework/command is to
> test how the guest react to an hardware faults.

The commands seems to be equivalent to qtest commands, just implemented
as QMP commands.

Damien: Can you explain the use case more and show some example test
cases?

> To use the qtest_mem commands you need to run QEMU with the qtest
> chardev backend, while this series expose a QMP interface.
>=20
> To avoid the overlap, a cleaner follow up might be to have qtest wrap
> these QMP commands (mostly like HMP commands do).
>=20
> Another note while looking at a glance, qtest uses the 1st cpu address
> space view, this series allow to select a specific cpu.
>=20
> It makes sense to me to be able to select address spaces by name (more
> generic, not restricted to a cpu view, since one might want to inject
> fault in a device ram not always mapped to a cpu: dma, emac desc).

The naming issue still stands: none of the commands actually perform
fault injection.  They can be used for other types of testing or even
non-testing purposes.

Fault injection commands would be "make the next watchdog expiry fail",
"return error code X on the next DMA request", "report an AHCI link
failure", etc.

These commands are lower-level.  Therefore, I think "fault injection
framework" is a misnomer and will age poorly if this API is extended in
the future.

Stefan

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0cdYoACgkQnKSrs4Gr
c8hXmQf/X42SKF49+0QZV3M3PToQG2p2r4iV9dKp1WYT9QbgbkvNDrspHAlWhwMv
lERQvvSdiELMl/i2EBUGWPh1D0788r7gFdeyVESTVRptnm27QuqrH3l1KeheE2Ui
cHDT93Hy/RmxRUgdtfzsAXHVBhSQPUMbq6mMb0xctAYbPJ1jl7XCPg0/LvCPtjXA
HegfFPKU7wpbx6pMS4hWxoE/3Zq+645QVLugsOqoYP2XC56caUgcUbXKDJ+c8jry
cOeTjn5Er0YtaiNDfDTd56zwrSEXKxLwOqzPTwcVr1xtb43GwKJYKCn8dQCFjKLK
+7HFhq2mYUbI1i63viym4GKyiD4M2g==
=o4Ew
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

