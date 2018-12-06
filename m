Received: from eggs.gnu.org ([2001:4830:134:3::10]:50627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUuEG-0008J6-59
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gUty7-00008x-Jd
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:45:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gUty7-00008c-BT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 08:45:31 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-5-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6d9bb98f-9305-afc7-be93-af46fd80c218@redhat.com>
Date: Thu, 6 Dec 2018 14:45:28 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-5-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/71] vhost-net: compile it on all targets
 that have virtio-net.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> This shows a preexisting bug: if a KVM target did not have virtio-net e=
nabled,
> it would fail with undefined symbols when vhost was enabled.  This must=
 now
> be fixed, lest targets that have no virtio-net fail to compile.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure              | 11 ++++-------
>  hw/net/Makefile.objs   |  4 ++--
>  include/exec/poison.h  |  1 -
>  tests/Makefile.include |  5 +----
>  4 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
