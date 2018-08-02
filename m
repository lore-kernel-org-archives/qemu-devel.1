Received: from eggs.gnu.org ([2001:4830:134:3::10]:36075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fl8oV-0006WP-Pt
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 04:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fl8oQ-0005oE-Sj
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 04:18:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fl8oQ-0005nr-LW
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 04:18:22 -0400
References: <20180801170618.5374-1-pbonzini@redhat.com>
	<eb837eef-6738-b7f4-f227-b05c5eea50fd@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11663d77-82db-07e4-713f-611d996efbdf@redhat.com>
Date: Thu, 2 Aug 2018 10:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <eb837eef-6738-b7f4-f227-b05c5eea50fd@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] es1370: simplify MemoryRegionOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

On 01/08/2018 19:27, Philippe Mathieu-Daud=C3=A9 wrote:
> I guess this code bypass the access_with_adjusted_size() big-endian
> bug... But I have no idea if this devices on BE platforms, so for this
> nice cleanup:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

What is the big-endian bug, and why is tests/endianness-test.c not
detecting it?

Thanks,

Paolo
