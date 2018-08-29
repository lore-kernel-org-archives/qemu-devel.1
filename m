Received: from eggs.gnu.org ([2001:4830:134:3::10]:49881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fv0hv-0007dK-DV
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fv0ht-0008OO-Kg
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:40:27 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fv0ht-0008NX-Cs
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:40:25 -0400
Received: by mail-wm0-x242.google.com with SMTP id j192-v6so5609309wmj.1
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 06:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-5-marcandre.lureau@redhat.com>
	<20180827045602.GF3020@xz-x1>
	<87a7p6mr3e.fsf@dusky.pond.sub.org> <20180829004237.GG4446@xz-x1>
	<87r2ihh7qg.fsf@dusky.pond.sub.org> <20180829102102.GA9942@xz-x1>
	<87ftyx9whk.fsf@dusky.pond.sub.org>
In-Reply-To: <87ftyx9whk.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 29 Aug 2018 15:40:12 +0200
Message-ID: <CAJ+F1C+YfCH90tF_nAU9XmyL5cQC=6MSQrxEG-orvsx-hQ8rdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/9] monitor: no need to save need_resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Wed, Aug 29, 2018 at 2:51 PM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> > So I think now I agree with you that the response queue is not
> > required if we think the first solution is okay for us.
>
> Cool.  Can you explore that and post patches?
>

As we agree to drop the response queue, I am sending rebased v4, with
qga fixes and r-b from Michael, and tests splitted.

thanks

--=20
Marc-Andr=C3=A9 Lureau
