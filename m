Received: from eggs.gnu.org ([2001:4830:134:3::10]:34720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erX7w-0002Vu-7S
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erX7v-0007Ar-Fh
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 17:56:40 -0500
References: <20180301163619.21072-1-pbonzini@redhat.com>
	<20180301163619.21072-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4709a16d-d8cd-08de-f160-cf246c1c1bfe@redhat.com>
Date: Thu, 1 Mar 2018 16:56:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180301163619.21072-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] qcow2: make qcow2_co_create2() a
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 03/01/2018 10:36 AM, Paolo Bonzini wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> qcow2_create2() calls qemu_co_mutex_lock().  Only a coroutine_fn may
> call another coroutine_fn.  In fact, qcow2_create2 is always called fro=
m
> coroutine context.
>=20
> Rename the function to add the "co" moniker and add coroutine_fn.
>=20
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20170705102231.20711-3-stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <1516279431-30424-3-git-send-email-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

More of the funny double-Message-Id/S-o-b.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
