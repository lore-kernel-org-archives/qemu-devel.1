Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC23K-0001xq-Tq
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eC23H-0003sD-LN
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:28:22 -0500
References: <20171106185506.20334-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5a537eb5-27c6-912b-899b-e2ca86faf00f@redhat.com>
Date: Tue, 7 Nov 2017 12:28:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171106185506.20334-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: remove unused
 memory_region_set_global_locking()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On 06/11/2017 19:55, Marc-Andr=C3=A9 Lureau wrote:
> This was never used since its introduction in commit
> 196ea13104f8 ("memory: Add global-locking property to memory
> regions").
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Indeed, it was introduced for symmetry with
memory_region_clear_global_locking but it isn't very useful.

Adding qemu-trivial.

Paolo
