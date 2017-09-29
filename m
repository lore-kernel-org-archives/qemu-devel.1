Received: from eggs.gnu.org ([2001:4830:134:3::10]:40071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxzix-0001eA-5D
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxzis-0000iU-6P
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:09:19 -0400
Received: from mifritscher.de ([188.40.170.105]:57720
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxzis-0000hu-0N
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:09:14 -0400
Message-ID: <801da6ddaef2199b0ad1f9b31c7b7fc3.squirrel@mifritscher.de>
In-Reply-To: <497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
	<497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
Date: Fri, 29 Sep 2017 20:09:11 +0200
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

> On 29/09/2017 16:14, Michael Fritscher wrote:
>>> Yes, that's pretty much the only way to do it; it's not the easiest
>>> thing because you have to use NT kernel APIs (NtCreateFile) rather th=
an
>>> e.g. CreateFile.  Likewise for NtQueryAttributesFile,
>>> NtQueryDirectoryObject, etc. NtOpenDirectoryObject. :(
>>>
>>> Paolo
>>>
>> Hi,
>>
>> why do I need the NT* functions instead of the "normal" ones from
>> kernel32? And it was working even with the posix functions some time a=
go
>> (Which I'll port to current qemu atm)
>
> openat lets you create a file from a directory handle and relative path=
.
>  CreateFile doesn't let you do that, only the ntdll functions can.
>
> Paolo

Yes, my plan was to emulate this (as it was done in qemu a year or so ago
in Linux as well). So I can do that or use direct Win32/NT api. But then =
I
should rewrite 9p_local completely and make a 9p_windows I guess?

Michael
