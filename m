Received: from eggs.gnu.org ([2001:4830:134:3::10]:59927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cyww1-0006LP-Ha
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cywvy-0005wD-Fi
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:50:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59661 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cywvy-0005vA-8U
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 04:50:26 -0400
References: <1491903346-16075-1-git-send-email-andr2000@gmail.com>
	<alpine.DEB.2.10.1704131704560.2759@sstabellini-ThinkPad-X260>
	<693ebf90-00d7-823e-4db8-9b9686e56941@gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <f5ce758f-5f31-32d6-7e19-8c3a83017bab@suse.com>
Date: Fri, 14 Apr 2017 10:50:21 +0200
MIME-Version: 1.0
In-Reply-To: <693ebf90-00d7-823e-4db8-9b9686e56941@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] configure: introduce
 --enable-xen-fb-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Oleksandr Andrushchenko <andr2000@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: vlad.babchuk@gmail.com, qemu-devel@nongnu.org, andrii.anisov@gmail.com, olekstysh@gmail.com, al1img@gmail.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, joculator@gmail.com

On 14/04/17 08:06, Oleksandr Andrushchenko wrote:
> On 04/14/2017 03:12 AM, Stefano Stabellini wrote:
>> On Tue, 11 Apr 2017, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>
>>> For some use cases when Xen framebuffer/input backend
>>> is not a part of Qemu it is required to disable it,
>>> because of conflicting access to input/display devices.
>>> Introduce additional configuration option for explicit
>>> input/display control.
>> In these cases when you don't want xenfb, why don't you just remove
>> "vfb" from the xl config file? QEMU only starts the xenfb backend when
>> requested by the toolstack.
>>
>> Is it because you have an alternative xenfb backend? If so, is it really
>> fully xenfb compatible, or is it a different protocol? If it is a
>> different protocol, I suggest you rename your frontend/backend PV device
>> name to something different from "vfb".
>>
> Well, offending part is vkbd actually (for multi-touch
> we run our own user-space backend which supports
> kbd/ptr/mtouch), but vfb and vkbd is the same backend
> in QEMU. So, I am ok for vfb, but just want vkbd off
> So, there are 2 options:
> 1. At compile time remove vkbd and still allow vfb
> 2. Remove xenfb completely, if acceptable (this is my case)

What about adding a Xenstore entry for backend type and let qemu test
for it being not present or containing "qemu"?


Juergen
