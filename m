Received: from eggs.gnu.org ([209.51.188.92]:35143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1giw8a-00029S-US
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1giw8a-00008Q-9h
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:54:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190111191401.18317-1-armbru@redhat.com>
	<5c18782a-4319-e87b-6b1f-6c808d837430@janustech.com>
Date: Mon, 14 Jan 2019 07:54:14 +0100
In-Reply-To: <5c18782a-4319-e87b-6b1f-6c808d837430@janustech.com> (Leonid
	Bloch's message of "Sun, 13 Jan 2019 09:42:27 +0000")
Message-ID: <875zurybjd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] block: Eliminate the S_1KiB, S_2KiB,
 ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Leonid Bloch <lbloch@janustech.com> writes:

> On 1/11/19 9:14 PM, Markus Armbruster wrote:
>> Back in September, Leonid Block added a whole bunch of macros (commit
>
> * Bloch. :)

I apologize for my carelessness.  Explanation, no excuse:

    $ git-log --author=3Darmbru -Sblock -i --oneline | wc -l
    167
    $ git-log --author=3Darmbru -Sbloch -i --oneline | wc -l
    0

D=C3=A9formation professionnelle...

[...]
