Received: from eggs.gnu.org ([2001:4830:134:3::10]:43134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mans@mansr.com>) id 1cVbeR-000501-A4
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mans@mansr.com>) id 1cVbeO-0002RU-4d
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:15:03 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:41076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mans@mansr.com>) id 1cVbeN-0002R6-Uj
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:15:00 -0500
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<CAJ+F1C+WV7OhxpYb3RgmtRjXU7_kfygr2jh2cawYwZq8MMrJGQ@mail.gmail.com>
	<79bc9757-3ba0-87c3-3502-a25a30e304a3@siemens.com>
	<286AC319A985734F985F78AFA26841F73916DDD2@shsmsx102.ccr.corp.intel.com>
	<58a51a88-967d-bdc7-dc0b-e3e501ecccd3@siemens.com>
	<286AC319A985734F985F78AFA26841F7391716D9@shsmsx102.ccr.corp.intel.com>
	<778e7730-8ece-9cc4-000c-9ced0b29d503@siemens.com>
	<286AC319A985734F985F78AFA26841F739175F99@shsmsx102.ccr.corp.intel.com>
Date: Mon, 23 Jan 2017 10:14:53 +0000
In-Reply-To: <286AC319A985734F985F78AFA26841F739175F99@shsmsx102.ccr.corp.intel.com>
	(Wei W. Wang's message of "Mon, 23 Jan 2017 03:49:06 +0000")
Message-ID: <yw1xvat6hyle.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Jailhouse <jailhouse-dev@googlegroups.com>, Markus Armbruster <armbru@redhat.com>

"Wang, Wei W" <wei.w.wang@intel.com> writes:

> On Saturday, January 21, 2017 12:38 AM, Jan Kiszka wrote:
>> On 2017-01-20 12:54, Wang, Wei W wrote:
>>> Having a theoretical analysis on the performance: The traditional
>>> shared memory mechanism, sharing an intermediate memory, requires 2
>>> copies to get the packet transmitted. It's not just one more copy
>>> compared to the 1-copy solution, I think some more things we may
>>> need to take into account:
>>=20
>> 1-copy (+potential transfers to userspace, but that's the same for
>> everyone) is conceptually possible, definitely under stacks like
>> DPDK.  However, Linux skbs are currently not prepared for picking up
>> shmem-backed packets, we already looked into this. Likely
>> addressable, though.
>
> Not sure how difficult it would be to get that change upstream-ed to
> the kernel, but looking forward to seeing your solutions.

The problem is that the shared memory mapping doesn't have a struct page
as required by lots of networking code.

--=20
M=E5ns Rullg=E5rd
