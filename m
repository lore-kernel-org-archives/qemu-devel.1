Received: from eggs.gnu.org ([2001:4830:134:3::10]:44782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjUM8-0001wZ-3b
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjUM5-0006Iv-92
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:17:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjUM5-0006IT-2t
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 12:17:29 -0500
Date: Thu, 2 Mar 2017 17:17:21 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170302171721.GG11445@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
	<148847375468.285.999031041241417996@0e2666bad730>
	<F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Eric Blake <eblake@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

On Thu, Mar 02, 2017 at 05:01:06PM +0000, Felipe Franciosi wrote:
> Hi Eric,
>=20
> Ping on this?
> http://lists.nongnu.org/archive/html/qemu-devel/2016-10/msg06169.html

[snip]

>       CC      contrib/ivshmem-client/main.o
>     /var/tmp/patchew-tester-tmp-naxuy_ku/src/contrib/libvhost-user/libv=
host-user.c: In function =E2=80=98vu_panic=E2=80=99:
>     /var/tmp/patchew-tester-tmp-naxuy_ku/src/contrib/libvhost-user/libv=
host-user.c:84:5: error: ignoring return value of =E2=80=98vasprintf=E2=80=
=99, declared with attribute warn_unused_result [-Werror=3Dunused-result]
>          (void)vasprintf(&buf, msg, ap);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors

You can side-step the issue entirely by simply not using the vasprintf
function. Instead do   'buf =3D g_strdup_vprintf(msg, ap);' - glib does
abort-on-oom, so there's no error scenario you need to handle.

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
