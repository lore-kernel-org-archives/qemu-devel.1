Received: from eggs.gnu.org ([2001:4830:134:3::10]:39538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxwEv-0002rf-9p
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dxwEs-0001kn-6u
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dxwEs-0001kR-1h
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 10:26:02 -0400
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
Date: Fri, 29 Sep 2017 16:25:55 +0200
MIME-Version: 1.0
In-Reply-To: <c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 29/09/2017 16:14, Michael Fritscher wrote:
>> Yes, that's pretty much the only way to do it; it's not the easiest
>> thing because you have to use NT kernel APIs (NtCreateFile) rather tha=
n
>> e.g. CreateFile.  Likewise for NtQueryAttributesFile,
>> NtQueryDirectoryObject, etc. NtOpenDirectoryObject. :(
>>
>> Paolo
>>
> Hi,
>=20
> why do I need the NT* functions instead of the "normal" ones from
> kernel32? And it was working even with the posix functions some time ag=
o
> (Which I'll port to current qemu atm)

openat lets you create a file from a directory handle and relative path.
 CreateFile doesn't let you do that, only the ntdll functions can.

Paolo
