Received: from eggs.gnu.org ([2001:4830:134:3::10]:44972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6a3E-00050I-0w
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6a39-000601-6s
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:01:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6a39-0005zQ-0i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:01:23 -0400
Message-ID: <1493978479.371.82.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 05 May 2017 12:01:19 +0200
In-Reply-To: <CA+fj4vkysW7iJ4WCLdK-Z9J6MX2pfEZKZyWwFoEbiaOsAre8Ww@mail.gmail.com>
References: <20170505075918.4033-1-philippevoinov@gmail.com>
	<1493973586.371.65.camel@redhat.com>
	<CA+fj4vkysW7iJ4WCLdK-Z9J6MX2pfEZKZyWwFoEbiaOsAre8Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ui: input-linux: Add absolute event support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe Voinov <philippevoinov@gmail.com>
Cc: qemu-devel@nongnu.org

  Hi,

> Aside from that, trying to change ui/input.c is probably a bad idea.
> The code
> there expects absolute input values to start at 0. To use the full 32
> bits of
> an int would require absolute axes to have a different starting
> position. This
> would require large changes to ui/input.c and possibly also other code
> using
> it.

No.  Internally qemu uses 0 ... INPUT_EVENT_ABS_SIZE.

So only qemu_input_queue_abs() and qemu_input_scale_axis() would need to
be changed, all other code wouldn't notice.

While being at it it probably makes sense to add support for min !=3D 0,
i.e. replace size_in with min_in and max_in in qemu_input_scale_axis, so
you can just pass min + max directly and have the generic input.c code
do the calculations for you.

cheers,
  Gerd
