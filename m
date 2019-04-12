Received: from eggs.gnu.org ([209.51.188.92]:39139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEyMZ-0007T2-EG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEyMY-0005N5-GE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:11 -0400
Received: from [110.188.70.11] (port=9251 helo=spam2.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hEyMX-0005HU-1X
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:45:10 -0400
References: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
	<20190412132420.GM25308@redhat.com>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <084d8178-4fb2-6cda-aac9-90ab2ed9ce69@hygon.cn>
Date: Fri, 12 Apr 2019 23:44:45 +0800
MIME-Version: 1.0
In-Reply-To: <20190412132420.GM25308@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On 2019/4/12 21:25, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Apr 12, 2019 at 08:37:49PM +0800, Pu Wen wrote:
>> Add two new base CPU models called 'Dhyana' and 'Dhyana-IBPB' to model
>> processors from Hygon Dhyana (family 18h), which derived from AMD EPYC
>> (family 17h). 'Dhyana-IBPB' is a copy of the 'Dhyana' CPU model with
>> just CPUID_8000_0008_EBX_IBPB added.
...
> The Google results I see suggest that Dhyana CPUs started to become
> available in July 2018, so surely they would come with microcode
> that has the IBPB right from day 1 ?

Yes, you are right. Dhyana CPUs already have the IBPB feature.

> Am I missing anything that means there will be a compelling need
> to support Dhyana /without/ IBPB ?
>=20
> If not, then we only need 1 CPU model and that would include IBPB.

Okay, will only keep one CPU model which include IBPB by using the name=20
'Dhyana'.

Thx.

--=20
Regards,
Pu Wen
