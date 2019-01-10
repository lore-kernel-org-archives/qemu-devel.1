Received: from eggs.gnu.org ([209.51.188.92]:35255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghZdY-0008Gu-JQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghZdX-0002y1-LE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:40:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190103213320.2653-1-lbloch@janustech.com>
	<20190103213320.2653-2-lbloch@janustech.com>
	<8736q3ebs2.fsf@dusky.pond.sub.org>
	<d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com>
Date: Thu, 10 Jan 2019 13:40:16 +0100
In-Reply-To: <d0736347-867d-49f5-5615-dfe5f9b82412@janustech.com> (Leonid
	Bloch's message of "Thu, 10 Jan 2019 09:42:44 +0000")
Message-ID: <87h8eghej3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Leonid Bloch <lbloch@janustech.com> writes:

> Hi,
>
> On 1/8/19 11:31 AM, Markus Armbruster wrote:
>> I'd leave it hard-coded.  Replacing a few trivial defines by an arguably
>> less trivial script doesn't feel like an improvement.  In this case, it
>> doesn't even save lines.
>
> As I've said, I'm fine with that. The autogeneration sounds the right 
> thing to do here, as the table is autogenertaed anyway, but indeed it is 
> already there, explained, and even the script for generating it appears 
> in the comments for reproducibility.
>
>> 
>> I'm not sure I'd use shell for this, but since you already wrote it and
>> it works...
>> 
>
> If you've noticed, the original script was in AWK. But to be as generic 
> as possible, I didn't write the generation script in AWK because even 
> AWK is not guaranteed to be installed on the build system. The only 
> interpreted language that is guaranteed to be there is shell (most basic 
> shell) because .configure itself needs it.

Well,

    $ grep -w awk configure 
        maj=`libgcrypt-config --version | awk -F . '{print $1}'`
        min=`libgcrypt-config --version | awk -F . '{print $2}'`

The build also requires Python.

[...]
