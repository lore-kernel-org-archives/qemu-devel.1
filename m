Received: from eggs.gnu.org ([2001:4830:134:3::10]:34009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06FW-0000zq-2U
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g06FS-0002Vj-Sj
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:36:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g06FS-0002Qi-My
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:36:06 -0400
References: <CAB3eZfv6QFAABhzxCKjVY_36j9th_3sbcbzaOQTGkm0mhJ-BoQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <314d0a84-c0b5-3bbb-168d-360f5027a913@redhat.com>
Date: Wed, 12 Sep 2018 09:36:04 -0500
MIME-Version: 1.0
In-Reply-To: <CAB3eZfv6QFAABhzxCKjVY_36j9th_3sbcbzaOQTGkm0mhJ-BoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] What kind of situation to use internal or external
 snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9/11/18 8:32 PM, lampahome wrote:
> as title, I know there're two snapshots in qemu, but I don't know when to
> use them well.
> 
> What I know is internal snapshot will save the info of L1 and L2 table in
> the end of image but external snapshot won't because external snapshot
> create new file to save cow data.
> 
> So when to use internal snapshot or external snapshot?

In general, we've spent more resources developing external snapshots. So 
if you want the most support and the fastest response on resolving any 
issues that you may encounter, external snapshots are the way to go.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
