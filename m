Received: from eggs.gnu.org ([2001:4830:134:3::10]:58654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRq5P-0000Ba-Sm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRq5M-0004UQ-NN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 22:00:23 -0500
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-10-clg@kaod.org>
	<20181128001324.GS2251@umbus.fritz.box>
	<e49e34890be88a484b61e62e9a128ca3ff4f67ab.camel@kernel.crashing.org>
	<20181128024158.GV2251@umbus.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <453f9b80-76f2-2cb2-9003-f5b72e8c6828@redhat.com>
Date: Tue, 27 Nov 2018 21:00:17 -0600
MIME-Version: 1.0
In-Reply-To: <20181128024158.GV2251@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/36] ppc/xive: notify the CPU when the
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org

On 11/27/18 8:41 PM, David Gibson wrote:
> On Wed, Nov 28, 2018 at 01:32:21PM +1100, Benjamin Herrenschmidt wrote:
>> On Wed, 2018-11-28 at 11:13 +1100, David Gibson wrote:
>>> Don't you need a cast to avoid (nsr << 8) being a shift-wider-than-size?
>>
>> Shouldn't be a problem as long as it fits in an int, no ?
> 
> I dunno, I can never remember the rules about when C extends and when
> it doesn't.  I'm not sure anybody does, which is kind of the point.

As soon as you perform arithmetic on a type narrower than int, it is 
first promoted to at least int (possibly wider, depending on the type of 
the other operand to the binary operator).  And, since C guarantees that 
int is larger than 8 bits, 'uint8_t << 8' and 'int8_t << 8' are both 
well-defined, without needing a cast of nsr.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
