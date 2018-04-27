Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBzIz-0000z5-FG
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBzIt-0001xU-MK
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:04:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBzIt-0001xK-Ge
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:04:31 -0400
Date: Fri, 27 Apr 2018 10:04:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180427090418.GC32172@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-4-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524666934-8064-4-git-send-email-lidongchen@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration: remove unnecessary
 variables len in QIOChannelRDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, dgilbert@redhat.com, galsha@mellanox.com, adido@mellanox.com, aviadye@mellanox.com, qemu-devel@nongnu.org, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Wed, Apr 25, 2018 at 10:35:32PM +0800, Lidong Chen wrote:
> Because qio_channel_rdma_writev and qio_channel_rdma_readv maybe invoke=
d
> by different threads concurrently, this patch removes unnecessary varia=
bles
> len in QIOChannelRDMA and use local variable instead.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
>  migration/rdma.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
