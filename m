Received: from eggs.gnu.org ([2001:4830:134:3::10]:57235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGngl-0005MI-W4
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGngl-0004XA-0H
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:36:31 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dGngk-0004WR-P3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:36:30 -0400
Received: by mail-lf0-x242.google.com with SMTP id f14so4876186lfe.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 07:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
	<20170602142445.GD11096@redhat.com>
In-Reply-To: <20170602142445.GD11096@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 02 Jun 2017 14:36:18 +0000
Message-ID: <CAJ+F1CJEzb2XsdpXnq1xp4gerQaNLcZqsfzBMac19b1kuBiS8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/9] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

On Fri, Jun 2, 2017 at 6:25 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> On Fri, Jun 02, 2017 at 06:12:20PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Add a new Linux-specific memory backend, similar to hostmem-file,
> > except that it doesn't need file path. It also try to enforce memory
> > sealing if available. It is thus slightly easier and secure, and is
> > compatible with transparent huge-pages since Linux 4.8.
>
> What about explicit huge pages ?  They are the key scenario scenario wher=
e
> libvirt uses hostmem-file.  AFAICT, there's no way to request explicit
> huge pages with memfd_create() syscall :-(
>

 Sadly, I don't think it's yet possible either.
--=20
Marc-Andr=C3=A9 Lureau
