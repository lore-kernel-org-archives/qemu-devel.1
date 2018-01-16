Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKCu-0001FE-D0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKCr-0002uY-CK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:54:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ebKCr-0002tk-6S
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:54:45 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7FDFC00DB94
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:54:43 +0000 (UTC)
References: <1515594755-12138-1-git-send-email-thuth@redhat.com>
	<73e534aa-ba61-e3ca-6730-3382f1c1ce1a@redhat.com>
	<848373da-2010-d38b-fd88-91cd61dec91e@redhat.com>
	<28cccfd1-dca4-c074-0f74-1cf29c143a9c@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ad2d436f-aa43-f1e5-c32d-5f9e2c8887c4@redhat.com>
Date: Tue, 16 Jan 2018 13:54:39 +0800
MIME-Version: 1.0
In-Reply-To: <28cccfd1-dca4-c074-0f74-1cf29c143a9c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Allow hubports to connect to other
 netdevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>



On 2018=E5=B9=B401=E6=9C=8816=E6=97=A5 02:06, Thomas Huth wrote:
> On 15.01.2018 18:36, Thomas Huth wrote:
>> On 15.01.2018 08:40, Jason Wang wrote:
> [...]
>>> And since it was a hub, do we need to send to its netdev too inside
>>> net_hub_receive()?
>> I currently don't think so, but I'll check again...
> OK, I now think we're definitely fine here. The check is really just
> there to make sure that we do not send the packet back to the same
> sender. And I've checked with a command line like this that network
> traffic (TFTP booting in this case) works as expected:
>
> qemu-system-ppc64 -vga none -nographic \
>   -netdev user,id=3Ds1,tftp=3D/path/to/tftpdir,bootfile=3Dppc64.img \
>   -netdev hubport,hubid=3D1,id=3Dh1,netdev=3Ds1  \
>   -netdev hubport,hubid=3D1,id=3Dh3 -device virtio-net-pci,netdev=3Dh3 =
\
>   -boot n -object filter-dump,id=3Df1,netdev=3Ds1,file=3D/tmp/dump.dat
>
> Both, the behaviour of the TFTP boot in the guest and the wireshark dum=
p
> looked fine, there were no missing packets here.
>
>   Thomas

Right, I think I misread the command parameters.

Thanks
