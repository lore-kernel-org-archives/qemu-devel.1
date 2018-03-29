Received: from eggs.gnu.org ([2001:4830:134:3::10]:36867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f1VnI-0007Dn-J4
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f1VnE-0003Xx-LR
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:32:36 -0400
References: <1522316251-16399-1-git-send-email-thuth@redhat.com>
	<2103b547-66aa-d1f7-a504-cb6ef3672039@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <769c8228-7b3a-278d-7711-0e5a87167fb1@redhat.com>
Date: Thu, 29 Mar 2018 13:32:21 +0200
MIME-Version: 1.0
In-Reply-To: <2103b547-66aa-d1f7-a504-cb6ef3672039@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: Increase virtio
 timeout to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, ldoktor@redhat.com

On 29.03.2018 12:03, Christian Borntraeger wrote:
>=20
>=20
> On 03/29/2018 11:37 AM, Thomas Huth wrote:
>> The current timeout is set to only three seconds - and considering tha=
t
>> vring_wait_reply() or rather get_second() is not doing any rounding,
>> the real timeout is likely rather 2 seconds in most cases. When the
>> host is really badly loaded and we run the guest in TCG mode instead
>> of KVM, it's possible that we hit this timeout by mistake. So let's
>> increase the timeout to 30 seconds instead to ease this situation (30
>> seconds is also the timeout that is used by the Linux SCSI subsystem
>> for example, so this seems to be a sane value for block IO timeout).
>=20
> I have never seen this, but cant this also with KVM (e.g. host paging
> and the swap disk is busy for some seconds).

Sure, I even assume that Luk=C3=A1=C5=A1 might have hit this with KVM, an=
d not
with TCG. It's just a little bit more unlikely there.

> Wouldnt it also qualify for 2.12?

Yes, I was just not sure whether we want to rebuild the s390-ccw.img
just because of this ... I'd like to leave that decision to you and
Cornelia.

 Thomas
