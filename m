Received: from eggs.gnu.org ([2001:4830:134:3::10]:49340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxasv-0004IL-BQ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fxasr-0004Cq-An
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:42:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fxasr-00049p-5h
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:42:25 -0400
References: <c9da5617-ddd8-d122-20c4-79b0bd92c176@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf7ed9fa-da74-b6ce-8f3a-d2587b5555d4@redhat.com>
Date: Wed, 5 Sep 2018 11:42:23 -0500
MIME-Version: 1.0
In-Reply-To: <c9da5617-ddd8-d122-20c4-79b0bd92c176@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Subject: [RFC PATCH v2] migration: calculate
 remaining pages accurately during the bulk stage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Quan Xu <quan.xu0@gmail.com>, kvm <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com

On 09/05/2018 09:17 AM, Quan Xu wrote:
>  From 7de4cc7c944bfccde0ef10992a7ec882fdcf0508 Mon Sep 17 00:00:00 2001
> From: Quan Xu <quan.xu0@gmail.com>
> Date: Wed, 5 Sep 2018 22:06:58 +0800
> Subject: [RFC PATCH v2] migration: calculate remaining pages accurately=
=20
> during the bulk stage
>=20
> Since the bulk stage assumes in (migration_bitmap_find_dirty) that ever=
y
> page is dirty, initialize the number of dirty pages at the beggining of

s/beggining/beginning/

> the iteration and then decrease it for each processed page.
>=20
> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> ---
>  =C2=A0migration/ram.c | 7 ++++++-
>  =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
