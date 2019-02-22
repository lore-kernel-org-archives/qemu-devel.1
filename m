Received: from eggs.gnu.org ([209.51.188.92]:44119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxEcq-0003xW-Kg
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxEcp-0003Jf-Aw
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:28:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gxEcp-0002qw-3M
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:28:39 -0500
References: <1548638112-31101-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1548638112-31101-2-git-send-email-lizhijian@cn.fujitsu.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <8b018aae-cd25-0b1b-6b6d-2ff176bd8be4@redhat.com>
Date: Fri, 22 Feb 2019 12:28:18 -0500
MIME-Version: 1.0
In-Reply-To: <1548638112-31101-2-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Acceptance tests: expect boot to
 extract 2GiB+ initrd with linux-v4.16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>



On 1/27/19 8:15 PM, Li Zhijian wrote:
> XLF_CAN_BE_LOADED_ABOVE_4G is set on vmlinuz shipped by Fedora-28 so th=
at
> it's allowed to be loaded below 4 GB address.
>=20
> timeout is updated to 5 minutes as well since we need more time to load=
 a
> large initrd to the guest
>=20
> CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
> CC: Caio Carrara <ccarrara@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
