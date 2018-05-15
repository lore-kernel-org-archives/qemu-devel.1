Received: from eggs.gnu.org ([2001:4830:134:3::10]:57982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIbc4-0003Hm-SG
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIbc0-0000aN-H6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:40 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIbc0-0000Zk-8Y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:11:36 -0400
Received: by mail-wr0-x242.google.com with SMTP id v5-v6so522557wrf.9
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 08:11:35 -0700 (PDT)
References: <20180515134950.3755-1-muriloo@linux.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180515134950.3755-1-muriloo@linux.ibm.com>
Date: Tue, 15 May 2018 16:11:33 +0100
Message-ID: <874lj9eyxm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] HACKING: document preference for g_new
 instead of g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:

> This patch documents the preference for g_new instead of g_malloc. The
> reasons were adapted from commit b45c03f585ea9bb1af76c73e82195418c294919d.
>
> Discussion in QEMU's mailing list:
>   http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg03238.html
>
> Cc: qemu-devel@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  HACKING | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/HACKING b/HACKING
> index 4125c97d8d..0fc3e0fc04 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -118,6 +118,15 @@ Please note that g_malloc will exit on allocation fa=
ilure, so there
>  is no need to test for failure (as you would have to with malloc).
>  Calling g_malloc with a zero size is valid and will return NULL.
>
> +Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
> +reasons:
> +
> +  a. It catches multiplication overflowing size_t;
> +  b. It returns T * instead of void *, letting compiler catch more type
> +     errors.
> +
> +Declarations like T *v =3D g_malloc(sizeof(*v)) are acceptable, though.
> +
>  Memory allocated by qemu_memalign or qemu_blockalign must be freed with
>  qemu_vfree, since breaking this will cause problems on Win32.


--
Alex Benn=C3=A9e
