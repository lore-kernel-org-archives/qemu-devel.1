Received: from eggs.gnu.org ([2001:4830:134:3::10]:40588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMwLU-0001Kr-Mf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMwLP-0007TC-Sq
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:40:44 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181114104934.GB10481@dhcp-200-186.str.redhat.com>
References: <20181113164544.9906-1-berto@igalia.com>
	<bf4041ab-7288-53fc-055c-1c7c7a607d42@redhat.com>
	<w51wopgjfrc.fsf@maestria.local.igalia.com>
	<20181114104934.GB10481@dhcp-200-186.str.redhat.com>
Date: Wed, 14 Nov 2018 15:40:27 +0100
Message-ID: <w51r2fnk9ic.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for 3.1? PATCH] qcow2: Assert that refcount block
 offsets fit in the refcount table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 14 Nov 2018 11:49:34 AM CET, Kevin Wolf wrote:
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> 
>> Yes, for 3.1, shall I resend it with the updated subject message?
>
> Honestly, I don't see why an additional assertion should qualify as a
> fix? If it changes the behaviour, it's a bug.

We can leave it for after 3.1 if you think it's more appropriate. I'll
resend it with the S-o-b anyway.

Berto
