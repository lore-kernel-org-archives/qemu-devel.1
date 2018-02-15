Received: from eggs.gnu.org ([2001:4830:134:3::10]:51634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emFCu-0005gV-3c
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 03:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emFCp-0002n5-Ay
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 03:47:56 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180213233324.5096-1-eblake@redhat.com>
References: <20180213233324.5096-1-eblake@redhat.com>
Date: Thu, 15 Feb 2018 09:47:48 +0100
Message-ID: <w51bmgqk5aj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] s/size/entries/ when dealing with
 non-byte units
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com

On Wed 14 Feb 2018 12:33:22 AM CET, Eric Blake wrote:
> I mentioned this while reviewing Berto's series on L2 slice handling;
> this is a first cut at patches that I think are worth doing throughout
> the qcow2 code base if we like the idea.
>
> Eric Blake (2):
>   qcow2: Prefer 'entries' over 'size' for non-byte values in spec
>   qcow2: Prefer 'entries' over 'size' during cache creation

I also like the idea. We'd need to change a lot of variables all over
the place, but things will look much more readable.

Berto
