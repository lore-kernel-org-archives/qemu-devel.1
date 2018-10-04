Received: from eggs.gnu.org ([2001:4830:134:3::10]:33984)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g7y5M-00020N-WB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 03:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g7y5F-0006gA-16
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 03:30:10 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:43046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g7y5E-0006cj-F9
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 03:30:04 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
Received: by mail-vs1-f50.google.com with SMTP id e206so4816434vsd.0
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 00:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180919080421.24011-1-cst@tolva.net>
	<20180919080421.24011-2-cst@tolva.net>
	<6b1dc4e9-16a6-192e-d765-0ada72c57324@vivier.eu>
	<58cd8cee-92bb-5dde-bcd1-1936417a6e0b@vivier.eu>
	<CALQmfgM1Ntp-ER0744BBOci-ux8Xow_STTLT5dmn5iiAu5=sCw@mail.gmail.com>
	<e0b7653f-9169-64e3-ab0f-a002efa836ba@vivier.eu>
In-Reply-To: <e0b7653f-9169-64e3-ab0f-a002efa836ba@vivier.eu>
From: =?UTF-8?Q?Cortland_Setlow_T=C3=B6lva?= <cst@tolva.net>
Date: Thu, 4 Oct 2018 00:29:47 -0700
Message-ID: <CAGbDXhQTPyeqLnHZ_nre=_Wgm7-W76mzKwm0trNymf=JEOqGZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] Check for Linux USBFS in configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: laurent@vivier.eu
Cc: cst@tolva.net, qemu-devel@nongnu.org, pbonzini@redhat.com

Hi Laurent,

The deeper view on part 3 can wait - I have found an issue with 64-bit
hosts.  In linux-user/syscall_defs.h the references to struct usbdevfs_urb
and so forth are incorrect and I need to define struct target_usbdevfs_urb
for the size and the ioctl code to be calculated with the target's ABI.

I will send updated patches.

--CST

On Mon, Sep 24, 2018 at 10:22 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 23/09/2018 =C3=A0 06:44, Blake T=C3=B6lva a =C3=A9crit :
> > Thanks Laurent, I have updated the patch.  Should I resend the whole
> > series to the list?
>
> yes.
>
> > I believe the third patch may also need revision as the call to
> > thunk_convert at the end
> > of do_ioctl_usbdevfs_reapurb seems clunky.  Would love some comments.
> >
> I didn't read your comment before reviewing this patch. I'm going to
> have deeper view on this part.
>
> Thanks,
> Laurent
>
