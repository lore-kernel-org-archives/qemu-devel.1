Received: from eggs.gnu.org ([2001:4830:134:3::10]:59943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0qLM-0004yK-5V
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0qLI-0001tM-8Q
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:17:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0qLI-0001su-3j
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:16:56 -0400
References: <20180327143014.1767669-1-eblake@redhat.com>
	<20180327143014.1767669-7-eblake@redhat.com>
	<CAJ+F1CJvvhd-pL5S9JChsBjEHqaB=_-HdYRzd+NiH3RK28B0yw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b635c80e-4093-0cdb-2166-6a37dbd6ee18@redhat.com>
Date: Tue, 27 Mar 2018 10:16:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJvvhd-pL5S9JChsBjEHqaB=_-HdYRzd+NiH3RK28B0yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 06/14] qmp: fix qmp_capabilities error
 regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 03/27/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Tue, Mar 27, 2018 at 4:30 PM, Eric Blake <eblake@redhat.com> wrote:
>> From: Peter Xu <peterx@redhat.com>
>>
>> When someone sends a command before QMP handshake, the error used to b=
e
>> like this:
>>
>>   {"execute": "query-cpus"}
>>   {"error": {"class": "CommandNotFound", "desc":
>>              "Expecting capabilities negotiation with 'qmp_capabilitie=
s'"}}
>>
>> While after cf869d5317 it becomes:
>>
>>   {"execute": "query-cpus"}
>>   {"error": {"class": "CommandNotFound", "desc":
>>              "The command query-cpus has not been found"}}
>>
>> Fix it back to the nicer one.
>>
>> Fixes: cf869d5317 ("qmp: support out-of-band (oob) execution", 2018-03=
-19)
>> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Message-Id: <20180326063901.27425-2-peterx@redhat.com>
>> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Reviewed-by (not x2 Reported-by ;)
>=20

Shoot.  Want me to send a v2 pull request?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
