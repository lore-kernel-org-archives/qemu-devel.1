Received: from eggs.gnu.org ([209.51.188.92]:35620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gmh9l-0002nR-Mi
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1gmh4m-0005i4-Lh
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:37:58 -0500
Received: from mail-eopbgr710096.outbound.protection.outlook.com
	([40.107.71.96]:52194
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1gmh4i-0005cy-W0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:37:54 -0500
From: Aleksandar Rikalo <arikalo@wavecomp.com>
Date: Thu, 24 Jan 2019 15:37:47 +0000
Message-ID: <DM5PR22MB16585EFE36FC0584D37F3724D29A0@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548343154-8774-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] tests: Reorganize MIPS TCG
 directories and files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Thursday, January 24, 2019 4:19 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH v4 0/3] tests: Reorganize MIPS TCG directories and files
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Reorganize MIPS TCG directories and files.
>
> Directories for DSP tests in system mode are deleted. They
> introduce more complexity in test structure compared to the
> value they add. Still, these tests may be moved somewhere
> else, let's say in a new acceptance test that will boot
> "mips64r2" virtual machine.
>
> All remaining test will are user mode tests, which will
> simplify maintenance of mips tcg tests overall.
>
> The file movement is done using "git mv" command, so "git
> blame" will still display the original information, regardless
> of the new names and locations of involved files. Also, the
> command "git config diff.renames true" was used to keep the
> size of movement patches reasonable.
>
> v3->v4:
>   - DSP ASE system mode tests given up
>   - Makefiles provided for tests that remain
>
> v2->v3:
>   - corrected missing "v2" that caused wrong message linking
>     (the version is now "v3", of course)
>
> v1->v2:
>   - used "git config diff.renames true" before sending
>   - rebased to the latest code (included newly added r5900 tests)
>
>
> Aleksandar Markovic (3):
>   tests: tcg: mips: Move source files to new locations
>   tests: tcg: mips: Add two new Makefiles
>   tests: tcg: mips: Remove old directories

I too think that this will simplify the test dirs structure and
maintenance. I cannot wait to see these directories populated with
new tests for various MIPS ISAs and ASEs.

For all patches in this series:

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
