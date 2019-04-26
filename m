Received: from eggs.gnu.org ([209.51.188.92]:51893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvLz-0006q6-NO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvE7-0003gV-Ka
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJvE6-0003d4-Ow
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:24:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A9B1308B79B
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:24:52 +0000 (UTC)
Date: Fri, 26 Apr 2019 09:24:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190423132004.13725-6-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/11] vhost-user: add
 vhost_user_gpu_set_socket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, Apr 23, 2019 at 03:19:58PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a new vhost-user message to give a unix socket to a vhost-user
> backend for GPU display updates.

Can you split input/gpu into two patch series?

> +Wire format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Unless specified differently, numbers are in the machine native byte
> +order.
> +
> +A vhost-user-gpu request consists of 2 header fields and a payload.
> +
> ++---------+------+---------+
> +| request | size | payload |
> ++---------+------+---------+
> +
> +Header
> +------
> +
> +:request: ``u32``, type of the request
> +
> +:size: ``u32``, size of the payload
> +
> +A reply consists only of a payload, whose content depends on the reque=
st.

I'd suggest to use the same format for replies, only with "request"
meaning "status" in replies.  Allows for OK/ERROR status in replies,
and having a size field in replies too should make things more robust.
Also allows for an empty reply (status=3Dok,size=3D0).

cheers,
  Gerd
