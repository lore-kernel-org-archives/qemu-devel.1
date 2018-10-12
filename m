Received: from eggs.gnu.org ([2001:4830:134:3::10]:52646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAsgV-0008Uo-NZ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gAsgP-00017P-L2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:20:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gAsgI-0000x4-9w
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:20:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80D2E307D86F
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 08:20:18 +0000 (UTC)
Date: Fri, 12 Oct 2018 09:20:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181012082011.GS16720@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/11] chardev: Convert IO handlers to
 use unsigned type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org

On Fri, Oct 12, 2018 at 02:22:06AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Paolo,
>=20
> Here are the changes you suggested in
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02294.html
>=20
> First two simple cleanups while here,
> then slowly convert backends then frontends.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (11):
>   hw/ipmi: Remove unnecessary declarations
>   target/xtensa: Remove unnecessary declarations
>   chardev: Simplify IOWatchPoll::fd_can_read as a GSourceFunc
>   chardev: Assert backend's chr_can_read() is positive
>   chardev: Let chr_sync_read() use unsigned type
>   chardev: Let chr_write use unsigned type
>   chardev: Let IOReadHandler use unsigned type
>   chardev: Let IOCanReadHandler use unsigned type
>   chardev: Let qemu_chr_fe_* use unsigned type
>   chardev: Let qemu_chr_be_* use unsigned type
>   chardev: FDChardev::max_size be unsigned

s/unsigned/size_t/ in all these commit messages, as it looked
like you meant 'unsigned int' with the current commit msg.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
