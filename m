Received: from eggs.gnu.org ([2001:4830:134:3::10]:48617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUmTd-00031a-Vn
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUmTZ-0002tf-QT
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUmTZ-0002se-Fx
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 00:45:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-4-marcandre.lureau@redhat.com>
Date: Thu, 06 Dec 2018 06:45:18 +0100
In-Reply-To: <20181205203737.9011-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 6 Dec 2018 00:37:33 +0400")
Message-ID: <87o99zky35.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 3/7] char: add a
 QEMU_CHAR_FEATURE_GCONTEXT flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> QEMU_CHAR_FEATURE_GCONTEXT declares the character device can switch
> GMainContext.
>
> Assert we don't switch context when the character device doesn't
> provide this feature.  Character device users must not violate this
> restriction.  In particular, user configurations that violate them
> must be rejected.
>
> Existing frontend that rely on context switching would now assert() if
> the backend doesn't allow it (instead of silently producing undesired
> events in the default context). Following patches improve the
> situation by reporting an error earlier instead, on the frontend side.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
