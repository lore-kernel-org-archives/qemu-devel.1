Received: from eggs.gnu.org ([2001:4830:134:3::10]:54764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fs3ak-0002l2-EV
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fs3aj-00052R-EM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:08:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fs3aj-00051C-8Q
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:08:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50E994023132
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:08:48 +0000 (UTC)
Date: Tue, 21 Aug 2018 11:08:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180821100840.GI7370@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1534845930-14451-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1534845930-14451-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH] Remove deprecated -balloon option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Tue, Aug 21, 2018 at 12:05:30PM +0200, Thomas Huth wrote:
> The "-balloon" option has been replaced by "-device virtio-balloon".
> It's been marked as deprecated since two releases, and nobody
> complained, so let's remove it now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/virtio-balloon-stats.txt |  6 +++---
>  qemu-deprecated.texi          |  5 -----
>  qemu-options.hx               | 10 ----------
>  vl.c                          | 36 -----------------------------------=
-
>  4 files changed, 3 insertions(+), 54 deletions(-)

Confirmed that this is no longer used by libvirt, as we assume we have
new enough QEMU for -device

  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
> diff --git a/docs/virtio-balloon-stats.txt b/docs/virtio-balloon-stats.=
txt
> index 9985e1d..1732cc8 100644
> --- a/docs/virtio-balloon-stats.txt
> +++ b/docs/virtio-balloon-stats.txt
> @@ -61,9 +61,9 @@ It's also important to note the following:
>     respond to the request the timer will never be re-armed, which has
>     the same effect as disabling polling
> =20
> -Here are a few examples. QEMU is started with '-balloon virtio', which
> -generates '/machine/peripheral-anon/device[1]' as the QOM path for the
> -balloon device.
> +Here are a few examples. QEMU is started with '-device virtio-balloon'=
,
> +which generates '/machine/peripheral-anon/device[1]' as the QOM path f=
or
> +the balloon device.

We should try to get in the habit of changing the docs at the time we
deprecate stuff. I keep forgetting todo this myself too :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
