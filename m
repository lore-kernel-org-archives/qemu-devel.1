Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dnsvK-0002pg-A6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dnsvH-0007dU-7x
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:52:18 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:55731)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dnsvH-0007a8-0n
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:52:15 -0400
Date: Fri, 1 Sep 2017 21:52:07 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170901205207.GA1522@jhogan-linux.le.imgtec.org>
References: <cover.1504228916.git.alistair.francis@xilinx.com>
	<d64777dcf9079a8f997416b148b9cffbc14e0c49.1504228916.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <d64777dcf9079a8f997416b148b9cffbc14e0c49.1504228916.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/7] Convert single line fprintf(.../n)
 to warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Stefan Hajnoczi <stefanha@redhat.com>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2017 at 09:51:15AM -0700, Alistair Francis wrote:
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 3317905e71..a23aa438d2 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -95,11 +95,11 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu)
>      CPUMIPSState *env =3D &cpu->env;
> =20
>      if (!kvm_mips_fpu_cap && env->CP0_Config1 & (1 << CP0C1_FP)) {
> -        fprintf(stderr, "Warning: KVM does not support FPU, disabling\n"=
);
> +        warn_report("KVM does not support FPU, disabling");
>          env->CP0_Config1 &=3D ~(1 << CP0C1_FP);
>      }
>      if (!kvm_mips_msa_cap && env->CP0_Config3 & (1 << CP0C3_MSAP)) {
> -        fprintf(stderr, "Warning: KVM does not support MSA, disabling\n"=
);
> +        warn_report("KVM does not support MSA, disabling");
>          env->CP0_Config3 &=3D ~(1 << CP0C3_MSAP);
>      }

That looks sensible.
Reviewed-by: James Hogan <james.hogan@imgtec.com> [mips]

The 3 fprintfs in kvm_mips_update_state() are also pretty much non-fatal
warnings too (though only because old kernels v3.10-v3.15 didn't
implement the timer saving API). Feel free to convert those too if you
like, otherwise I'll submit along with some other changes.

Cheers
James

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlmpyG4ACgkQbAtpk944
dnrSgQ//dtJFVMcQ8JKBje4lRBm5F82OKkM6fsIVKuXxHErFu9RDN8XCjAmLOPxK
tPp5bygkbh5xGV82+T+3Jl3JcNHXyU0LyJVSInnuQ0WO7C0JPLr0/VDS/+tSqxqk
gV5f+eNwULI+nYgya8I+go7T2zNoF3WFTwY+nSBpePB2gp0TixwDIbM1vWDg4Ber
Yb5Y2OgDNh4oylNb9htm6oqsCWctMn6kJXOHSBIlLJcCAaWoU5nkSMzR7DiIZD5O
OjvsytVfAqYQmGni5qWXsocUCzEguy6jQTM71SI/j7ApEm3G1oFRKdts7pDyHMYn
5QyHyFXvNMoZtS5ilxaz7Y6dUEu63G0PpzKBFtAjlDnDg5uj32NGL0P6NnlYnD4W
92KPAxvIvAeVmXf+Pn44hkwfIS3DOih6wKv2RH4yyXC69aeNlD4Dp77vIl2aA+b/
A/GW7mnNcpeVF8Ed/YNJRn/hlTRa3fuiC2owt0GfUV70L+Kd+dlPm2uR2JMEVKRY
BN6NjFqPo4RscLkMuxTKMp2teXIds3hpUHHw4AXCk/yLU/POsVnQUbHc2wfR149Z
OFRVNPbQN5nHGSFE8+F0FLDkBVZeMUhRnyup1ecoEx2nbsv1V95wEmuFJ/6IZrT/
e2mHQx0X1nAvBnXr6X1DQ/IY9XK2VxWUET1vbF8SETtKrlFcecg=
=gMSA
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
