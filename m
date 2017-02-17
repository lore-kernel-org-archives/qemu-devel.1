Received: from eggs.gnu.org ([2001:4830:134:3::10]:44566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cekpr-000744-Ck
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cekpq-00034D-J5
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:52:39 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cekpq-000349-Bg
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:52:38 -0500
Received: by mail-wr0-x229.google.com with SMTP id i10so32272609wrb.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 07:52:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9d625bc9-4d35-a03b-03ea-4e68e24b2195@redhat.com>
References: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
	<9d625bc9-4d35-a03b-03ea-4e68e24b2195@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 15:52:16 +0000
Message-ID: <CAFEAcA8eNv0qRvULid3ungYGQXxvO3kN6uhBT07OFEHaL0864g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Makefile: Put VERSION info into
 version.texi rather than using -D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 17 February 2017 at 15:50, Eric Blake <eblake@redhat.com> wrote:
> On 02/17/2017 09:12 AM, Peter Maydell wrote:
>> Unfortunately some older versions of makeinfo don't correctly
>> handle the -D command line option and fail to set the variable.
>> This then causes them to complain
>>  docs/qemu-ga-ref.texi:41: warning: undefined flag: VERSION
>>
>> Work around this by doing as the autotools do, and writing
>> the information into a version.texi file which we then
>> include from the .texi files that need it.
>
> Autotools defines a few more macros, but we can always beef up our
> version.texi if we find ourselves needing any of them.
>
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  Makefile               | 17 ++++++++++-------
>>  docs/qemu-ga-ref.texi  |  2 ++
>>  docs/qemu-qmp-ref.texi |  2 ++
>>  3 files changed, 14 insertions(+), 7 deletions(-)
>
> Missing a change to .gitignore for version.texi.

Should be
--- a/.gitignore
+++ b/.gitignore
@@ -107,6 +107,7 @@ docs/qemu-ga-ref.info*
 docs/qemu-qmp-ref.info*
 /qemu-ga-qapi.texi
 /qemu-qapi.texi
+/version.texi
 *.tps
 .stgit-*
 cscope.*

right?

thanks
-- PMM
