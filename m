Received: from eggs.gnu.org ([208.118.235.92]:46600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gfLpI-0006G1-KP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gfLpE-0002W4-Mx
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:31:36 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <3797d82c-a6a6-eb97-be0c-67316ee55e22@redhat.com>
References: <20190102110804.18155-1-lbloch@janustech.com>
	<20190102110804.18155-2-lbloch@janustech.com>
	<w51h8eqdroh.fsf@maestria.local.igalia.com>
	<9df1a9a8-284b-573b-98aa-fd77edb0cd65@janustech.com>
	<1ab08459-6635-acc2-0ba2-961c7a0e5704@redhat.com>
	<472c0a97-283b-ac81-c07d-11843edd2488@janustech.com>
	<3797d82c-a6a6-eb97-be0c-67316ee55e22@redhat.com>
Date: Fri, 04 Jan 2019 10:31:11 +0100
Message-ID: <w51y3806a74.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/1] include: Auto-generate the sizes
 lookup table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Ma?= =?utf-8?Q?thieu-Daud=C3=A9?= <philmd@redhat.com>

On Thu 03 Jan 2019 10:42:30 PM CET, Eric Blake wrote:

> In my view, code generators make sense when used on code that is
> expected to change over time (a good example is QAPI because we add
> new commands every release; other places might be a generator to help
> deal with syscall handlers since newer kernels can add a syscall; or
> even the fact that we have used some powerful GNU make textual
> processing to make it easy to add files to particular subsets of the
> build with as few lines edited as possible), where the goal is that
> the generator gives you both a compact representation that is easier
> to edit, and that the expansion from the generator ensures that
> repetitive boilerplate is formed without typos.  In short, if a
> generator results in a net reduction in lines of edited source in
> relation to the lines it produces, AND if the source that gets
> regenerated is likely to change, then it makes total sense to spend
> time on the generator.  But when the amount of effort to write a
> generator costs as much as just hard-coding the list outright,
> especially when the list is not going to change (there really aren't
> any other powers of 2 within 64 bits), I'm not sure a generator adds
> any value.

I agree with Eric.

Berto
