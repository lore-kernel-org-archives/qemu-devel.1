Received: from eggs.gnu.org ([2001:4830:134:3::10]:52092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1ceHxW-00069j-24
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1ceHxS-0001Ui-4s
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:02:38 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:57197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1ceHxR-0001Tk-R9
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:02:34 -0500
Message-Id: <58A5DB2002000062000D1075@prv-mh.provo.novell.com>
Date: Thu, 16 Feb 2017 02:02:24 -0700
From: "Lin Ma" <lma@suse.com>
References: <58A4707602000062000D0393@prv-mh.provo.novell.com>
	<20170215153306.GF16064@stefanha-x1.localdomain>
	<58A5C23202000062000D0FCB@prv-mh.provo.novell.com>
	<b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
In-Reply-To: <b50ed69e-ce2f-36d9-797b-5f6a5cf7850d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSN77yaIFJlOiBbUkZDXSB2aXJ0aW8tZmM6?=
 =?utf-8?q?_draft_idea_of_virtual_fibre_channel_HBA?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, mst@redhat.com, stefanha@redhat.com, Zhiqiang Zhou <ZZhou@suse.com>, hare@suse.de



>>> Paolo Bonzini <pbonzini@redhat.com> 2/16/2017 4:39 =E4=B8=8B=E5=8D=88 =
>>>
>
>
>On 16/02/2017 08:16, Lin Ma wrote:
>>> What are the benefits of having FC access from the guest?
>>=20
>> Actually, I havn't dug it too much, Just thought that from virtualizatio=
n's
>> perspective, when interact with FC storage, having complete FC access
>> from the guest is the way it should use.
>
>How much of this requires a completely new spec?  Could we get enough of
>the benefit (e.g. the ability to issue rescans or LIPs on the host) by
>extending virtio-scsi?

I understand, It needs too much stuff for building such an all new =
device.=20
Furthermore, from performance's perspective, Extending virtio-scsi way =
doesn't
involve in the fc fabric level, leave it to physical HBA to handle, may =
get better
performance.
=20
Lin
