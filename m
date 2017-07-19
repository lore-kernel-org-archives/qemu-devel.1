Received: from eggs.gnu.org ([2001:4830:134:3::10]:54299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXkCf-0005Ns-30
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXkCe-0008Hr-9H
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:19:29 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXkCe-0008HN-2s
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:19:28 -0400
Received: by mail-wm0-x232.google.com with SMTP id g127so7831064wmd.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 01:19:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
	<b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 09:19:06 +0100
Message-ID: <CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 4/4] bsd-user/main.c: Fix unused
 variable warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 18 July 2017 at 23:01, Eric Blake <eblake@redhat.com> wrote:
> On 07/18/2017 11:26 AM, Peter Maydell wrote:
>> On OpenBSD the compiler warns:
>> bsd-user/main.c:622:21: warning: variable 'sig' set but not used [-Wunused-but-set-variable]
>>
>> This is because a lot of the signal delivery code is #if-0'd
>> out as unused. Reshuffle #ifdefs a bit to silence the warning.
>
> Why not just nuke the #if 0 code instead (we can always 'git revert' it
> later as a starting point for someone that wants to implement it).

I went for the minimal change, especially given we know
that the freebsd folks have a big patchset on top of
us fixing a lot of bsd-user code and it didn't seem worth
giving them a more awkward rebase task.

thanks
-- PMM
