Received: from eggs.gnu.org ([2001:4830:134:3::10]:41964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df1aE-0004um-Ea
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1df1aB-00013O-4m
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:17:54 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170808100030.GB16801@stefanha-x1.localdomain>
References: <20170807161529.3779-1-berto@igalia.com>
	<20170808100030.GB16801@stefanha-x1.localdomain>
Date: Tue, 08 Aug 2017 12:17:12 +0200
Message-ID: <w517eyel5xz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10] throttle: Make LeakyBucket.avg
 and LeakyBucket.max integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

On Tue 08 Aug 2017 12:00:30 PM CEST, Stefan Hajnoczi wrote:
> On Mon, Aug 07, 2017 at 07:15:29PM +0300, Alberto Garcia wrote:
>> Both the throttling limits set with the throttling.iops-* and
>> throttling.bps-* options and their QMP equivalents defined in the
>> BlockIOThrottle struct are integer values.
>> 
>> Those limits are also reported in the BlockDeviceInfo struct and they
>> are integers there as well.
>> 
>> Therefore there's no reason to store them internally as double and do
>> the conversion everytime we're setting or querying them, so this patch
>> uses int64_t for those types.
>> 
> Why is this marked for-2.10?  Does it fix a bug?

I was under the impression that Markus wanted to change the QAPI types
of the throttling fields in BlockDeviceInfo for 2.10 as well, so this
patch is relevant.

If that's not the case we can ignore it for now and leave it for the
next cycle. Sorry for the noise!

Berto
