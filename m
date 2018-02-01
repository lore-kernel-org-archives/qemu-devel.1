Received: from eggs.gnu.org ([2001:4830:134:3::10]:41547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh96D-0000Ej-Bg
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eh96B-00064R-EC
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:15:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eh96B-000642-8c
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 02:15:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-3-armbru@redhat.com>
	<d5aec275-0c13-00fb-2116-10e3c5ed2b37@redhat.com>
	<CAK1Eb9nhn08NSPXG5Prw+fuCiN-dEOgqbUrr0WY+6T+h8iuEsQ@mail.gmail.com>
Date: Thu, 01 Feb 2018 08:15:49 +0100
In-Reply-To: <CAK1Eb9nhn08NSPXG5Prw+fuCiN-dEOgqbUrr0WY+6T+h8iuEsQ@mail.gmail.com>
	(Fam Zheng's message of "Thu, 1 Feb 2018 10:27:37 +0800")
Message-ID: <877erxrxi2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/19] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

Fam Zheng <famz@redhat.com> writes:

> On Wed, Jan 31, 2018 at 11:48 PM, Thomas Huth <thuth@redhat.com> wrote:
>> On 31.01.2018 15:48, Markus Armbruster wrote:
>>> Clean up includes so that osdep.h is included first and headers
>>> which it implies are not included manually.
>>>
>>> This commit was created with scripts/clean-includes, with the change
>>> to target/s390x/gen-features.c manually reverted, and blank lines
>>> around deletions collapsed.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> I wonder whether it would make sense to add a check based on
>> scripts/clean-includes to patchew already, so that these includes do not
>> sneak in so easily again...?
>
> (Having not looked at the series), are we clean with this series
> applied? If so it makes a good point to do so.

It isn't, but I guess it could be made clean with a bit of work both on
sources and the script.
