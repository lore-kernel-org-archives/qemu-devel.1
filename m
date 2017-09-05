Received: from eggs.gnu.org ([2001:4830:134:3::10]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMgz-0000yc-Po
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dpMgv-0003lB-BL
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 18:51:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-20-git-send-email-peter.maydell@linaro.org>
	<eb01a522-9cd5-070b-018a-8f0087d3a843@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <543fa529-6b85-0157-71b6-b8bdd58e03dd@amsat.org>
Date: Tue, 5 Sep 2017 19:51:29 -0300
MIME-Version: 1.0
In-Reply-To: <eb01a522-9cd5-070b-018a-8f0087d3a843@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 19/20] target/arm: Move
 regime_is_secure() to target/arm/internals.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org

On 08/29/2017 01:12 PM, Richard Henderson wrote:
> On 08/22/2017 08:08 AM, Peter Maydell wrote:
>> Move the regime_is_secure() utility function to internals.h;
>> we are going to want to call it from translate.c.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   target/arm/internals.h | 26 ++++++++++++++++++++++++++
>>   target/arm/helper.c    | 26 --------------------------
>>   2 files changed, 26 insertions(+), 26 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
