Received: from eggs.gnu.org ([2001:4830:134:3::10]:40153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fujunkang@gmail.com>) id 1cP2Zb-0004bQ-AB
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fujunkang@gmail.com>) id 1cP2ZZ-0006nM-QB
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:34:55 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fujunkang@gmail.com>) id 1cP2ZZ-0006mu-KP
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:34:53 -0500
Received: by mail-wm0-x241.google.com with SMTP id m203so95005845wma.3
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 23:34:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
References: <CAP8dc_acqeqpio7fVK4XSAxoH8QaGp9L=S1h2OCCWgrj=Q7VCw@mail.gmail.com>
	<e57c4b44-ac0c-a937-e088-1f4e086080d8@redhat.com>
From: Junkang Fu <fujunkang@gmail.com>
Date: Thu, 5 Jan 2017 15:34:50 +0800
Message-ID: <CAP8dc_bGQup_bF49p8XUncdoNy2E7qbVCutRLG9Afaf_-gALAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC]virtio-blk: add disk-name device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org

You got it, that's exactly what I mean.Thank you for your advise.

2017-01-04 0:53 GMT+08:00 Eric Blake <eblake@redhat.com>:

> On 12/29/2016 08:41 PM, Junkang Fu wrote:
> >>From 74e913fc41ea98d1dde692175f1e3fb6729342aa Mon Sep 17 00:00:00 2001
> > From: "junkang.fjk" <junkang.fjk@alibaba-inc.com>
> > Date: Wed, 24 Aug 2016 19:36:53 +0800
> > Subject: [PATCH] virtio-blk: add disk-name device property
> >
> > Current virtio-blk disk name(ex. /dev/vdb) has nothing to do with the
> > target dev
> > name specified in libvirt xml file. For example, we may get disk name
> > /dev/vdb in
> > VM while target dev specified in libvirt xml is vdc.
>
> It's not really libvirt's fault.  The libvirt XML names are for
> convenience, but nothing on the host side requires the guest to pick the
> same naming scheme as the host.
>
> I guess your proposal is to enhance the virtio spec such that clients
> that are new enough to honor the new addition to the virtio spec will
> change their name-picking algorithm to use the name provided by the
> host, rather than their current approach of picking whatever name they
> feel like, and then enhance libvirt to pass the XML name on down to the
> guest?  It might work, but as others have pointed out, it will require a
> virtio spec change first.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
>
