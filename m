Received: from eggs.gnu.org ([2001:4830:134:3::10]:58130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4SBh-0006dC-Ag
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4SBe-0003GN-5z
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:17:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59524 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f4SBe-0003Dq-0P
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 10:17:54 -0400
References: <1523021879-25807-1-git-send-email-thuth@redhat.com>
	<1523021879-25807-2-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53b776ad-a1c9-29a3-e5de-6cf4528b49f4@redhat.com>
Date: Fri, 6 Apr 2018 16:17:40 +0200
MIME-Version: 1.0
In-Reply-To: <1523021879-25807-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.13 1/3] net: Remove the deprecated
 "vlan" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 06/04/2018 15:37, Thomas Huth wrote:
> It's been marked as deprecated since QEMU v2.9.0, so that should have
> been enough time for everybody to switch to the modern -device + -netde=
v
> syntax for connecting guest NICs with host network backends, or to swit=
ch
> to the "hubport" netdev in case hubs are really wanted instead.

... or to just drop unnecessary "vlan=3D0", which is the really common ca=
se.

>=20
>  # @NetdevL2TPv3Options:
>  #
> -# Connect the VLAN to Ethernet over L2TPv3 Static tunnel
> +# Configure an Ethernet over L2TPv3 Static tunnel.
>  #

Since you are at it, probably remove "Static"?  I don't see the point
really.

> or the netdev 'nd' (for pluggable\n"
> "                NICs please use '-device devtype,netdev=3Dnd' instead)=
\n"

Maybe remove this if -net is prominently marked deprecated?  And mention
using -nic instead of "-net nic,netdev=3D...".

Paolo

> Buglink: https://bugs.launchpad.net/qemu/+bug/658904
> Signed-off-by: Thomas Huth <thuth@redhat.com>
