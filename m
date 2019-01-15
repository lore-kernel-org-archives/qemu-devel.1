Received: from eggs.gnu.org ([209.51.188.92]:38119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjUAr-00088j-4N
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjUAl-0001Ck-73
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:55 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:40028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gjUAh-00019v-Ae
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:14:47 -0500
Received: by mail-io1-f44.google.com with SMTP id k2so2953970iog.7
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 11:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20190115184229.73688-1-emaste@freefall.freebsd.org>
	<CAJ+F1CKEhb0hKSvbwYfjEojqJ9K8Jbtit5oW8CTBmcSHSjVrNg@mail.gmail.com>
In-Reply-To: <CAJ+F1CKEhb0hKSvbwYfjEojqJ9K8Jbtit5oW8CTBmcSHSjVrNg@mail.gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Tue, 15 Jan 2019 14:14:30 -0500
Message-ID: <CAPyFy2C9RDsq21h-b8w+QULzr3H-GSFE80LkkS_g7WHs6BcPdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 15 Jan 2019 at 13:59, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Jan 15, 2019 at 10:42 PM Ed Maste <emaste@freefall.freebsd.org> w=
rote:
> >
> > From: Ed Maste <emaste@freebsd.org>
> >
> > Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which supports
> > several platforms, including FreeBSD.  Later on we could build for othe=
r
> > hosts in Cirrus-CI, but I'm starting with only FreeBSD as it is not
> > supported by other CI services.
>
> Although I have never tested it, gitlab CI supports FreeBSD, macosx, wind=
ows...

I haven't looked into it in great detail. As far as I can tell it
supports running tests on a provided FreeBSD instance via
gitlab-runner, and is not a fully hosted CI service like Cirrus-CI,
Travis, etc.

> What about patchew?

I'm also not very familiar with patchew. I did look at the three VM
BSD scripts (tests/vm/*bsd) reported in my Cirrus-CI thread, but am
not sure how they're invoked or how results are reported.
