Received: from eggs.gnu.org ([2001:4830:134:3::10]:43054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frzOo-0005HI-Th
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frzEf-0001QV-Jy
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:29:49 -0400
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
	<c350ae62-2712-79cc-e7e6-b88ae3fbc044@weilnetz.de>
	<008c57ea-0050-b5f0-4d68-db660cba269e@weilnetz.de>
	<f4367121-e7fd-505b-7627-5ebee146dc5b@weilnetz.de>
	<CABLmASEoBy3xzx4VY+HDJ0RY57axngP1rnXc2JqQcg0DfaC+RQ@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <d12dcaea-73d9-48af-db3b-fe29b8740242@weilnetz.de>
Date: Tue, 21 Aug 2018 07:29:38 +0200
MIME-Version: 1.0
In-Reply-To: <CABLmASEoBy3xzx4VY+HDJ0RY57axngP1rnXc2JqQcg0DfaC+RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bugs when cross-compiling qemu for Windows with
 mingw 8.1, executable doesn't run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Ben Pye <ben@curlybracket.co.uk>

Am 20.08.2018 um 22:39 schrieb Howard Spoelstra:
> Confirmed, adding --disable-stack-protector to configure results in a
> working binary.
> 
> Great, thanks,
> Howard

There is already a bug report for gcc:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86832

It looks like not only Windows but also MacOS is affected.

Cheers
Stefan
