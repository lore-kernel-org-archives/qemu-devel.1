Received: from eggs.gnu.org ([209.51.188.92]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggV8s-0004hH-5N
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:40:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggV8r-0007JU-BN
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:40:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-4-philmd@redhat.com>
	<349cd87b-0526-30b8-d9cd-0eee537ab5a4@redhat.com>
Date: Mon, 07 Jan 2019 14:40:01 +0100
In-Reply-To: <349cd87b-0526-30b8-d9cd-0eee537ab5a4@redhat.com> (Eric Blake's
	message of "Fri, 4 Jan 2019 14:17:14 -0600")
Message-ID: <874lakk2mm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Eric Blake <eblake@redhat.com> writes:

> On 1/4/19 12:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Many functions have documentation before the implementation in
>> cutils.c. Since we expect documentation around the prototype
>> declaration in headers, move the comments in cutils.h.
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  include/qemu/cutils.h | 224 ++++++++++++++++++++++++++++++++++++++++++
>>  util/cutils.c         | 185 ----------------------------------
>>  2 files changed, 224 insertions(+), 185 deletions(-)
>
> I find documentation in .c files slightly easier to use (you can then
> read the code right below to see if the documentation is still
> accurate);

This is the kicker for me.  I try to cultivate a healthy suspicion of
comments in general, x10 for comments acting at a distance.

>            but as we had an inconsistent mix, I'm also okay with your
> patch consolidating all the documentation to one of the two files,
> rather than the bad mix of half-and-half.

Concur.
