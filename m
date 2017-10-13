Received: from eggs.gnu.org ([2001:4830:134:3::10]:38292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gmoro@suse.de>) id 1e30pJ-0002oB-AO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gmoro@suse.de>) id 1e30pF-0002ZH-BI
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:20:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gmoro@suse.de>) id 1e30pF-0002XG-4Z
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:20:33 -0400
From: Guilherme Moro <gmoro@suse.de>
Message-ID: <58f74661-3830-4127-e30b-37baebeba532@suse.de>
Date: Fri, 13 Oct 2017 15:20:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu-img convert to VMDK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Hi,

I'm trying to convert some images from raw to vmdk to run in a ESXi6.5=20
server but I need to rectify the image before being able to run.

The scenario goes like that:

qemu-img convert -f raw image.raw -O vmdk -o compat6 image.vmdk
ESXi complains with "Failed - File system specific implementation of=20
LookupAndOpen"[file] failed
running vmkfstools -x repair on the image make it bootable

 =C2=A0I checked the changes, vmkfstools is basically removing the second=
=20
descriptor from the end of the file, I'm not familiar enough with the=20
code and the format to know what this means, maybe compat6 should make=20
qemu-img avoid to put that in the end of the file (again, mostly guessing=
).

Anyway we would need an option to make sure that this second descriptor=20
does not end in the final image.

Can anyone advise on that ?

Thanks,

Guillherme
