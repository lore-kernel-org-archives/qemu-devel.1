Received: from eggs.gnu.org ([2001:4830:134:3::10]:45912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fpdc7-0000ag-Im
	for Qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fpdbk-0000V9-Ti
	for Qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:00:15 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <91ef77d7-026d-4930-bd4c-a94b17fa247c@redhat.com>
Date: Tue, 14 Aug 2018 13:59:03 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F2A70F6-B51E-4EDB-8C89-DC239384E32A@gmail.com>
References: <20180730212249.16418-1-programmingkidx@gmail.com>
	<5679ec6f-e2d7-e139-1b56-304540c89977@redhat.com>
	<f6fcbd58-2462-d432-a038-cc13bb0dcf23@redhat.com>
	<20180814084047.GD5025@dhcp-200-186.str.redhat.com>
	<91ef77d7-026d-4930-bd4c-a94b17fa247c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: increase spacing between
 commands in documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Qemu-devel@nongnu.org


> On Aug 14, 2018, at 8:55 AM, Eric Blake <eblake@redhat.com> wrote:
>=20
> On 08/14/2018 03:40 AM, Kevin Wolf wrote:
>>> And I've already expressed my opinion that it is already rather =
long, where
>>> making it longer is not necessarily making it smarter.
>> I think if we want to improve the help text, we should split it up.
>> $ qemu-img --help
>> qemu-img version 2.12.94 (v3.0.0-rc4-5-g4fe9c3e13d-dirty)
>> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project =
developers
>> usage: qemu-img [standard options] command [command options]
>> QEMU disk image utility
>>     '-h', '--help'       display this help and exit
>>     '-V', '--version'    output version information and exit
>>     '-T', '--trace'      =
[[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]
>>                          specify tracing options
>> Commands:
>>     amend               Change options of an existing disk image
>>     bench               Run benchmarks on a given disk image
>>     check               Check the disk image for consistency or =
repair it
>>     commit              Merge the disk image into its backing file
>>     ...
>> Run 'qemu-img <command> --help' for details.
>> See <https://qemu.org/contribute/report-a-bug> for how to report =
bugs.
>> More information on the QEMU project at <https://qemu.org>.
>=20
> Indeed, that matches the approach that 'cvs --help' and 'git --help' =
have taken. I could live with a split along those lines as being =
something smarter.  When you want to learn the options for 'create', you =
may have to ask two different --help commands to learn everything you =
need ['--help' didn't give me enough, but told me to use 'create =
--help'], but at least you are not inundated with answers irrelevant to =
the question you are asking, so you don't have to scroll through a wall =
of text.

I also like the idea. It seems very organized and neat.
