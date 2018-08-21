Received: from eggs.gnu.org ([2001:4830:134:3::10]:56430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs3cp-00059c-MC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fs3co-0006wn-RW
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:10:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fs3co-0006wF-Kx
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 06:10:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id k5-v6so3827441wre.10
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 03:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<CAJ+F1CKHrOyD91HLk16eQFjV4JfWpH6poq_Svdihav15kJ62yw@mail.gmail.com>
	<20180821075130.tlqk6hv2dbry2iem@sirius.home.kraxel.org>
In-Reply-To: <20180821075130.tlqk6hv2dbry2iem@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Aug 2018 12:10:46 +0200
Message-ID: <CAJ+F1CLboeQZXWs5gVoc+Ugwq6A7bGdQ=Twg05i_1iXg445oEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/29] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Aug 21, 2018 at 9:51 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Feedback welcome,
> >
> > ping
>
> Cherry-picked two patches for the ui pull request.

thanks

>
> What is the plan for the command line handling, specifically the patch
> tagged with HACK?

The RFC libvirt series doesn't use it.

However, it's very convenient for qemu command line users. Daniel
doesn't want g_shell_parse_argv(), but he would like the -object json:
command line form instead. I don't know what is the status about
supporting that syntax.

You may skip patch 9 & 10 for review & merge. But for easy testing, I
recommend to use them atm :)

thanks



--
Marc-Andr=C3=A9 Lureau
