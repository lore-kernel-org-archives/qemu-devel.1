Received: from eggs.gnu.org ([2001:4830:134:3::10]:46806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gU5HP-0000Ws-NP
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gU55q-0002wb-PP
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:26:10 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:44405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gU55j-0002GY-4x
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:26:03 -0500
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-2-d.csapak@proxmox.com>
	<5091fc5e-51f0-d470-de1c-c75ad0314d42@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <1af51d35-f74d-cc80-9f87-44cb0d82c92d@proxmox.com>
Date: Tue, 4 Dec 2018 08:25:45 +0100
MIME-Version: 1.0
In-Reply-To: <5091fc5e-51f0-d470-de1c-c75ad0314d42@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: Turn ShutdownCause into QAPI
 enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, armbru@redhat.com, mreitz@redhat.com

On 12/3/18 10:34 PM, Eric Blake wrote:
> On 12/3/18 3:26 AM, Dominik Csapak wrote:
>> Needed so the patch after next can add ShutdownCause to QMP events
>> SHUTDOWN and RESET.
>>
>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
>> ---
>> =C2=A0 include/sysemu/sysemu.h | 20 --------------------
>> =C2=A0 qapi/run-state.json=C2=A0=C2=A0=C2=A0=C2=A0 | 34 ++++++++++++++=
++++++++++++++++++++
>> =C2=A0 2 files changed, 34 insertions(+), 20 deletions(-)
>=20
>> +++ b/qapi/run-state.json
>=20
>> +# @subsystem-reset: Partial guest reset that does not trigger QMP=20
>> events and
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignores --no-reboot. This is useful for=
 sanitizing
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hypercalls on s390 that are used during=
=20
>> kexec/kdump/boot
>=20
> Is it ever possible for a user to see this state, or is the intent that=
=20
> it is internal-only?=C2=A0 But it's not the first time we've leaked int=
ernal=20
> states into enums (see, for example, 'null' within JobStatus in=20
> job.json), so it's not a showstopper.
>=20

afaics, it is not possible to get this via an event, but i wanted
to keep the comment somehow.
should i mark it with an '(internal only)' or something similar?
