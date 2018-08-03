Received: from eggs.gnu.org ([2001:4830:134:3::10]:51149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fldGD-00085Y-7v
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 12:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fldG8-0008C6-Bk
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 12:49:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fldG8-0008AK-2l
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 12:49:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w73GdNHm021037
	for <qemu-devel@nongnu.org>; Fri, 3 Aug 2018 12:48:58 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kmqjfrw31-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 12:48:58 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 3 Aug 2018 12:48:56 -0400
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 3 Aug 2018 12:48:52 -0400
MIME-Version: 1.0
In-Reply-To: <20180803153235.4134-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <4b308828-b836-b810-b7b9-2a9893dd7218@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix crashes upon warm reboot
 with vga mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 08/03/2018 11:32 AM, Marc-Andr=C3=A9 Lureau wrote:
> With vga=3D775 on the Linux command line a first boot of the VM running
> Linux works fine. After a warm reboot it crashes during Linux boot.
>
> Before that, valgrind points out bad memory write to console
> surface. The VGA code is not aware that virtio-gpu got a message
> surface scanout when the display is disabled. Let's reset VGA graphic
> mode when it is the case, so that a new display surface is created
> when doing further VGA operations.
>
> https://bugs.launchpad.net/qemu/+bug/1784900/
>
> Reported-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
