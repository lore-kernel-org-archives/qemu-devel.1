Received: from eggs.gnu.org ([2001:4830:134:3::10]:54626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXrfR-0001Yw-4v
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXrfN-0005HI-54
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:17:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXrfM-0005GJ-VZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 12:17:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500448182-21376-1-git-send-email-armbru@redhat.com>
	<CAJ+F1C+tNiGEkzC3aBf=_92oxb7NvG+UeYaUPLy9vKY8ym936g@mail.gmail.com>
	<1500474339.29197.5.camel@redhat.com>
Date: Wed, 19 Jul 2017 18:17:32 +0200
In-Reply-To: <1500474339.29197.5.camel@redhat.com> (Gerd Hoffmann's message of
	"Wed, 19 Jul 2017 16:25:39 +0200")
Message-ID: <871spce6zn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] vnc: Clarify documentation of QMP command
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> The password would have to be NULL to disallow further login, is that
>> what your other series will allow to do?
>
> Disallow logins can be done using "expire-password vnc now".
>
> I think having multiple ways to archive the same thing is a bad idea
> from a security point of view, so I'd suggest to not touch the behavior
> of the various set-password command variants.

Makes sense.
