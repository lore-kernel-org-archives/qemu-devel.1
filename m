Received: from eggs.gnu.org ([2001:4830:134:3::10]:46912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGjAR-0002BH-3E
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGjAQ-00035n-9P
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:46:51 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dGjAP-00030m-UB
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:46:50 -0400
Received: by mail-lf0-x243.google.com with SMTP id h4so6253122lfj.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 02:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-2-marcandre.lureau@redhat.com>
	<465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
	<0a434f41-1131-713d-1fc9-a9edba425f7a@redhat.com>
In-Reply-To: <0a434f41-1131-713d-1fc9-a9edba425f7a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 02 Jun 2017 09:46:35 +0000
Message-ID: <CAJ+F1CKL6OXetG6Liwf3NrpNv3K8PR6_SQ5=rfjyRwa3pJ7nuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] dump: add DumpInfo structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Wen Congyang <wency@cn.fujitsu.com>
Cc: anderson@redhat.com

Hi

On Thu, Jun 1, 2017 at 10:19 PM Eric Blake <eblake@redhat.com> wrote:

> On 06/01/2017 01:06 PM, Laszlo Ersek wrote:
> > On 06/01/17 15:03, Marc-Andr=C3=A9 Lureau wrote:
> >> One way or another, the guest could communicate various dump info (via
> >> guest agent or vmcoreinfo device) and populate that structure. It can
> >> then be used to augment the dump with various details, as done in the
> >> following patch.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  include/sysemu/dump-info.h | 18 ++++++++++++++++++
> >>  dump.c                     |  3 +++
> >>  2 files changed, 21 insertions(+)
> >>  create mode 100644 include/sysemu/dump-info.h
> >>
> >> diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-info.h
> >> new file mode 100644
> >> index 0000000000..d2378e15e2
> >> --- /dev/null
> >> +++ b/include/sysemu/dump-info.h
> >> @@ -0,0 +1,18 @@
> >> +#ifndef DUMP_INFO_H
> >> +#define DUMP_INFO_H
>
> >>
> >
> > Can you please spell out, in the commit message, the reason for
> > introducing a new header file? (I suspect your reason, but it should be
> > documented explicitly.)
>
> Also, should you have a copyright header in the new file?  And does
> MAINTAINERS cover it?
>

None of the dump support is covered. Based on commit history, I can suggest
Wen Congyang, as original author.
Sadly, Qiao Nuohan cannot be reached with his mail today (anyone knows if
he is still contributing?). Laszlo has done significant changes and reviews
too. I can also propose myself to help with reviews.

Wen or Laszla, do you want to be the main maintainer?
--=20
Marc-Andr=C3=A9 Lureau
