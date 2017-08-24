Received: from eggs.gnu.org ([2001:4830:134:3::10]:49892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkudD-00008X-Mj
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dkud8-0001iQ-0i
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:05:19 -0400
MIME-Version: 1.0
In-Reply-To: <440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
References: <20170824153345.2244-1-stefanha@redhat.com>
	<440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 24 Aug 2017 17:05:09 +0100
Message-ID: <CAJSP0QVse1f9S8ZmXsysfaT85mCSCtzsufAOHx38KZ250NVbEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] nbd-client: enter
 read_reply_co during init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>

On Thu, Aug 24, 2017 at 4:52 PM, Eric Blake <eblake@redhat.com> wrote:
> On 08/24/2017 10:33 AM, Stefan Hajnoczi wrote:
>> See Patch 1 for the segfault fix.  Patches 2 & 3 add qemu-iotests coverage.
>>
>> This is a rare crash that we'll probably only see in testing.  It only seems to
>> happen with UNIX domain sockets.
>
> Rare enough that I don't think it is 2.10-rc4 material.  I'll review,
> and if I don't find anything needing a respin, I'll add it to my NBD
> queue for 2.11.

Great.  This is 2.11 material.

Stefan
