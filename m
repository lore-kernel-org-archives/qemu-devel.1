Received: from eggs.gnu.org ([2001:4830:134:3::10]:39163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egYT4-0003yA-58
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egYSy-0000Bc-Ax
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:09:06 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
References: <20180130150435.2553-1-berto@igalia.com>
	<b93f21cf-5cd4-a6d0-7005-e19a3de211c8@redhat.com>
Date: Tue, 30 Jan 2018 17:08:56 +0100
Message-ID: <w51607juy5j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qcow2: Replace align_offset() with
 ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 30 Jan 2018 05:03:16 PM CET, Eric Blake wrote:

>> -    virtual_size = align_offset(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
>> +    virtual_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
>>                                  cluster_size);

I just realized that the first parameter here is a function call with
side effects, it it safe to use ROUND_UP() in this case?

#define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))

Berto
