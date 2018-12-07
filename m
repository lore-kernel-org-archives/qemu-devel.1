Received: from eggs.gnu.org ([2001:4830:134:3::10]:52674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJH4-0004Lc-MA
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJGw-0006uS-E8
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:46:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gVJGq-0006QR-HN
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:46:32 -0500
References: <20181207131732.21073-1-lvivier@redhat.com>
	<f4c7787a-c0c5-b239-9d61-e5ae0fcfa6b9@redhat.com>
	<5206f22c-a472-2f17-e9e9-adf7960fb6cb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2e48d094-da98-6b7e-a402-b0fb8a444e54@redhat.com>
Date: Fri, 7 Dec 2018 10:46:27 -0600
MIME-Version: 1.0
In-Reply-To: <5206f22c-a472-2f17-e9e9-adf7960fb6cb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] scsi-disk: Convert from DPRINTF()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 12/7/18 10:37 AM, Laurent Vivier wrote:
> On 07/12/2018 16:37, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/7/18 2:17 PM, Laurent Vivier wrote:
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---

>>
>> TIL about trace_event_get_state_backends(), I'll use it to clean other
>> hexdump traces, thanks :)
>=20
> I've copied that from gdbstub.c where there is an hexdump() function
> using it.
>=20
> I'm going to send a v2 of this patch, because I think it is not needed
> in this case to pass the function in the parameters.

Don't forget the 0/2 cover letter in that case (all series of >1 patch=20
are easier to process with a cover letter, even if it is just 2 patches)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
