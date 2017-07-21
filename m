Received: from eggs.gnu.org ([2001:4830:134:3::10]:41594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYVxK-0005VF-To
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dYVxH-0008AD-QU
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 07:18:50 -0400
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-5-git-send-email-peter.maydell@linaro.org>
	<b27c6322-49f7-3f73-6df3-e8f4ddae9652@redhat.com>
	<CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0ed4e0fb-3699-f633-ee6f-ccd4b6494563@redhat.com>
Date: Fri, 21 Jul 2017 13:18:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9vTrpRL-cihQ-DtDj2TYAbNtzLf8b-WTAx+4Mz5xoKiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 19.07.2017 10:19, Peter Maydell wrote:
> On 18 July 2017 at 23:01, Eric Blake <eblake@redhat.com> wrote:
>> On 07/18/2017 11:26 AM, Peter Maydell wrote:
>>> On OpenBSD the compiler warns:
>>> bsd-user/main.c:622:21: warning: variable 'sig' set but not used [-Wunused-but-set-variable]
>>>
>>> This is because a lot of the signal delivery code is #if-0'd
>>> out as unused. Reshuffle #ifdefs a bit to silence the warning.
>>
>> Why not just nuke the #if 0 code instead (we can always 'git revert' it
>> later as a starting point for someone that wants to implement it).
> 
> I went for the minimal change, especially given we know
> that the freebsd folks have a big patchset on top of
> us fixing a lot of bsd-user code and it didn't seem worth
> giving them a more awkward rebase task.

That's fair. So FWIW:

Reviewed-by: Thomas Huth <thuth@redhat.com>
