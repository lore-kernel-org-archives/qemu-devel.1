Received: from eggs.gnu.org ([2001:4830:134:3::10]:33437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dfmtK-0008Pv-Dh
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1dfmtG-0003i1-Dl
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:48:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1dfmtG-0003fk-7Y
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:48:42 -0400
Date: Thu, 10 Aug 2017 14:41:03 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170810124102.GA21850@flask>
References: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
	<20170810102649.GF12980@redhat.com>
	<00cb01a4-5c27-fc69-d3ae-0653aa54b121@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00cb01a4-5c27-fc69-d3ae-0653aa54b121@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, rth@twiddle.net

2017-08-10 19:02+0800, Lan Tianyu:
> On 2017=E5=B9=B408=E6=9C=8810=E6=97=A5 18:26, Daniel P. Berrange wrote:
>> On Thu, Aug 10, 2017 at 06:08:07PM +0800, Lan Tianyu wrote:
>>> Intel Xeon phi chip will support 352 logical threads. For HPC
>>> usage case, it will create a huge VM with vcpus number as same as hos=
t
>>> cpus. This patch is to increase max vcpu number to 352.
>>=20
>> If we pick arbitray limits based on size of physical CPUs that happen
>> to be shipping today, we'll continue the cat+mouse game forever traili=
ng
>> latest CPUs that vendors ship.
>>=20
>> IMHO we should pick a higher number influenced by technical constraint=
s
>> of the q35 impl instead. eg can we go straight to something like 512 o=
r
>> 1024  ?
>=20
> Sure. 512 should be enough and some arrays is defined according to max
> vcpu number.

Hm, which arrays are that?  I was thinking it is safe to bump it to
INT_MAX as the number is only used when setting global max_cpus.

Thanks.
