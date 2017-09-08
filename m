Received: from eggs.gnu.org ([2001:4830:134:3::10]:60596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dqLsv-0000YK-Vg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dqLss-0005JD-SD
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:12:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dqLss-0005I5-LY
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:11:58 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com>
	<82d6b8f0-7101-1d59-5489-43b66107fbe0@amd.com>
	<20170908155143.GK32645@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <57ffda5b-564c-a106-0f1e-a42485da55ef@redhat.com>
Date: Fri, 8 Sep 2017 18:11:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170908155143.GK32645@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Relph, Richard" <Richard.Relph@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 09/08/17 17:51, Daniel P. Berrange wrote:
> On Fri, Sep 08, 2017 at 10:48:10AM -0500, Brijesh Singh wrote:

>> I am looking at [1] to get the feel for how do we model it in the XML.
>> As you can see I am using ad-hoc <qemu:args> to create the sev-guest
>> object. Currently, sev-guest object accepts the following properties:
>>
>> dh-cert-file: <file containing the GO DH key>
>> session-info-file: <file contain the GO session info>
>> policy: <int32 GO policy>
>>
>> I believe the new XML model will influence the property input type,
>> Any recommendation on how do model this part ? thank you so much.
> 
> That looks ok to me - even if QEMU wants the data provided in
> files on disk, libvirt can just create the files on the fly
> from the data it has in the <sev> element in the XML file.
> Since they're only needed during startup, libvirt can then
> easily delete the files the moment QEMU has completed its
> startup.

/dev/fd/N filenames could be used for poor man's fd passing, I think.

(/dev/fd is a symlink to the /proc/self/fd directory)

proc(5) has documentation on this.

Thanks,
Laszlo
