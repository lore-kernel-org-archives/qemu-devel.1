Received: from eggs.gnu.org ([2001:4830:134:3::10]:57138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dVHkJ-0003Da-Dz
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dVHkG-0001RD-7o
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dVHkG-0001Q1-2F
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:32:00 -0400
Message-ID: <1499866298.6112.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 12 Jul 2017 15:31:38 +0200
In-Reply-To: <1499847753-8513-1-git-send-email-thuth@redhat.com>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, 2017-07-12 at 10:22 +0200, Thomas Huth wrote:
> We don't want to carry along old machine types forever. If we are
> able to
> remove the pc machines up to 0.13 one day for example, this would
> allow
> us to eventually kill the code for rombar=3D0 (i.e. where QEMU copies
> ROM
> BARs directly to low memory). Everything up to pc-1.2 is also known
> to
> have issues with migration.=C2=A0 So let's start with a deprecation
> message
> for the old machine types so that the (hopefully) few users of these
> old
> systems start switching over to newer machine types instead.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
