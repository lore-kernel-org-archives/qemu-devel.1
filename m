Received: from eggs.gnu.org ([2001:4830:134:3::10]:39711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1cqIJw-00005U-Hv
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1cqIJt-0005MD-BG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:51:24 -0400
Received: from [59.151.112.132] (port=10509 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1cqIJs-0005KF-VR
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 07:51:21 -0400
References: <1490091581-21912-1-git-send-email-maozy.fnst@cn.fujitsu.com>
	<CAFEAcA-voeh7zLHEugB8chErQ2y1OsdMZgvuAKrpb26qg8Dffw@mail.gmail.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <4b35cf17-8d3b-d525-857b-72c83d03b8b2@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 19:45:40 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-voeh7zLHEugB8chErQ2y1OsdMZgvuAKrpb26qg8Dffw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] elfload: Replace malloc with g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>



On 03/21/2017 06:50 PM, Peter Maydell wrote:
> On 21 March 2017 at 10:19, Mao Zhongyi <maozy.fnst@cn.fujitsu.com> wrote:
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  bsd-user/elfload.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> Thanks for this patch. How have you tested it? (You'd need to be
> on a BSD host system to test). I ask because bsd-user is currently
> not really maintained, and so I'm a bit reluctant to take cleanup
> patches to code we aren't building and testing.
>

Thanks for your quick response, due to lack of environment, I just have 
done make check, will install a bsd host as soon as possible. Is just 
starting qemu in bsd enough for test?

thanks
-- Mao
