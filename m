Received: from eggs.gnu.org ([2001:4830:134:3::10]:35738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1co2Mf-0008Dw-03
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1co2Md-000419-SG
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:24:52 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1co2Md-00040p-ML
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 02:24:51 -0400
Received: by mail-ot0-x242.google.com with SMTP id x37so1246420ota.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 23:24:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170314192959.GA8685@redhat.com>
References: <1489298291-25154-1-git-send-email-phil@philjordan.eu>
	<148929878187.33.7584245811453618697@6c512846dbc7>
	<20170314192959.GA8685@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 15 Mar 2017 19:24:30 +1300
Message-ID: <CAAibmn3t6mDoQqHWX5Kj8qtRJMzj0o6TNC7CrFFJSng0ojWR6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 15 March 2017 at 08:29, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Mar 11, 2017 at 10:06:22PM -0800, no-reply@patchew.org wrote:
> > Hi,
> >
> > This series failed automatic build test. Please find the testing comman=
ds and
> > their output below. If you have docker installed, you can probably repr=
oduce it
> > locally.
> >
> > Type: series
> > Subject: [Qemu-devel] [PATCH v2 0/2] hw/i386: Update FADT to Revision 3=
 (ACPI 2.0)
> > Message-id: 1489298291-25154-1-git-send-email-phil@philjordan.eu
> >   LINK    tests/check-qlist
> > /tmp/qemu-test/src/tests/bios-tables-test.c: In function =E2=80=98test_=
acpi_fadt_table=E2=80=99:
> > /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:171: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:172: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4a=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> > /tmp/qemu-test/src/tests/bios-tables-test.c:173: error: =E2=80=98AcpiFa=
dtDescriptorRev3=E2=80=99 has no member named =E2=80=98reserved4b=E2=80=99
> > make: *** [tests/bios-tables-test.o] Error 1
> > make: *** Waiting for unfinished jobs....
> > make: *** wait: No child processes.  Stop.
> > make[1]: *** [docker-run] Error 2
> > make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-c8855z5b/src'
> > make: *** [docker-run-test-quick@centos6] Error 2
> > =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Hi Phil, did you run make check? Please make sure it isn't
> broken by any of your patches.


Sorry for the noise - I originally wrote most of the patch weeks ago
and on getting back to it forgot I hadn't sorted out the test
situation. I've just posted version 3, which does indeed pass make
check.
