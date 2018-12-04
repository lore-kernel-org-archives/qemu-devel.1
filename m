Received: from eggs.gnu.org ([2001:4830:134:3::10]:46806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gU5HL-0000Ws-Tw
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gU567-0003PD-9x
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:26:27 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:10828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gU567-0003Lv-0n
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:26:23 -0500
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-3-d.csapak@proxmox.com>
	<2a93ca10-e65f-b39a-f82f-f1f43abfdcf4@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <19f968af-7d63-115c-6610-bdee7030dcb4@proxmox.com>
Date: Tue, 4 Dec 2018 08:26:18 +0100
MIME-Version: 1.0
In-Reply-To: <2a93ca10-e65f-b39a-f82f-f1f43abfdcf4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: Add reason to SHUTDOWN and
 RESET events
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

On 12/3/18 10:36 PM, Eric Blake wrote:
> On 12/3/18 3:26 AM, Dominik Csapak wrote:
>> This makes it possible to determine what the exact reason was for
>> a RESET or a SHUTDOWN. A management layer might need the specific reas=
on
>> of those events to determine which cleanups or other actions it needs=20
>> to do.
>>
>> This patch also fixes the iotests to include the reason in the output.
>>
>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
>> ---
>> =C2=A0 qapi/run-state.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 8 ++++++--
>=20
>> +++ b/qapi/run-state.json
>> @@ -141,6 +141,8 @@
>> =C2=A0 # a guest-initiated ACPI shutdown request or other hardware-spe=
cific=20
>> action)
>> =C2=A0 # rather than a host request (such as sending qemu a SIGINT). (=
since=20
>> 2.10)
>> =C2=A0 #
>> +# @reason: The @ShutdownCause which resulted in the SHUTDOWN.
>=20
> Missing a '(since 4.0)' clause.
>=20

yeah, i guessed so, but was not sure which version to write.
will do in an upcoming v3

>=20
>> @@ -180,6 +182,8 @@
>> =C2=A0 # rather than a host request (such as the QMP command system_re=
set).
>> =C2=A0 # (since 2.10)
>> =C2=A0 #
>> +# @reason: The @ShutdownCause of the RESET.
>=20
> and again.
>=20
