Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cwSwS-0007Ql-Ut
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cwSwP-0006bU-RN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:24:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170407122021.GP13602@stefanha-x1.localdomain>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<20170407122021.GP13602@stefanha-x1.localdomain>
Date: Fri, 07 Apr 2017 14:24:35 +0200
Message-ID: <w514ly0s8vw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 07 Apr 2017 02:20:21 PM CEST, Stefan Hajnoczi wrote:
>> Here are the results when writing to an empty 40GB qcow2 image with no
>> backing file. The numbers are of course different but as you can see
>> the patterns are similar:
>> 
>> |-----------------+----------------+-----------------+-------------------|
>> |  cluster size   | subclusters=on | subclusters=off | Max L2 cache size |
>> |-----------------+----------------+-----------------+-------------------|
>> |   2 MB (256 KB) |  1200 IOPS     |  255 IOPS       | 160 KB            |
>> | 512 KB  (64 KB) |  3000 IOPS     |  700 IOPS       | 640 KB            |
>> |  64 KB   (8 KB) |  7200 IOPS     | 3300 IOPS       |   5 MB            |
>> |  32 KB   (4 KB) | 12300 IOPS     | 4200 IOPS       |  10 MB            |
>> |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB            |
>> |-----------------+----------------+-----------------+-------------------|
>
> I don't understand why subclusters=on performs so much better when
> there's no backing file.  Is qcow2 zeroing out the 64 KB cluster with
> subclusters=off?

It is, see https://lists.nongnu.org/archive/html/qemu-devel/2015-07/msg05877.html

Berto
