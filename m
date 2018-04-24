Received: from eggs.gnu.org ([2001:4830:134:3::10]:36349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fB0fY-00014p-6M
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fB0fV-00028f-2e
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:19:52 -0400
References: <1524570294-23058-1-git-send-email-thuth@redhat.com>
	<d2a9fc1a-9696-f2bd-d603-03b23de62004@de.ibm.com>
	<87f6ba73-2ded-06f2-c68f-d8ef4be50edf@redhat.com>
	<20180424160911.22a238bb.cohuck@redhat.com>
	<6d699426-3525-f62a-c4ec-37dd5589654f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64848d8f-071d-e6c8-58a7-d1e74e93e4f0@redhat.com>
Date: Tue, 24 Apr 2018 18:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <6d699426-3525-f62a-c4ec-37dd5589654f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/s390x: Allow to configure the
 consoles with the "-serial" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 24/04/2018 16:22, Thomas Huth wrote:
> $ diff -u sclp-qom-tree-before.txt sclp-qom-tree-after.txt
> --- sclp-qom-tree-before.txt	2018-04-24 16:17:48.462849585 +0200
> +++ sclp-qom-tree-after.txt	2018-04-24 16:18:02.222820256 +0200
> @@ -1,13 +1,14 @@
> -(qemu) info qom-tree
> +(qemu) info qom-tree
>  /machine (s390-ccw-virtio-2.12-machine)
>    /unattached (container)
> -    /system[0] (qemu:memory-region)
>      /sysbus (System)
> -    /device[1] (virtio-net-ccw)
> +    /device[0] (qemu-s390x-cpu)
> +    /s390.ram[0] (qemu:memory-region)
> +    /device[1] (sclpconsole)
> +    /device[2] (virtio-net-ccw)
>        /virtio-backend (virtio-net-device)
>        /virtio-bus (virtio-ccw-bus)
> -    /s390.ram[0] (qemu:memory-region)
> -    /device[0] (qemu-s390x-cpu)
> +    /system[0] (qemu:memory-region)
>      /io[0] (qemu:memory-region)
>    /sclp (sclp)
>      /s390-sclp-event-facility (s390-sclp-event-facility)
> @@ -17,7 +18,6 @@
>    /s390-flic-qemu (s390-flic-qemu)
>    /s390-skeys (s390-skeys-qemu)
>    /peripheral-anon (container)
> -    /device[0] (sclpconsole)
>    /peripheral (container)
>    /s390-ipl (s390-ipl)
>    /virtual-css-bridge (virtual-css-bridge)
>=20
> ... the sclpconsole now shows up under /unattached instead of
> /peripheral-anon ... does that matter? (I don't have a clue)

If the devices are created in the same order, before and after the
patch, it should be okay.

/peripheral-anon is for devices that are created with -device but
without an "id" option.

Paolo
