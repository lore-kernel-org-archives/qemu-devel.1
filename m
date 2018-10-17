Received: from eggs.gnu.org ([2001:4830:134:3::10]:43972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gCmP7-0006S6-WF
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gCmP4-0005Ya-P5
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:02:29 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:5818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gCmP4-0005Sg-Fr
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:02:26 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
	<98a20e5d-0a11-2d4f-2de9-d50ca4dff941@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <ac93c582-0726-043e-0f63-4339911d08c2@proxmox.com>
Date: Wed, 17 Oct 2018 16:02:23 +0200
MIME-Version: 1.0
In-Reply-To: <98a20e5d-0a11-2d4f-2de9-d50ca4dff941@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: add info about reset to SHUTDOWN
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 10/17/18 3:51 PM, Eric Blake wrote:
> On 10/17/18 2:17 AM, Dominik Csapak wrote:
>> On 10/8/18 3:19 PM, Dominik Csapak wrote:
>>> when '-no-reboot' is set, it is interesting if the guest was original=
ly
>>> shutdown or reset, so save and return that info
>>>
>>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
>>> ---
>>> =C2=A0 qapi/run-state.json | 5 ++++-
>>> =C2=A0 vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 ++++-
>>> =C2=A0 2 files changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>>> index 332e44897b..ec1769777d 100644
>>> --- a/qapi/run-state.json
>>> +++ b/qapi/run-state.json
>>> @@ -107,6 +107,9 @@
>>> =C2=A0 # a guest-initiated ACPI shutdown request or other=20
>>> hardware-specific action)
>>> =C2=A0 # rather than a host request (such as sending qemu a SIGINT).=20
>>> (since 2.10)
>>> =C2=A0 #
>>> +# @was_reset: If true, the shutdown was actually a reset, but no-reb=
oot
>>> +# was set, so it got converted to a shutdown
>=20
> New additions should prefer naming like 'was-reset' rather than=20
> 'was_reset', if we still think this particular name is appropriate.=C2=A0=
 My=20
> personal take: what does the 'was' add, which would prevent us from jus=
t=20
> using the name 'reset' and avoiding the separator spelling issue?
>=20

yes of course 'reset' is fine, i just thought it might be confusing
having a RESET event and a SHUTDOWN event with a 'reset' flag, but
i guess if one tries to monitor them they would read the
api documentation anyway
