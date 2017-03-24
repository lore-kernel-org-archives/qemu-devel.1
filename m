Received: from eggs.gnu.org ([2001:4830:134:3::10]:38087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crNKY-0007tE-Qd
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crNKX-0001qp-Uc
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:24:30 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crNKX-0001qU-NT
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:24:29 -0400
Received: by mail-wr0-x231.google.com with SMTP id l43so7368494wre.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 04:24:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170323194122.GD9606@toto>
References: <1490272961-1128-1-git-send-email-peter.maydell@linaro.org>
	<20170323194122.GD9606@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 11:24:07 +0000
Message-ID: <CAFEAcA8QG5__PQqYy_o-CmyVby5H0ZM8y6vkGbOYTTBxHr5F_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] disas/microblaze: Remove unused
 REG_PC define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 23 March 2017 at 19:41, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Thu, Mar 23, 2017 at 12:42:41PM +0000, Peter Maydell wrote:
>> The REG_PC define in disas/microblaze.c clashes with a define in
>> the Linux SPARC system headers:
>>
>> /home/pm215/qemu/disas/microblaze.c:162:0: error: "REG_PC" redefined [-Werror]
>>  #define REG_PC  32 /* PC */
>>
>> In file included from /usr/include/signal.h:326:0,
>>                  from /home/pm215/qemu/include/qemu/osdep.h:86,
>>                  from /home/pm215/qemu/disas/microblaze.c:36:
>> /usr/include/sparc64-linux-gnu/sys/ucontext.h:96:0: note: this is the location of the previous definition
>>  #define REG_PC  (1)
>>
>> Since the code doesn't actually use the REG_PC define
>> anywhere, the simplest fix is just to remove it.
>
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Thanks; applied to master.

-- PMM
