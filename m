Received: from eggs.gnu.org ([2001:4830:134:3::10]:51584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emhbW-0008FG-42
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emhbS-0000WS-VG
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:07:14 -0500
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518782691-1232-3-git-send-email-mihajlov@linux.vnet.ibm.com>
	<ceb7028a-6878-9a63-004e-bdf774bb2509@redhat.com>
	<fb0e5ac4-4339-ea4c-2aea-3439a5e01bf4@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1389c7ab-a95b-9f5f-3bc1-434e521b946c@redhat.com>
Date: Fri, 16 Feb 2018 09:07:06 -0600
MIME-Version: 1.0
In-Reply-To: <fb0e5ac4-4339-ea4c-2aea-3439a5e01bf4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv4 2/4] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On 02/16/2018 08:49 AM, Viktor Mihajlovski wrote:

>>
>> The HMP changes are non-trivial compared to v3, so I might have droppe=
d
>> all R-b and Acked-by to ensure they are looked at again.
>>
>> In fact,...
>>

>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpu->value->CPU =3D=3D=
 monitor_get_cpu_index()) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ctive =3D '*';
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> The old code was doing multiple things - it was telling you the curren=
t
>> HMP cpu (HMP has 'cpu' with no QMP counterpart, but if you are using
>> HMP, knowing which cpu is the active target for future HMP commands th=
at
>> depend on the active target, this bit of information is important),

>>
> Thanks for the patience. I'll respin with the r/a-b's on patch 2/4
> removed, but want to verify first that I can get the active cpu without
> triggering cpu_synchronize_state via monitor_get_cpu_index...

What does it matter?  HMP is not the time-critical interface like QMP,=20
so even if it has to synchronize things, you're no worse off than you=20
were before when using HMP.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
