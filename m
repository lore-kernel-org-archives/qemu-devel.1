Received: from eggs.gnu.org ([2001:4830:134:3::10]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4YP-0004KG-Eg
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej4YK-0006db-Rk
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:49:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ej4YK-0006d6-Li
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:48:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B432780B2A
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 14:48:55 +0000 (UTC)
References: <20180205152455.12088-1-berrange@redhat.com>
	<20180205152455.12088-8-berrange@redhat.com>
	<d9a1c2af-e5f8-1d46-d5c5-ecb2ce20981a@redhat.com>
	<20180206091337.GA20001@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f0d724e-3275-6700-d41d-8f378de8835b@redhat.com>
Date: Tue, 6 Feb 2018 08:48:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180206091337.GA20001@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 7/9] sockets: allow SocketAddress 'fd'
 to reference numeric file descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 02/06/2018 03:13 AM, Daniel P. Berrang=C3=A9 wrote:

>>> +++ b/qapi/sockets.json
>>> @@ -123,6 +123,13 @@
>>>    #
>>>    # @unix:  Unix domain socket
>>>    #
>>> +# @vsock: VMCI address
>>> +#
>>> +# @fd: decimal is for file descriptor number, otherwise a file descr=
iptor name.
>>> +#      Named file descriptors are permitted in monitor commands, in =
combination
>>> +#      with the 'getfd' command. Decimal file descriptors are permit=
ted at
>>> +#      startup or other contexts where no monitor context is active.
>>> +#
>>>    # Since: 2.9
>>
>> There doesn't seem to be any way to introspect if we support decimal f=
ds
>> from the command line; is that going to be a problem?
>=20
> Libvirt needs to know when it can use it, so any suggestions ?

Patch 9/9 modified qemu_chardev_opts; does that change reflect through=20
query-command-line-options?  Not all QemuOpts changes are introspectible=20
yet, and Markus has been trying to tackle that, but if this particular=20
one works, we can use that as our witness (after all, if I understand=20
correctly, the new feature you are adding here is NOT affecting the QMP=20
usage, but is an enhancement for command-line usage).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
