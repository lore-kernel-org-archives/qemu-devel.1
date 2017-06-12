Received: from eggs.gnu.org ([2001:4830:134:3::10]:51566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKObG-0004sh-Sb
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dKObC-0006t5-UZ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:37:42 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:52500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dKObC-0006sS-HN
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:37:38 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170609160609.r2ivmny4pqvycwp5@postretch>
References: <20170608182113.nmxnvus26vplg5du@postretch>
	<w51k24ll1ke.fsf@maestria.local.igalia.com>
	<20170609160609.r2ivmny4pqvycwp5@postretch>
Date: Mon, 12 Jun 2017 14:37:34 +0200
Message-ID: <w51wp8hpek1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Proposal] I/O throttling through new -object
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 09 Jun 2017 06:06:09 PM CEST, Manos Pitsidianakis wrote:

>>>     -drive file=foo.qcow2,throttling.group=bar \
>>>     -object throttle-group,iops-total=100,id=bar
>>
>>, and I guess the name would be throttling-group?
>
> Hm, I thought throttle-group would be nicer because it's shorter, but
> I can change it, of course. I am not certain if there's a semantic
> difference (because I am not a native speaker).

I'm not a native speaker either, I was pointing out that we would have
throttling.group for -drive and then the throttle-group object.

Berto
