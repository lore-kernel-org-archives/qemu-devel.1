Received: from eggs.gnu.org ([209.51.188.92]:37003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJzZz-0008W0-Az
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJzMd-0001kN-Pe
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:50:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJzMd-0001jU-E2
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:49:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id y5so3000151wma.2
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 04:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
In-Reply-To: <20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 Apr 2019 13:49:46 +0200
Message-ID: <CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/11] vhost-user: add
 vhost_user_gpu_set_socket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Fri, Apr 26, 2019 at 9:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Apr 23, 2019 at 03:19:58PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Add a new vhost-user message to give a unix socket to a vhost-user
> > backend for GPU display updates.
>
> Can you split input/gpu into two patch series?
>
> > +Wire format
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Unless specified differently, numbers are in the machine native byte
> > +order.
> > +
> > +A vhost-user-gpu request consists of 2 header fields and a payload.
> > +
> > ++---------+------+---------+
> > +| request | size | payload |
> > ++---------+------+---------+
> > +
> > +Header
> > +------
> > +
> > +:request: ``u32``, type of the request
> > +
> > +:size: ``u32``, size of the payload
> > +
> > +A reply consists only of a payload, whose content depends on the reque=
st.
>
> I'd suggest to use the same format for replies, only with "request"
> meaning "status" in replies.  Allows for OK/ERROR status in replies,
> and having a size field in replies too should make things more robust.
> Also allows for an empty reply (status=3Dok,size=3D0).


That brings more questions and ambiguity imho.

Can we leave that for future protocol extensions negotiated with
GET/SET_PROTOCOL_FEATURES ?



--
Marc-Andr=C3=A9 Lureau
