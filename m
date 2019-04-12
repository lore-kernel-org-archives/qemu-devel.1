Received: from eggs.gnu.org ([209.51.188.92]:39213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEyMk-0007dp-Av
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEyMj-0005UB-DB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:22 -0400
Received: from [110.188.70.11] (port=23279 helo=spam2.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hEyMh-0005OI-QN
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:21 -0400
References: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
	<20190412132420.GM25308@redhat.com>
	<e5f6cbe5-5c60-9c5e-5218-63913f5ce616@redhat.com>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <8d9b07c1-2bfa-d973-9d5d-f86ee7c14ade@hygon.cn>
Date: Fri, 12 Apr 2019 23:44:58 +0800
MIME-Version: 1.0
In-Reply-To: <e5f6cbe5-5c60-9c5e-5218-63913f5ce616@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] i386: Add new Hygon 'Dhyana' and
 'Dhyana-IBPB' CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On 2019/4/12 22:45, Paolo Bonzini wrote:
> On 12/04/19 15:24, Daniel P. Berrang=C3=A9 wrote:
>>> Add two new base CPU models called 'Dhyana' and 'Dhyana-IBPB' to mode=
l
>>> processors from Hygon Dhyana (family 18h), which derived from AMD EPY=
C
>>> (family 17h). 'Dhyana-IBPB' is a copy of the 'Dhyana' CPU model with
>>> just CPUID_8000_0008_EBX_IBPB added.
>>
>> Do we really need to support both CPU variants ?
>=20
> Also, I think the compatibility properties are not needed for Dhyana ch=
ips.
=20
Will only keep one CPU model with IBPB feature by using the name 'Dhyana'.

Thx.

--=20
Regards,
Pu Wen
