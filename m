Received: from eggs.gnu.org ([2001:4830:134:3::10]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4nKR-0000L9-0c
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4nKN-0005aD-T2
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:20:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4nKN-0005Yi-NF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:20:03 -0400
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <32e47d96-0292-4511-adb2-24a4766b3027@redhat.com>
Date: Wed, 18 Oct 2017 14:19:54 +0200
MIME-Version: 1.0
In-Reply-To: <20171017150759.GB31897@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, armbru@redhat.com, david@gibson.dropbear.id.au

On 17/10/2017 17:07, Daniel P. Berrange wrote:
> ie instead of:
>=20
>   -smp 8,sockets=3D4,cores=3D2,threads=3D1
>   -numa node,nodeid=3D0,cpus=3D0-3
>   -numa node,nodeid=3D1,cpus=3D4-7
>=20
> we could do:
>=20
>   -object numa-node,id=3Dnuma0
>   -object numa-node,id=3Dnuma1
>   -object cpu,id=3Dcpu0,node=3Dnuma0,socket=3D0,core=3D0,thread=3D0
>   -object cpu,id=3Dcpu1,node=3Dnuma0,socket=3D0,core=3D1,thread=3D0
>   -object cpu,id=3Dcpu2,node=3Dnuma0,socket=3D1,core=3D0,thread=3D0
>   -object cpu,id=3Dcpu3,node=3Dnuma0,socket=3D1,core=3D1,thread=3D0
>   -object cpu,id=3Dcpu4,node=3Dnuma1,socket=3D2,core=3D0,thread=3D0
>   -object cpu,id=3Dcpu5,node=3Dnuma1,socket=3D2,core=3D1,thread=3D0
>   -object cpu,id=3Dcpu6,node=3Dnuma1,socket=3D3,core=3D0,thread=3D0
>   -object cpu,id=3Dcpu7,node=3Dnuma1,socket=3D3,core=3D1,thread=3D0
>=20
> (perhaps -device instead of -object above, but that's a minor detail)

I understand that this is just an example, but wasn't this what is solved=
 by

  -smp 8,sockets=3D4,cores=3D2,thread=3D1
  -numa node,nodeid=3D0 -numa cpu,node-id=3D0,socket-id=3D0-1
  -numa node,nodeid=3D1 -numa cpu,node-id=3D0,socket-id=3D2-3

?

Paolo
