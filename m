Received: from eggs.gnu.org ([2001:4830:134:3::10]:58346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvUQ-0004Lf-6w
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvUL-00086B-CT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:10:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTvUL-00084Y-3E
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:10:45 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-2-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78d5d925-8115-2ec2-d293-b9a0099caa85@redhat.com>
Date: Mon, 3 Dec 2018 15:10:42 -0600
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/71] vhost-net: move stubs to a separate
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 12/3/18 9:32 AM, Paolo Bonzini wrote:
> There is no reason for CONFIG_VHOST_NET to be specific to a single targ=
et;
> it is a host feature that can be add to all targets, as long as they su=
pport

s/add/added/

> the virtio-net device.  Currently CONFIG_VHOST_NET depends on CONFIG_KV=
M,
> but ioeventfd support is present in the core memory API and works with
> other accelerators as well.
>=20
> As a first step, move the vhost-net stubs to a separate file.  Later, t=
hey
> will become conditional on CONFIG_VIRTIO_NET, which is not available in=
 .c
> files.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/net/Makefile.objs    |  4 ++-
>   hw/net/vhost_net-stub.c | 95 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   hw/net/vhost_net.c      | 74 --------------------------------------
>   3 files changed, 98 insertions(+), 75 deletions(-)
>   create mode 100644 hw/net/vhost_net-stub.c
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
