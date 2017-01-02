Received: from eggs.gnu.org ([2001:4830:134:3::10]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cO7Xe-0007x8-4R
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cO7Xb-0005G5-28
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:41:06 -0500
Received: from mail-co1nam03on0099.outbound.protection.outlook.com
	([104.47.40.99]:2959
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1cO7Xa-0005Fx-Fv
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 13:41:02 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Mon, 2 Jan 2017 18:07:35 +0000
Message-ID: <32782693-D91F-4920-82B5-FBE7AC22B739@nutanix.com>
References: <1482358659-4288-1-git-send-email-felipe@nutanix.com>
	<1482358659-4288-3-git-send-email-felipe@nutanix.com>
	<71ac8a1a-e527-0f99-120d-ad8386eecc8f@redhat.com>
In-Reply-To: <71ac8a1a-e527-0f99-120d-ad8386eecc8f@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28D99AFA6960154EBC40A2248CED16E6@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/3] vus: Introduce vhost-user-scsi host
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 2 Jan 2017, at 10:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> On 21/12/2016 23:17, Felipe Franciosi wrote:
>> To use it, one must configure Qemu with --enable-vhost-user-scsi and
>> start Qemu with a command line equivalent to:
>>=20
>> qemu-system-x86_64 \
>>       -chardev socket,id=3Dvus0,path=3D/tmp/vus.sock \
>>       -device vhost-user-scsi-pci,chardev=3Dvus0,bus=3Dpci.0,addr=3D...
>>=20
>> A separate commit presents a sample application linked with libiscsi to
>> provide a backend for vhost-user-scsi.
>=20
> Please place CONFIG_VHOST_USER_SCSI=3D$(CONFIG_POSIX) symbol in
> default-configs/ (so that it is enabled by default on non-Windows hosts)
> instead of having the configure option.  Otherwise, the patches look good=
!

Thanks, will do that and send a v4.

Do you want any entries on MAINTAINERS for this code or are you happy to ta=
ke care of it under hw/scsi/* ?

Felipe

>=20
> Paolo
