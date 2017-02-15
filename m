Received: from eggs.gnu.org ([2001:4830:134:3::10]:60458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce24u-0001zo-2Q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce24p-0005Qz-BH
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:05:12 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <CAMRbyyv4gGDG1f5tbb8NTtWPdWC+23OT2GKcrLLOuo4N2Prrkg@mail.gmail.com>
References: <CAJ1JNOd5cZ3RWUAkY=uo7+wwSwQrBWrN6GF_QZFjdVfx49VtGQ@mail.gmail.com>
	<20170215151419.GD16064@stefanha-x1.localdomain>
	<20170215152013.GH24672@redhat.com>
	<CAMRbyyv4gGDG1f5tbb8NTtWPdWC+23OT2GKcrLLOuo4N2Prrkg@mail.gmail.com>
Date: Wed, 15 Feb 2017 17:05:04 +0100
Message-ID: <w517f4rqw27.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-discuss] Estimation of qcow2 image size
 converted from raw image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Allon Mureinik <amureini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, qemu-discuss@nongnu.org

On Wed 15 Feb 2017 04:57:12 PM CET, Nir Soffer wrote:
>>> Let's try this syntax:
>>>
>>>   $ qemu-img query-max-size -f raw -O qcow2 input.raw
>>>   1234678000
>>>
>>> As John explained, it is only an estimate.  But it will be a
>>> conservative maximum.
>>
>> This forces you to have an input file. It would be nice to be able to
>> get the same information by merely giving the desired capacity e.g
>>
>>   $ qemu-img query-max-size -O qcow2 20G
>
> Without a file, this will have to assume that all clusters will be
> allocated.

...and that there are no internal snapshots. I'm not sure if this is
very useful in general.

Berto
