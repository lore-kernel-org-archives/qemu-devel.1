Received: from eggs.gnu.org ([2001:4830:134:3::10]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1epEGR-0007Ij-H8
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1epEGM-0001gj-GB
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:23:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1epEGM-0001fv-Al
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:23:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D82040FB646
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 14:23:46 +0000 (UTC)
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<20180215212552.26997-4-marcandre.lureau@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <cf62af9e-39f8-deeb-0465-118a9547c212@redhat.com>
Date: Fri, 23 Feb 2018 15:23:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180215212552.26997-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] vhost-user-test: add back memfd check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com



On 02/15/2018 10:25 PM, Marc-Andr=C3=A9 Lureau wrote:
> This revert commit fb68096da3d35e64c88cd610c1fa42766c58e92a, and
> modify test_read_guest_mem() to use different chardev names, when
> using memfd (_test_server_free(), where the chardev is removed, runs
> in idle).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau<marcandre.lureau@redhat.com>
> ---
>   tests/vhost-user-test.c | 93 +++++++++++++++++++++++++++++++++++-----=
---------
>   1 file changed, 66 insertions(+), 27 deletions(-)

Looks good to me:
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime
