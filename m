Received: from eggs.gnu.org ([2001:4830:134:3::10]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCmEp-0001dU-3g
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCmEl-0008BK-G9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:51:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCmEl-00085f-8I
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:51:47 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98a20e5d-0a11-2d4f-2de9-d50ca4dff941@redhat.com>
Date: Wed, 17 Oct 2018 08:51:35 -0500
MIME-Version: 1.0
In-Reply-To: <1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
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
To: Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 10/17/18 2:17 AM, Dominik Csapak wrote:
> On 10/8/18 3:19 PM, Dominik Csapak wrote:
>> when '-no-reboot' is set, it is interesting if the guest was originall=
y
>> shutdown or reset, so save and return that info
>>
>> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
>> ---
>> =C2=A0 qapi/run-state.json | 5 ++++-
>> =C2=A0 vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 ++++-
>> =C2=A0 2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/run-state.json b/qapi/run-state.json
>> index 332e44897b..ec1769777d 100644
>> --- a/qapi/run-state.json
>> +++ b/qapi/run-state.json
>> @@ -107,6 +107,9 @@
>> =C2=A0 # a guest-initiated ACPI shutdown request or other hardware-spe=
cific=20
>> action)
>> =C2=A0 # rather than a host request (such as sending qemu a SIGINT). (=
since=20
>> 2.10)
>> =C2=A0 #
>> +# @was_reset: If true, the shutdown was actually a reset, but no-rebo=
ot
>> +# was set, so it got converted to a shutdown

New additions should prefer naming like 'was-reset' rather than=20
'was_reset', if we still think this particular name is appropriate.  My=20
personal take: what does the 'was' add, which would prevent us from just=20
using the name 'reset' and avoiding the separator spelling issue?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
