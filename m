Received: from eggs.gnu.org ([2001:4830:134:3::10]:36740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRMau-0002Cy-Iy
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cRMar-00031k-BN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cRMar-00031C-5u
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:21:49 -0500
References: <1482307137-5106-1-git-send-email-peterx@redhat.com>
	<1482307137-5106-2-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f6e71117-81ce-db81-d469-d0b48b7cc794@redhat.com>
Date: Wed, 11 Jan 2017 18:21:46 +0100
MIME-Version: 1.0
In-Reply-To: <1482307137-5106-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] memory: provide common macros for
 mtree_print_mr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com



On 21/12/2016 08:58, Peter Xu wrote:
> -                   mr->romd_mode ? 'R' : '-',
> -                   !mr->readonly && !(mr->rom_device && mr->romd_mode)=
 ? 'W'
> -                                                                      =
 : '-',
> +                   MR_CHAR_RD(mr),
> +                   MR_CHAR_WR(mr),

An alternative definition could be

	memory_access_is_direct(mr, false) ? 'R' : '-'
	memory_access_is_direct(mr, true) ? 'W' : '-'

for MR_CHAR_RD and MR_CHAR_WR.  With this change, I think the small code
duplication in the "? :" operator is tolerable and the code is clearer.

Paolo
