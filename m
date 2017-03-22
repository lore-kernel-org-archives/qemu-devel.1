Received: from eggs.gnu.org ([2001:4830:134:3::10]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1cqezx-0001YF-V1
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1cqezu-0005CS-TF
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:04:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:51919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1cqezu-0005Bs-N0
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 08:04:14 -0400
From: Andreas Schwab <schwab@suse.de>
References: <mvminn3t1fq.fsf@suse.de>
	<a7886994-b4fe-3c6c-40ee-213b36e1e4b4@tuxfamily.org>
Date: Wed, 22 Mar 2017 13:04:12 +0100
In-Reply-To: <a7886994-b4fe-3c6c-40ee-213b36e1e4b4@tuxfamily.org> (Thomas
	Huth's message of "Wed, 22 Mar 2017 12:46:56 +0100")
Message-ID: <mvmo9wtsekj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-binfmt-conf.sh: Fix m68k_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

On M=C3=A4r 22 2017, Thomas Huth <huth@tuxfamily.org> wrote:

> On 21.03.2017 10:38, Andreas Schwab wrote:
>> The m68k mask should not remove the low bit of the ELF version field a=
nd
>> should ignore the OS/ABI field.
>
> Did you encounter a problem with a real binary here?

Yes, some binaries are using ELFOSABI_GNU instead of ELFOSABI_SYSV.  All
other patterns already ignore the OS/ABI field.

Andreas.

--=20
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
"And now for something completely different."
