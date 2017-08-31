Received: from eggs.gnu.org ([2001:4830:134:3::10]:36919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ydary@redhat.com>) id 1dnKJ6-0004Ef-KJ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ydary@redhat.com>) id 1dnKJ3-0002F7-Fu
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:54:32 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ydary@redhat.com>) id 1dnKJ3-0002Ep-8j
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:54:29 -0400
Received: by mail-io0-f175.google.com with SMTP id b2so2972836iof.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 00:54:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4c53113-0afd-4325-3cd3-9fd7cf3604b5@redhat.com>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<20170828025706.GA18194@lemon.lan>
	<923084c5-f1a8-e361-2e4e-b635249a59be@redhat.com>
	<CACKMAy-nOFc40d2n2pQ-VYX7tjDBQS-AGT=SYcxrxSrDd6enTA@mail.gmail.com>
	<1491bc75-e1ee-b63b-a75b-6d5c39faab7c@redhat.com>
	<CACKMAy8QV8nFE2Awj1m49xcqB1=yXcQjmLKGRgY5-9AJ9ETgJA@mail.gmail.com>
	<d4c53113-0afd-4325-3cd3-9fd7cf3604b5@redhat.com>
From: "Yaniv Lavi (Dary)" <ylavi@redhat.com>
Date: Thu, 31 Aug 2017 10:53:47 +0300
Message-ID: <CACKMAy-HhNKaDV3HZ2Kn3C+yGmwqNUOrKxeAK3yVqFY=9PzLOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "Mureinik, Allon" <amureini@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Fam Zheng <famz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Tal Nisan <tnisan@redhat.com>

YANIV LAVI (YANIV DARY)

SENIOR TECHNICAL PRODUCT MANAGER

Red Hat Israel Ltd. <https://www.redhat.com/>

34 Jerusalem Road, Building A, 1st floor

Ra'anana, Israel 4350109

ylavi@redhat.com    T: +972-9-7692306/8272306     F: +972-9-7692223    IM: ylavi
 <https://red.ht/sig> TRIED. TESTED. TRUSTED. <https://redhat.com/trusted>
@redhatnews <https://twitter.com/redhatnews>   Red Hat
<https://www.linkedin.com/company/red-hat>   Red Hat
<https://www.facebook.com/RedHatInc>


On Thu, Aug 31, 2017 at 12:25 AM, John Snow <jsnow@redhat.com> wrote:

>
>
> On 08/30/2017 08:58 AM, Yaniv Lavi (Dary) wrote:
> >
> >
> > We had no reason to switch to anything else so far and I'm sure this
> > option was not available when we started supporting raw format.
> >
> >
>
> Yeah, they don't exist yet...! I've looped you in to see if the proposal
> being discussed would alleviate the need for bitmaps for "other formats"
> if we can offer a "raw mode qcow2."
>

As we our direction is to move a file system/LUN per disk I don't think
adding a new type disk image is the right priority.
The below option of separate file sound like the right direction.


>
> At the moment I am going to still try to add bitmaps to other formats
> (through the use of a qcow2 wrapper) but it sounds like a raw-layout
> qcow2 might provide some benefits too.
>
> -js
>
