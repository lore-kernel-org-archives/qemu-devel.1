Received: from eggs.gnu.org ([2001:4830:134:3::10]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVi2Z-00063k-Bc
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fVi2U-0003GO-EA
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:41:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:42416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fVi2U-0003Eu-8p
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:41:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fVi2T-0001Qx-4n
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:41:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 199E12E80C8
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:41:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Jun 2018 18:33:17 -0000
From: Waldemar Kozaczuk <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
	<152951004729.26601.9045973197027267230.malone@gac.canonical.com>
Message-Id: <16213D80-B75F-4B84-BFC5-0743A325FFC9@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX
 creates corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have done more tests based on your suggestion and I think it is the
opposite. The problem happens is the source is APFS.

Following failed:
APFS -> ExFAT
APFS -> Fat32

Following worked:
ExFAT -> APFS
FAT32 -> APFS

So for now my workaround is to use USB stick formatted with FAT32 or
ExFAT, copy the source images there and then convert to somewhere or my
main drive with APFS.

My regards,
Waldek

Sent from my iPhone

> On Jun 20, 2018, at 11:54, John Snow <1776920@bugs.launchpad.net> wrote:
> =

> I haven't had the time to look just yet.
> =

> If there's a developer out there with a Mac has the bandwidth to take a
> look at this I'd be grateful. (I don't have access to one presently.)
> =

> I see that the target filesystem is APFS however -- I think we might
> have a bug in our APFS support. Do you have the ability to try it on
> your Mac but on a non-APFS destination?
> =

> It looks like the image is pretty small (~6MB?) so maybe you can try
> with a non-APFS formatted thumb drive?
> =

> My hunch is that:
> - APFS source to FAT32 destination might work correctly.
> - FAT32 source to FAT32 destination will definitely work correctly.
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1776920
> =

> Title:
>  qemu-img convert on Mac OSX creates corrupt images
> =

> Status in QEMU:
>  New
> =

> Bug description:
>  An image created by qemu-img create, then modified by another program
>  is converted to bad/corrupt image when using convert sub command on
>  Mac OSX. The same convert works on Linux. The version of qemu-img is
>  2.12.
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
