Received: from eggs.gnu.org ([2001:4830:134:3::10]:57541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eik1u-0006Eo-LL
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eik1r-0005ug-IM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:54:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eik1r-0005qy-CZ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:54:03 -0500
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<ff3a2289-2b54-2f55-0f9c-f504282376da@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <829cb5f6-de68-9e56-106f-7311ea00e4c2@redhat.com>
Date: Mon, 5 Feb 2018 17:53:43 +0100
MIME-Version: 1.0
In-Reply-To: <ff3a2289-2b54-2f55-0f9c-f504282376da@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tan, Jianfeng" <jianfeng.tan@intel.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On 05/02/2018 17:44, Tan, Jianfeng wrote:
>>>
>> I understand.=C2=A0 However it's not as bad as "there's no possibility=
 at all
>> to migrate from vhost-kernel to vhost-user".=C2=A0 There are cases tha=
t are
>> more problematic: for example, there's no possibility at all to add
>> memory NUMA policy during a live migration, unless -object
>> memory-backend-* was used on the source.
>=20
> Please help me to understand: Are you saying it's always recommended to
> use -object memory-backend-* configuration even with vhost-kernel
> backend for the reason you mentioned?

Indeed---in general, there's no downside to always using -object to
start a virtual machine.  Of course when migrating a machine that was
started without -object, you need to use it on the destination too.

Paolo
