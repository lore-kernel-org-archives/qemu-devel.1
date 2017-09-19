Received: from eggs.gnu.org ([2001:4830:134:3::10]:47848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1duK1r-0006MT-0T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1duK1n-0002IS-M3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1duK1n-0002HQ-Fy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:01:35 -0400
Date: Tue, 19 Sep 2017 11:01:33 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <198989559.17917520.1505833292987.JavaMail.zimbra@redhat.com>
In-Reply-To: <cfea9897-c831-acef-08b8-d7053c7760e2@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-4-marcandre.lureau@redhat.com>
	<09b52e82-484e-a840-7300-0fcd0f40d1d7@redhat.com>
	<cfea9897-c831-acef-08b8-d7053c7760e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/27] libvhost-user: improve
 vu_queue_pop() doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, changpeng liu <changpeng.liu@intel.com>, felipe@nutanix.com

Hi

----- Original Message -----
> On 09/19/2017 08:43 AM, Paolo Bonzini wrote:
> > On 23/08/2017 18:19, Marc-Andr=C3=A9 Lureau wrote:
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  contrib/libvhost-user/libvhost-user.h | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/contrib/libvhost-user/libvhost-user.h
> >> b/contrib/libvhost-user/libvhost-user.h
> >> index 53ef222c0b..9b9b00e191 100644
> >> --- a/contrib/libvhost-user/libvhost-user.h
> >> +++ b/contrib/libvhost-user/libvhost-user.h
> >> @@ -351,7 +351,8 @@ void vu_queue_notify(VuDev *dev, VuVirtq *vq);
> >>   * @vq: a VuVirtq queue
> >>   * @sz: the size of struct to return (must be >=3D VuVirtqElement)
> >>   *
> >> - * Returns: a VuVirtqElement filled from the queue or NULL.
> >> + * Returns: a VuVirtqElement filled from the queue or NULL. The
> >> + * returned element must be free() by the caller.
> >=20
> > Maybe free()-d or freed.
>=20
> Is it actually free(), or g_free()?

free(), libvhost-user itself is free of glib, and mostly of qemu headers.
