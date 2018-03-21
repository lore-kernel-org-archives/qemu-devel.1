Received: from eggs.gnu.org ([2001:4830:134:3::10]:54846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeEq-0004e6-GD
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyeEm-000391-8i
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyeEm-00038F-3I
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:57:08 -0400
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
	<4efcdcb9-d226-2d20-91ac-3365a4115c5d@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea65708d-6d34-31d4-0891-ed058d4d668a@redhat.com>
Date: Wed, 21 Mar 2018 08:56:56 -0500
MIME-Version: 1.0
In-Reply-To: <4efcdcb9-d226-2d20-91ac-3365a4115c5d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.12? 0/1] dump.c: allow
 fd_write_vmcore to return errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/21/2018 08:29 AM, Daniel Henrique Barboza wrote:
> Ping
>=20
> On 02/12/2018 12:25 PM, Daniel Henrique Barboza wrote:
>> v3:
>> - added set_errg_errno() to all callers of fd_write_vmcore
>> - changed patch subject to reflect what it is addressing now
>> - link to previous version:
>> http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02787.html
>>
>>
>> Yasmin Beatriz (1):
>>    dump.c: allow fd_write_vmcore to return errno on failure
>>
>>   dump.c | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>

This seems like an appropriate bug-fix patch for inclusion in 2.12.=20
Marc-Andr=C3=A9, are you planning a pull request, or should we bundle thi=
s=20
through another miscellaneous tree?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
