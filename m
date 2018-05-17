Received: from eggs.gnu.org ([2001:4830:134:3::10]:40656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJONa-0003Qb-Vf
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJOD0-0007VG-P6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:05:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fJOD0-0007V3-Kh
	for qemu-devel@nongnu.org; Thu, 17 May 2018 15:05:02 -0400
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-21-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02e9a6a1-2274-541e-8b88-111a3fc537f5@redhat.com>
Date: Thu, 17 May 2018 14:04:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/49] tests/tcg/i386: fix test-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 05/17/2018 12:46 PM, Alex Benn=C3=A9e wrote:
> The test-i386 test case is a little special as it includes assembler
> files. Add the additional compile magic to assemble these bits and
> link them to the final binary.

The patch says "add"...

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/i386/test-i386.c | 1 -
>   1 file changed, 1 deletion(-)

...but consists only of a single deletion.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
