Received: from eggs.gnu.org ([2001:4830:134:3::10]:39357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fqZlF-0006S7-Nl
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fqZlE-000535-Os
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:05:33 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:46676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fqZlE-00052Z-EJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:05:32 -0400
Received: by mail-ua1-x944.google.com with SMTP id u11-v6so5213797uan.13
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 01:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <90d7f44b-03ad-c075-e344-3c52c4268965@redhat.com>
References: <CAB3eZfsv+JDr+C=BaKEmZvW9meTwNub2HfwXO5DX7mf+BJqO0A@mail.gmail.com>
	<20180816082200.GD8612@redhat.com>
	<90d7f44b-03ad-c075-e344-3c52c4268965@redhat.com>
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 17 Aug 2018 16:05:30 +0800
Message-ID: <CAB3eZfvdT22SKvcqXtEHFfHhvDvWWFzXa+nvDRYag852TotZUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Really? How to mount a blk device to /dev/nbdN?
I always find tips to mount from file-like image to /dev/nbdN

2018-08-16 19:46 GMT+08:00 Eric Blake <eblake@redhat.com>:

> On 08/16/2018 03:22 AM, Daniel P. Berrang=C3=A9 wrote:
>
>> On Thu, Aug 16, 2018 at 09:35:52AM +0800, lampahome wrote:
>>
>>> We all know there's a file size limit 16TB in ext4 and other fs has the=
ir
>>> limit,too.
>>>
>>> If I create an qcow2 20TB on ext4 and write to it more than 16TB. Data
>>> more
>>> than 16TB can't be written to qcow2.
>>>
>>> So, is there any better ways to solve this situation?
>>>
>>
>> I'd really just recommend using a different filesystem, in particular XF=
S
>> has massively higher file size limit - tested to 500 TB in RHEL-7, with =
a
>> theoretical max size of 8 EB. It is a very mature filesystem & the defau=
lt
>> in RHEL-7.
>>
>
> Or target raw block devices instead of using a filesystem. LVM works grea=
t.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
