Received: from eggs.gnu.org ([2001:4830:134:3::10]:59442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6ouv-0003cY-Mz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6ouu-0000oa-N2
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:26:09 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <150860960347.476.5295412873363332990@b58463cdfd5f>
	<alpine.DEB.2.10.1710231352260.574@sstabellini-ThinkPad-X260>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <35a705b8-b90b-d84e-9d2d-5ce983da5fda@amsat.org>
Date: Mon, 23 Oct 2017 23:25:41 -0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1710231352260.574@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2] fix WFI/WFE length in
 syndrome register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, famz@redhat.com, qemu-arm@nongnu.org

On 10/23/2017 05:52 PM, Stefano Stabellini wrote:
> On Sat, 21 Oct 2017, no-reply@patchew.org wrote:
>> Makefile:30: recipe for target 'git-submodule-update' failed
>> make: *** [git-submodule-update] Error 1
>> make: *** Waiting for unfinished jobs....
>> make: *** wait: No child processes.  Stop.
>> === OUTPUT END ===
>>
>> Test command exited with code: 2
> 
> This is a false positive, isn't it?

Yes, it should be now fixed:
http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg05484.html
