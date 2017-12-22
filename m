Received: from eggs.gnu.org ([2001:4830:134:3::10]:50016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSBvw-00067B-NL
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 20:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eSBvv-0003Sm-Rs
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 20:15:32 -0500
References: <1513901496-13538-1-git-send-email-jack.schwartz@oracle.com>
	<1513901496-13538-2-git-send-email-jack.schwartz@oracle.com>
	<b03b4cde-5ec4-b3f0-23f6-5fc4115814d1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec5acd29-86ea-5972-ffa2-2d79bc377e2e@redhat.com>
Date: Thu, 21 Dec 2017 19:15:24 -0600
MIME-Version: 1.0
In-Reply-To: <b03b4cde-5ec4-b3f0-23f6-5fc4115814d1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1 1/1] block: Add numeric
 errno field to BLOCK_IO_ERROR events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, konrad.wilk@oracle.com, mreitz@redhat.com

On 12/21/2017 07:08 PM, Eric Blake wrote:

>> =C2=A0 #
>> +# @errno: int describing the error cause, provided for applications.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (Note: while most e=
rrnos are posix compliant between OSs, it
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is possible some er=
rno values can vary among different OSs.)
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (since 2.12)
>=20
> The proof is in the pudding - if your documentation has to give this bi=
g=20
> disclaimer, then what you are adding is not portable and should not be=20
> added in that manner.

To follow up to myself, POSIX explicitly says that errno values are=20
implementation dependent, and there is NO requirement that errno value 1=20
be EPERM, for example.  And while qemu does not target GNU Hurd, that is=20
a classic example of a system where errno values intentionally do not=20
fit in 8 bits.  So you can't argue that there are "POSIX-compliant errno=20
values", because POSIX doesn't mandate specific values.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
