Received: from eggs.gnu.org ([2001:4830:134:3::10]:48107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eJSqW-0000ST-Pb
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 18:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eJSqV-0000AC-RT
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 18:29:52 -0500
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:41750
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1eJSqV-00005s-Jq
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 18:29:51 -0500
References: <20171126211356.GA46174@humpty.home.comstyle.com>
	<CAFEAcA_m0KMfsUYWpdg2LL2y5U88d4-LoXZuUXkGUxtGCgD66g@mail.gmail.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <9328bb53-636c-21ec-fa32-61847400986d@comstyle.com>
Date: Mon, 27 Nov 2017 18:29:39 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_m0KMfsUYWpdg2LL2y5U88d4-LoXZuUXkGUxtGCgD66g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Fix curses probe for older
 ncurses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11/27/17 07:02, Peter Maydell wrote:
> On 26 November 2017 at 22:13, Brad Smith <brad@comstyle.com> wrote:
>> Fix the curses probe with older ncurses (.e.g. 5.7, as used by OpenBSD).
>>
>> ncurses 5.7 requires _XOPEN_SOURCE_EXTENDED to be defined for WACS_* constants.
> 
> ncurses 5.7 was released in 2008 and is now 9 years old. Why
> is OpenBSD still using such an ancient version?
> 
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>
>>
>> diff --git a/configure b/configure
>> index 0c6e7572db..9715b9c2cc 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3186,7 +3186,7 @@ EOF
>>     IFS=:
>>     for curses_inc in $curses_inc_list; do
>>       # Make sure we get the wide character prototypes
>> -    curses_inc="-DNCURSES_WIDECHAR $curses_inc"
>> +    curses_inc="-DNCURSES_WIDECHAR -D_XOPEN_SOURCE_EXTENDED $curses_inc"
> 
> I'm a bit wary of this because we've found in the past that
> defining _XOPEN_* defines breaks compilation with some
> C libraries which assume that if you define _XOPEN_whatever
> it means "only that X/Open stuff and no OS-specific extras",
> and we depend on the OS-specific extras.
> 
> That said, I did a test compile on OSX, which was the
> one that had trouble previously, so this may be OK. I think
> I'd rather leave it until after 2.11 releases, though.

I am not in a rush for 2.11. This and the other issues being
mentioned are not new. Thanks for the consideration of the diff
at all.
