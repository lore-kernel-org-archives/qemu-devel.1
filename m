Received: from eggs.gnu.org ([2001:4830:134:3::10]:57522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cns91-0006Gv-Jk
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cns8y-0002Ew-DY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:30:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cns8y-0002Dm-4f
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:30:04 -0400
Date: Tue, 14 Mar 2017 21:29:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170314192959.GA8685@redhat.com>
References: <1489298291-25154-1-git-send-email-phil@philjordan.eu>
	<148929878187.33.7584245811453618697@6c512846dbc7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148929878187.33.7584245811453618697@6c512846dbc7>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] hw/i386: Update FADT to Revision 3
 (ACPI 2.0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: phil@philjordan.eu, famz@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, lersek@redhat.com

On Sat, Mar 11, 2017 at 10:06:22PM -0800, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20
> Type: series
> Subject: [Qemu-devel] [PATCH v2 0/2] hw/i386: Update FADT to Revision 3=
 (ACPI 2.0)
> Message-id: 1489298291-25154-1-git-send-email-phil@philjordan.eu
>   LINK    tests/check-qlist
> /tmp/qemu-test/src/tests/bios-tables-test.c: In function =E2=80=98test_=
acpi_fadt_table=E2=80=99:
> /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> make: *** [tests/bios-tables-test.o] Error 1
> make: *** Waiting for unfinished jobs....
> make: *** wait: No child processes.  Stop.
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-c8855z5b/src'
> make: *** [docker-run-test-quick@centos6] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D

Hi Phil, did you run make check? Please make sure it isn't
broken by any of your patches.


> Test command exited with code: 2
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
