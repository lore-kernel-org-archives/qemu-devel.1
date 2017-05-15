Received: from eggs.gnu.org ([2001:4830:134:3::10]:40581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dAFvG-0001Qo-Su
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dAFvG-0008EB-3U
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:20:26 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170515130500.GB4018@noname.redhat.com>
References: <1494851980-6831-1-git-send-email-kwolf@redhat.com>
	<w51shk6s2y0.fsf@maestria.local.igalia.com>
	<20170515130500.GB4018@noname.redhat.com>
Date: Mon, 15 May 2017 15:20:18 +0200
Message-ID: <w51pofas1d9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Test streaming with missing
 job ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, kchamart@redhat.com, qemu-devel@nongnu.org

On Mon 15 May 2017 03:05:00 PM CEST, Kevin Wolf wrote:
>> Mmm... but does that trigger the bug?
>> 
>> The bug happens if the user tries to create a stream job on a BDS that:
>> 
>> a) exists
>> b) is not the active node (i.e. needs reopening in read-write mode)
>> c) its node name is not valid for a block job (e.g. it contains a '#')
>
> I don't think c) is necessary, block jobs that are owned by a BDS
> identified by a node name always require an explicit job ID.

It defaults to bdrv_get_device_name() if the job ID is not set, but in
your case there's indeed none, so

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
