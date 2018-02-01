Received: from eggs.gnu.org ([2001:4830:134:3::10]:54349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh4bk-0001ob-Eb
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eh4bh-0006KW-9X
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:28:12 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eh4bh-0006K6-46
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:28:09 -0500
Received: by mail-wr0-f172.google.com with SMTP id h9so4175811wre.12
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 18:28:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d5aec275-0c13-00fb-2116-10e3c5ed2b37@redhat.com>
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-3-armbru@redhat.com>
	<d5aec275-0c13-00fb-2116-10e3c5ed2b37@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Thu, 1 Feb 2018 10:27:37 +0800
Message-ID: <CAK1Eb9nhn08NSPXG5Prw+fuCiN-dEOgqbUrr0WY+6T+h8iuEsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 02/19] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Wed, Jan 31, 2018 at 11:48 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 31.01.2018 15:48, Markus Armbruster wrote:
>> Clean up includes so that osdep.h is included first and headers
>> which it implies are not included manually.
>>
>> This commit was created with scripts/clean-includes, with the change
>> to target/s390x/gen-features.c manually reverted, and blank lines
>> around deletions collapsed.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> I wonder whether it would make sense to add a check based on
> scripts/clean-includes to patchew already, so that these includes do not
> sneak in so easily again...?

(Having not looked at the series), are we clean with this series
applied? If so it makes a good point to do so.

Fam

>
>  Thomas
