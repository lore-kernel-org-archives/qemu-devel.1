Received: from eggs.gnu.org ([2001:4830:134:3::10]:56133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcelaya@gmail.com>) id 1csSrQ-000455-Pk
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcelaya@gmail.com>) id 1csSrO-0006NB-Vr
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:30:56 -0400
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:38257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcelaya@gmail.com>) id 1csSrO-0006Mn-OU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:30:54 -0400
Received: by mail-it0-x232.google.com with SMTP id y18so48789834itc.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 04:30:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490609499.31035.29.camel@redhat.com>
References: <20170326095349.8571-1-jcelaya@gmail.com>
	<1490609499.31035.29.camel@redhat.com>
From: Javier Celaya <jcelaya@gmail.com>
Date: Mon, 27 Mar 2017 13:30:33 +0200
Message-ID: <CAE6Ev=yhEbRW1-SVgVJ3RLiEetgfPQ7yX9L13jGFPS4VJr_OwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] Fix input-linux reading from device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

Javi

2017-03-27 12:11 GMT+02:00 Gerd Hoffmann <kraxel@redhat.com>:

> On So, 2017-03-26 at 11:53 +0200, Javier Celaya wrote:
> > The evdev devices in input-linux.c are read in blocks of one whole
> > event. If there are not enough bytes available, they are discarded,
> > instead of being kept for the next read operation. This results in
> > lost events, of even non-working devices.
>
> Have you seen this happening in practice?
>

Yes, quite frequently, like once per hour. Totally destroys a good gaming
session :)
The curious thing is, the mouse stops working, but in the keyboard I see
some missing keyup events (the keys get stuck), but then it recovers.


>
> > +    struct input_event event;
> > +    int         to_be_read;
>
> I'd suggest to store offset (i.e. bytes already read) instead, should
> make the whole logic a bit simpler and easier to read.
>

OK


>
> > +            } else if (rc > 0){
>
> checkpatch.pl complains here:
> ERROR: space required before the open brace '{'
>

Oops, missed that


>
> cheers,
>   Gerd
>
>
