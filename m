Received: from eggs.gnu.org ([2001:4830:134:3::10]:47204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gU5HG-0001BS-TL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gU56s-0004at-HB
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:27:13 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:59981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gU56s-0004Rr-83
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:27:10 -0500
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-4-d.csapak@proxmox.com>
	<20470290-837c-e137-ec6b-4a0179195597@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <d8e10d8f-60d3-9731-cac0-2e8beb2303c8@proxmox.com>
Date: Tue, 4 Dec 2018 08:27:01 +0100
MIME-Version: 1.0
In-Reply-To: <20470290-837c-e137-ec6b-4a0179195597@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qapi: Split host-qmp into quit and
 system-reset
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

On 12/3/18 10:38 PM, Eric Blake wrote:
> On 12/3/18 3:26 AM, Dominik Csapak wrote:
>> It is interesting to know whether the shutdown cause was 'quit' or
>> 'reset', especially when using "--no-reboot". In that case, a manageme=
nt
>> layer can now determine if the guest wanted a reboot or shutdown, and
>> can act accordingly.
>>
>> Changes the ouput of the reason in the iotests from 'host-qmp' to
>=20
> s/ouput/output/
>=20
>> 'host-qmp-quit'.
>=20
> May be worth adding that this change is not a compatibility break,=20
> because the field itself was also added in 4.0.
>=20

will do in v3. thanks for the review @all

>>
>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
>> ---
>> =C2=A0 qapi/run-state.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 10 ++++++----
>=20
> Otherwise, series is looking good to me.
>=20
