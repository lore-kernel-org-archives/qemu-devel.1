Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A85C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB8F21926
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PKz+RbTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB8F21926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpW1e-0007qf-LM
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0C-0001YM-8m
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0A-0007Xo-O6
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56513)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpW09-0007TT-WE; Mon, 22 Jul 2019 06:57:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sdpg2gWbz9sML; Mon, 22 Jul 2019 20:56:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563793019;
 bh=Gxfsa3E6zMDwPC6CcPhWp4WScliBPHthV1UVsaUrs3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PKz+RbTkrUeJxtGmUAy8dR3jCd5w3tlskeFAypN0NjciN8EKCfOHePviWlvRYFF+2
 UHDTJdrT2iE0qi7GX76xYV+ImPr4xLS3n7eftzaRZEKqVEYlpPGePVugFrIumD+tPk
 L0w6+NvPyKy4nCNl6UFvKPpTD+3MtemO/CL3QTAE=
Date: Mon, 22 Jul 2019 18:38:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190722083840.GD25073@umbus.fritz.box>
References: <20190722053215.20808-1-npiggin@gmail.com>
 <20190722053215.20808-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20190722053215.20808-2-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 1/3] machine: Add wakeup method to
 MachineClass
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
Cc: Liu Jinsong <jinsong.liu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 03:32:13PM +1000, Nicholas Piggin wrote:
> Waking from suspend is not logically a machine reset on all machines,
> particularly in the paravirtualized case rather than hardware
> emulated. The ppc spapr machine for example just invokes hypervisor
> to suspend, and expects that call to return with the machine in the
> same state (modulo some possible migration and reconfiguration
> details).
>=20
> Implement a machine ->wakeup method and use that if it exists.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/boards.h |  1 +
>  vl.c                | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a71d1a53a5..915ac3352b 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -180,6 +180,7 @@ struct MachineClass {
> =20
>      void (*init)(MachineState *state);
>      void (*reset)(MachineState *state);
> +    void (*wakeup)(MachineState *state);
>      void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **e=
rrp);
>      int (*kvm_type)(MachineState *machine, const char *arg);
>      void (*smp_parse)(MachineState *ms, QemuOpts *opts);
> diff --git a/vl.c b/vl.c
> index cefe5a3968..45ea034410 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1556,6 +1556,22 @@ void qemu_system_reset(ShutdownCause reason)
>      cpu_synchronize_all_post_reset();
>  }
> =20
> +/*
> + * Wake the VM after suspend.
> + */
> +static void qemu_system_wakeup(void)
> +{
> +    MachineClass *mc;
> +
> +    mc =3D current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
> +
> +    if (mc && mc->wakeup) {
> +        mc->wakeup(current_machine);
> +    } else {
> +        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
> +    }
> +}
> +
>  void qemu_system_guest_panicked(GuestPanicInformation *info)
>  {
>      qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
> @@ -1764,7 +1780,7 @@ static bool main_loop_should_exit(void)
>      }
>      if (qemu_wakeup_requested()) {
>          pause_all_vcpus();
> -        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
> +        qemu_system_wakeup();
>          notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>          wakeup_reason =3D QEMU_WAKEUP_REASON_NONE;
>          resume_all_vcpus();

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01dhAACgkQbDjKyiDZ
s5IWcBAAxwjss4wVtCqPEXyFB92T3wZeKlopDgWQ/tlGDqtda3VxeFOM5v8DXT8O
pSh9RcP3+OPK+J4nInciglIUEBO3kVCpJa10GRuCwLOM6CTm40Kx2ZEuoUiMzt2T
BPLfLRjhyag98GZhv+NSlzwRPxprvaTaOlL6huaj+TFNQ6n3gz9JQpGc6MhXOTT1
qupE1Rx9KDmDXFutNPZZj3r90NO7x8N+nUV0hLMfuRDVox2RSRMFI24NkIFm14MA
pRo65fUNyFk0qEtyzmkpEDhtz0aI47ZgaVm78USK8kKchG/gzVzksk3jl6T8mIIc
Q6Oiz8wnH0S3eM0ylGPIZ2560DSj+GxofUY8gsxiGfqOClqKT9pqGpNmSH16yZsL
guSYdObRWVSb2alcFzuRvg3CxJTPj9qXhBVpGZz36VPD4PhBtbpm/9PlLRw4SvGF
eYYOjXDeQDzgE2g2EHrUOPLDstsys9SUwfA2TfUxcwM2GdyXuUZA8hnbVnozjZkh
2UAEcOFugj5eXWac9yvoKjVjyDKdXIApHkhQBdBUOWtGrlpAd2cAX4FSypHljszz
IZvHLOsnXHflbbe+7a9XEieNU/KUpSlIMIx+uB7CEr6XBeXE9g1Qcv1zxN/Adatr
gbLvzIirNbwKn7S28FuSR5pVwaiPSHD/0PPBfYaJOjoOfunOcbo=
=kN52
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--

