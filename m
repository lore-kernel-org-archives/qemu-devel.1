Received: from eggs.gnu.org ([2001:4830:134:3::10]:41859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1epAd6-0002fS-GN
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1epAd3-0003Ar-A0
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:31:04 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <ea7725b4-a06a-0be0-4fc2-80cfa4359489@redhat.com>
References: <20180222161811.26200-1-berto@igalia.com>
	<ea7725b4-a06a-0be0-4fc2-80cfa4359489@redhat.com>
Date: Fri, 23 Feb 2018 11:30:21 +0100
Message-ID: <w51woz4kngi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] iotests: Test abnormally large size in
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu 22 Feb 2018 08:00:08 PM CET, Eric Blake wrote:
>> One consequence of this is that even if the size field is larger than
>> it needs to be QEMU can handle it just fine: it will read more data
>> from disk but it will ignore the extra bytes.
>
> (is that true even for the corner case when the size field points
> beyond the end of the image?  But not important to the meat of the
> patch)

As a matter of fact this is exactly what happens in this test
case... I'm thinking to expand it so both cases are tested.

Berto
