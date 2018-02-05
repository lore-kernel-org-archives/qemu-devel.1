Received: from eggs.gnu.org ([2001:4830:134:3::10]:39968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eikcL-0006Kr-7M
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 12:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eikcH-0003K0-9J
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 12:31:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eikcH-0003Ii-34
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 12:31:41 -0500
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
Date: Mon, 5 Feb 2018 18:31:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180205181521.47232aa4@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Tan, Jianfeng" <jianfeng.tan@intel.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 05/02/2018 18:15, Igor Mammedov wrote:
>>>
>>> Then we would have both ram block named pc.ram:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Block Name=C2=A0=C2=A0=C2=A0 PSize
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pc.ram=C2=A0=C2=
=A0=C2=A0=C2=A0 4 KiB
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /objects/pc.ram=C2=A0=C2=A0=C2=A0 2 Mi=
B
>>>
>>> But I assume it's a corner case which not really happen. =20
>> Yeah, you're right. :/  I hadn't thought of hotplug.  It can happen in=
deed.
> =20
> perhaps we should fail object_add memory-backend-foo if it resulted
> in creating ramblock with duplicate id

Note that it would only be duplicated with Jianfeng's patch.  So I'm
worried that his patch is worse than what we have now, because it may
create conflicts with system RAMBlock names are not necessarily
predictable.  Right now, -object creates RAMBlock names that are nicely
constrained within /object/.

Paolo
