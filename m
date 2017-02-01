Received: from eggs.gnu.org ([2001:4830:134:3::10]:60022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZ2nM-00034P-KS
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZ2nJ-0004i5-Ge
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:50:28 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <24208ca5-8964-a99f-d80f-b196d508d47f@redhat.com>
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
	<24208ca5-8964-a99f-d80f-b196d508d47f@redhat.com>
Date: Wed, 01 Feb 2017 22:49:47 +0100
Message-ID: <w511svhbmys.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 01 Feb 2017 10:36:20 PM CET, Max Reitz <mreitz@redhat.com> wrote:
>> +        if (count > INT_MAX - len) {
>
> How about using BDRV_REQUEST_MAX_BYTES instead?
>
> (not yet in master, just in my block branch)

Sounds good to me, feel free to edit my patch directly.

Berto
