Received: from eggs.gnu.org ([2001:4830:134:3::10]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYpDh-0006e7-2l
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 03:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dYpDe-0002yI-01
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 03:53:01 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:42780
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dYpDd-0002y8-Pz
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 03:52:57 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-3-anton.ivanov@cambridgegreys.com>
	<03702920-f5b1-6579-0c59-a0d46274a6d9@redhat.com>
	<7c19329b-f3dc-1f54-9fac-8ecf43123a8b@cambridgegreys.com>
	<33fada87-93c3-2914-68d9-86092856b37f@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <c43cb967-f117-a4d0-ba1d-08c7de5f3d79@cambridgegreys.com>
Date: Sat, 22 Jul 2017 08:52:50 +0100
MIME-Version: 1.0
In-Reply-To: <33fada87-93c3-2914-68d9-86092856b37f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] Unified Datagram Socket Transport -
 GRE support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com



>> ##
>>
>> If I read this right port is mandatory, correct?
> Okay, so it sounds like reusing InetSocket directly may not be possible.
>   But there's still the interface question of whether we want dual 'ipv4'
> and 'ipv6' switches to allow finer-grain control over which (or both)
> families to be used.

I have that in the new version ready for submission. Behavior is 
identical with other arguments which have a v4 and v6 switch.

>
>> We may be able to do it if the port portion if InetSocketAddress becomes
>> optional. There is no such thing as port for the protocols which use the
>> raw families.
> We can always create a new QAPI type that expresses only the fields we
> need; I don't think InetSocketAddress should be changed to have an
> optional port just for your code additions.
>
Concur - there are places where people rely that it has the port 
mandatory. Changing it to optional will break too much unrelated code.

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
