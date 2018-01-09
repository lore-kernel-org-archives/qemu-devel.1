Received: from eggs.gnu.org ([2001:4830:134:3::10]:54750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0tD-0007Ik-O3
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ0tA-0005mF-W5
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:52:55 -0500
References: <20171201232433.25193-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3323b23f-ad82-fff5-26cb-bf4c9622c36d@redhat.com>
Date: Tue, 9 Jan 2018 14:52:44 -0600
MIME-Version: 1.0
In-Reply-To: <20171201232433.25193-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="64hBCI1K9HMN0RpgvyYCUsQLYjFTNpNSe"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] macro do/while (0) cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--64hBCI1K9HMN0RpgvyYCUsQLYjFTNpNSe
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, armbru@redhat.com
Message-ID: <3323b23f-ad82-fff5-26cb-bf4c9622c36d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] macro do/while (0) cleanup
References: <20171201232433.25193-1-eblake@redhat.com>
In-Reply-To: <20171201232433.25193-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ping

On 12/01/2017 05:24 PM, Eric Blake wrote:
> Noticed this by chance in the tests/ directory, so I broadened
> it to a grep of the entire code base.  I suspect^wKNOW many of
> the bad macros were the victims of copy-and-paste from some
> other bad location (particularly given how many bit-rotten
> debug print macros were involved).
>=20
> https://wiki.qemu.org/BiteSizedTasks#Bitrot_prevention is still
> left for someone else, for another day.
>=20
> In v2:
> - add review tags
> - audit that the maint patch has no semantic change (all callers
> were indeed supplying ';' at the macro call-sites)
> - improved commit messages
> - more patches for some additional cleanups
> - tighten the checkpatch rule to also flag 'while (false);'
>=20
> Eric Blake (7):
>   net: Drop unusual use of do { } while (0);
>   mips: Tweak location of ';' in macros
>   chardev: Use goto/label instead of do/break/while(0)
>   chardev: Clean up previous patch indentation
>   tests: Avoid 'do/while(false);' in vhost-user-bridge
>   maint: Fix macros with broken 'do/while(0);' usage
>   checkpatch: Enforce proper do/while (0) style
>=20
>  tests/acpi-utils.h         |  8 ++---
>  ui/sdl_zoom_template.h     |  8 ++---
>  audio/paaudio.c            |  4 +--
>  chardev/char-serial.c      | 75 ++++++++++++++++++++++++--------------=
--------
>  hw/adc/stm32f2xx_adc.c     |  2 +-
>  hw/block/m25p80.c          |  2 +-
>  hw/char/cadence_uart.c     |  2 +-
>  hw/char/stm32f2xx_usart.c  |  2 +-
>  hw/display/cg3.c           |  2 +-
>  hw/display/dpcd.c          |  2 +-
>  hw/display/xlnx_dp.c       |  2 +-
>  hw/dma/pl330.c             |  2 +-
>  hw/dma/xlnx-zynq-devcfg.c  |  2 +-
>  hw/dma/xlnx_dpdma.c        |  2 +-
>  hw/i2c/i2c-ddc.c           |  2 +-
>  hw/misc/auxbus.c           |  2 +-
>  hw/misc/macio/mac_dbdma.c  |  4 +--
>  hw/misc/mmio_interface.c   |  2 +-
>  hw/misc/stm32f2xx_syscfg.c |  2 +-
>  hw/misc/zynq_slcr.c        |  2 +-
>  hw/net/cadence_gem.c       |  2 +-
>  hw/net/pcnet.c             | 20 ++++++-------
>  hw/ssi/mss-spi.c           |  2 +-
>  hw/ssi/stm32f2xx_spi.c     |  2 +-
>  hw/ssi/xilinx_spi.c        |  2 +-
>  hw/ssi/xilinx_spips.c      |  2 +-
>  hw/timer/a9gtimer.c        |  2 +-
>  hw/timer/cadence_ttc.c     |  2 +-
>  hw/timer/mss-timer.c       |  2 +-
>  hw/timer/stm32f2xx_timer.c |  2 +-
>  hw/tpm/tpm_passthrough.c   |  2 +-
>  hw/tpm/tpm_tis.c           |  2 +-
>  migration/rdma.c           |  2 +-
>  target/arm/translate-a64.c |  2 +-
>  target/mips/msa_helper.c   | 34 +++++++++++----------
>  target/s390x/kvm.c         |  2 +-
>  tests/tcg/test-mmap.c      |  2 +-
>  tests/vhost-user-bridge.c  |  6 ++--
>  scripts/checkpatch.pl      |  5 ++++
>  39 files changed, 119 insertions(+), 105 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--64hBCI1K9HMN0RpgvyYCUsQLYjFTNpNSe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVK5wACgkQp6FrSiUn
Q2oi1QgAgHGfkA0BBrrr6tim11chBKKJmsfdwTfwW4ND6CB2w7kKzvnS/DsB2yy9
TdOA0T3VgTsSSDZYVoviAJF6AjoS0WxbH1PydAI7SD9gR4tBdXHvsQemjxz97/ZA
J7yPIlGNegc7WKkx8Pdcf4N5UnhTz+y/dczpHRbXwPICzmw/GDuQHg1A6x2OFZrt
r1/YvBFk5IomzZdYLoxLOzMcgSUMfCe9JivgrJwrflaB2/4LabxD1MJ6z1Eb1O+U
b3z7k8KiJAI5nY0ghd3I8LKh7fmfGhXyUyAampmqY2ZP/8pgkdF01ZjcicR4jBev
MxtUHvdidedpaFTyFdJqyqnW2pPT8g==
=6uQH
-----END PGP SIGNATURE-----

--64hBCI1K9HMN0RpgvyYCUsQLYjFTNpNSe--
