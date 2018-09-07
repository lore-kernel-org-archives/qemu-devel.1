Received: from eggs.gnu.org ([2001:4830:134:3::10]:50460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyHC4-0001m3-HY
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyHC0-0007ct-EY
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:53:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fyHBy-0007bS-TW
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:52:59 -0400
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<20180907075948.26917-13-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fe31a380-9dbb-e0bb-4ba2-bd05cbcace02@redhat.com>
Date: Fri, 7 Sep 2018 08:52:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180907075948.26917-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/12] vl: list user creatable
 properties when 'help' is argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 09/07/2018 02:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> Iterate over the writable class properties, sort and print them out
> with the description if available.
>=20
> Ex: qemu -object memory-backend-file,help
> memory-backend-file.align=3Dint
> memory-backend-file.discard-data=3Dbool
> memory-backend-file.dump=3Dbool - Set to 'off' to exclude from core dum=
p
> memory-backend-file.host-nodes=3Dint - Binds memory to the list of NUMA=
 host nodes
> memory-backend-file.mem-path=3Dstring
> memory-backend-file.merge=3Dbool - Mark memory as mergeable
> memory-backend-file.pmem=3Dbool
> memory-backend-file.policy=3DHostMemPolicy - Set the NUMA policy
> memory-backend-file.prealloc=3Dbool - Preallocate memory
> memory-backend-file.share=3Dbool - Mark the memory as private to QEMU o=
r shared
> memory-backend-file.size=3Dint - Size of the memory region (ex: 500M)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qom/object_interfaces.c |  6 +++---
>   vl.c                    | 40 +++++++++++++++++++++++++++++++++++++---
>   2 files changed, 40 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
