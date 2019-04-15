Received: from eggs.gnu.org ([209.51.188.92]:50754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hFzwr-0007cb-Mf
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hFzwq-0003ur-T0
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:38:53 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:36666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hFzwq-0003ti-K7
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:38:52 -0400
Date: Mon, 15 Apr 2019 13:38:43 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190415113843.pcagpvrsankd2avw@function>
References: <20190415113431.12060-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415113431.12060-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: set LC_MESSAGES and LC_CTYPE in main
 for all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Daniel P. Berrang=C3=A9, le lun. 15 avril 2019 12:34:31 +0100, a ecrit:
> Hardcoding LC_CTYPE to C.UTF-8 is a partial regression vs the above
> curses commit, since it will break the curses wide character handling
> for non-UTF-8 locales but this is unavoidable until QEMU is cleaned up
> to cope with non-UTF-8 locales fully.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Non-utf-8 environments should be rare enough that it will not be a real
concern.

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
