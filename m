Received: from eggs.gnu.org ([2001:4830:134:3::10]:37241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxw3z-0006Px-DC
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxw3w-0004YR-8A
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:14:47 -0400
Received: from mifritscher.de ([188.40.170.105]:35602
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxw3w-0004XX-1Z
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:14:44 -0400
Message-ID: <c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
In-Reply-To: <c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
Date: Fri, 29 Sep 2017 16:14:41 +0200
From: "Michael Fritscher" <michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

> On 29/09/2017 13:13, Michael Fritscher wrote:
>> "
>> The biggest issue seems to be the *at stuff. I'll
>> try to workaround this via getting the directories' path from the file
>> descriptor with the /proc (as it is already done in the 9pfs_utils) -
>> luckily,the mingw environment emulates the /proc. If this doesn't work
>> I've another idea (the file descriptors needs to be "registered" with
>> the
>> path (and saved in a sparse vector or map with the fd as key and the
>> path
>> as value). The "big" solution would be to write a 9p_local_windows.c
>> from
>> scratch, but I would like to avoid it.
>> "
>
> Yes, that's pretty much the only way to do it; it's not the easiest
> thing because you have to use NT kernel APIs (NtCreateFile) rather than
> e.g. CreateFile.  Likewise for NtQueryAttributesFile,
> NtQueryDirectoryObject, etc. NtOpenDirectoryObject. :(
>
> Paolo
>

Hi,

why do I need the NT* functions instead of the "normal" ones from
kernel32? And it was working even with the posix functions some time ago
(Which I'll port to current qemu atm)

>From the "host side", 9pfs does nothing special I think.

Best regards,
Michael Fritscher
