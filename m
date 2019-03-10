Received: from eggs.gnu.org ([209.51.188.92]:44540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1h2wmP-00077S-OW
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1h2wbi-0003qV-2N
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:27:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1h2wbh-0003nk-41
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 07:27:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id t206so1508966oib.3
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 04:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
	<20181121115718.GN26577@redhat.com>
	<20181121072237-mutt-send-email-mst@kernel.org>
	<60500f8b-47e8-c530-076a-d7f14d0f0ee5@redhat.com>
	<20181121123929-mutt-send-email-mst@kernel.org>
	<bf59e483-d958-29ac-5e17-50f56405c629@redhat.com>
In-Reply-To: <bf59e483-d958-29ac-5e17-50f56405c629@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 10 Mar 2019 19:26:26 +0800
Message-ID: <CAKXe6SLDcOJx+x_5wod6Pvy1oASEEQ06fbMDrWQnQg31FbQ_VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

Hi Jason,

What's the status of this patch? I don't see it in upstream.

Thanks,
Li Qiang

Jason Wang <jasowang@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8822=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:22=E5=86=99=E9=81=93=EF=BC=9A

>
> On 2018/11/22 =E4=B8=8A=E5=8D=881:39, Michael S. Tsirkin wrote:
> > On Wed, Nov 21, 2018 at 11:30:41AM -0600, Eric Blake wrote:
> >> On 11/21/18 6:23 AM, Michael S. Tsirkin wrote:
> >>
> >>>> I agree it is good to preserve fcntl flags though, so this patch
> >>>> looks desirable.
> >>>>
> >>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>> Sure
> >>>
> >>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>>
> >>> but really not for this release I guess as we are in freeze.
> >> We're in freeze, so the criteria is: Does this fix a bug that we would
> >> otherwise not want in 3.1.  If the code is pre-existing (that is, if
> 3.0 was
> >> released with the same problem), or then delaying the patch to 4.0 is =
an
> >> easier call to make.  If the problem is new to 3.1, then fixing it for
> -rc3
> >> is still reasonable with maintainer discretion (although once -rc3
> lands, we
> >> want as little as possible to go into -rc4, even if our track record
> says we
> >> will be unable to avoid -rc4 altogether).
> >>
> >> I think that losing flags is likely enough to be a noticeable bug wort=
h
> >> fixing for 3.1, but I did not research when the problem was introduced=
,
> so I
> >> don't have a strong preference for 3.1 vs. 4.0.
> > Maintainer in this case is Jason, so it's up to him
>
>
> I've queued this for 4.0.
>
> Thanks
>
>
