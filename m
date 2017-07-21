Received: from eggs.gnu.org ([2001:4830:134:3::10]:53434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZoR-0008Lf-Fy
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYZoQ-0000UP-J7
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:55 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYZoQ-0000Th-CD
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:25:54 -0400
Received: by mail-wm0-x230.google.com with SMTP id v139so4409153wmv.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:25:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dabe4865-05a0-eb85-f9db-8948db3e14bf@redhat.com>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
	<b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
	<CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
	<dabe4865-05a0-eb85-f9db-8948db3e14bf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 16:25:32 +0100
Message-ID: <CAFEAcA_T1CNZY+rnryt_r-kaffk838Q4jZOw9GogfQB7t-jFtA@mail.gmail.com>
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

On 21 July 2017 at 13:23, Eric Blake <eblake@redhat.com> wrote:
> On 07/19/2017 03:19 AM, Peter Maydell wrote:
>> On 18 July 2017 at 23:01, Eric Blake <eblake@redhat.com> wrote:
>>> On 07/18/2017 11:26 AM, Peter Maydell wrote:
>>>> On OpenBSD the compiler warns:
>>>> bsd-user/main.c:622:21: warning: variable 'sig' set but not used [-Wunused-but-set-variable]
>>>>
>>>> This is because a lot of the signal delivery code is #if-0'd
>>>> out as unused. Reshuffle #ifdefs a bit to silence the warning.
>>>
>>> Why not just nuke the #if 0 code instead (we can always 'git revert' it
>>> later as a starting point for someone that wants to implement it).
>>
>> I went for the minimal change, especially given we know
>> that the freebsd folks have a big patchset on top of
>> us fixing a lot of bsd-user code and it didn't seem worth
>> giving them a more awkward rebase task.
>
> Perhaps worth mentioning in the commit message that keeping the #if 0 is
> intentional, then. At any rate,
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks; applied to master with an updated commit message.


-- PMM
