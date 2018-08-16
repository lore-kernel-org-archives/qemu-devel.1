Received: from eggs.gnu.org ([2001:4830:134:3::10]:33188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqGjV-0005eW-3J
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqGjP-0002Km-2w
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:46:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqGjO-0002Ie-TH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 07:46:22 -0400
References: <CAB3eZfsv+JDr+C=BaKEmZvW9meTwNub2HfwXO5DX7mf+BJqO0A@mail.gmail.com>
	<20180816082200.GD8612@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90d7f44b-03ad-c075-e344-3c52c4268965@redhat.com>
Date: Thu, 16 Aug 2018 06:46:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180816082200.GD8612@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How do you do when write more than 16TB data to
 qcow2 on ext4?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 08/16/2018 03:22 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Aug 16, 2018 at 09:35:52AM +0800, lampahome wrote:
>> We all know there's a file size limit 16TB in ext4 and other fs has th=
eir
>> limit,too.
>>
>> If I create an qcow2 20TB on ext4 and write to it more than 16TB. Data=
 more
>> than 16TB can't be written to qcow2.
>>
>> So, is there any better ways to solve this situation?
>=20
> I'd really just recommend using a different filesystem, in particular X=
FS
> has massively higher file size limit - tested to 500 TB in RHEL-7, with=
 a
> theoretical max size of 8 EB. It is a very mature filesystem & the defa=
ult
> in RHEL-7.

Or target raw block devices instead of using a filesystem. LVM works grea=
t.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
