Received: from eggs.gnu.org ([2001:4830:134:3::10]:47163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMbFO-0004Is-0w
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMbFI-0007UH-0V
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:09:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMbFH-0007RB-PY
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 11:08:55 -0500
References: <20181109182153.5390-1-wainersm@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbde7c87-b0b2-becc-0176-609befb40e1a@redhat.com>
Date: Tue, 13 Nov 2018 10:08:40 -0600
MIME-Version: 1.0
In-Reply-To: <20181109182153.5390-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: crosa@redhat.com, philmd@redhat.com, ehabkost@redhat.com, lizhijian@cn.fujitsu.com, ccarrara@redhat.com

On 11/9/18 12:21 PM, Wainer dos Santos Moschetta wrote:
> QEMU used to exits with a not accurate error message when

s/exits/exit/
s/a not accurate/an inaccurate/

> an initrd > 2GiB was passed. That was fixed on patch:
>=20
> 	commit f3839fda5771596152b75dd1e1a6d050e6e6e380
> 	Author: Li Zhijian <lizhijian@cn.fujitsu.com>
> 	Date:   Thu Sep 13 18:07:13 2018 +0800
>=20
>      	change get_image_size return type to int64_t
>=20
> This change adds a regression test for that fix. It starts
> QEMU with a 2GiB dummy initrd, and check it evaluates the file

s/check/checks that/

> size correctly and prints accurate message.

s/accurate/an accurate/

>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
