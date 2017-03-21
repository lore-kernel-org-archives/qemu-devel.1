Received: from eggs.gnu.org ([2001:4830:134:3::10]:47712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cqCRn-0004gB-8X
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cqCRi-0007Rv-DZ
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:35:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:36419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cqCRi-0007PK-0O
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:35:02 -0400
References: <20170316141953.16161-1-jgross@suse.com>
	<20170316141953.16161-3-jgross@suse.com>
	<alpine.DEB.2.10.1703161306380.15430@sstabellini-ThinkPad-X260>
	<214bc24d-1c0c-16d6-9c33-e20962b150d2@suse.com>
	<alpine.DEB.2.10.1703171123520.22036@sstabellini-ThinkPad-X260>
From: Juergen Gross <jgross@suse.com>
Message-ID: <da852b5f-2490-c483-984d-c7be4f83b9a7@suse.com>
Date: Tue, 21 Mar 2017 06:34:56 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1703171123520.22036@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] configure: use pkg-config for
 obtaining xen version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, kraxel@redhat.com, paul.durrant@citrix.com

On 17/03/17 19:33, Stefano Stabellini wrote:
> On Fri, 17 Mar 2017, Juergen Gross wrote:
>> On 16/03/17 21:20, Stefano Stabellini wrote:
>>> On Thu, 16 Mar 2017, Juergen Gross wrote:
>>>> Instead of trying to guess the Xen version to use by compiling various
>>>> test programs first just ask the system via pkg-config. Only if it
>>>> can't return the version fall back to the test program scheme.
>>>
>>> That's OK, but why did you remove the Xen unstable test?
>>
>> >From Xen 4.9 on pkg-config will return the needed information. There is
>> no longer a need for a test program to determine the Xen version. After
>> all this was the main objective of my series adding the pkg-config
>> files to Xen.
> 
> I was going to say something like "yeah, but is pkg-config always
> available?" In reality, QEMU already has pkg-config as build
> dependency, so I guess there is no problem with that.
> 
> Please add a note about this to the commit message.
> 

Okay.


Juergen
