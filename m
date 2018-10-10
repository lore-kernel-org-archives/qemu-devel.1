Received: from eggs.gnu.org ([2001:4830:134:3::10]:50156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALs3-0004L1-ES
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALs0-0004vp-9h
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:18:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gALs0-0004um-2J
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 17:18:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id y16so7300267wrw.3
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 14:18:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180930232312.16486-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d33dd8cc-79b8-52dd-c588-008700bfce34@amsat.org>
Date: Wed, 10 Oct 2018 23:18:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180930232312.16486-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] tests/vm: Improvements when KVM is
 not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Ping?

On 10/1/18 1:23 AM, Philippe Mathieu-Daudé wrote:
> Hi Fam,
> 
> Since v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg03411.html
> - rebased on master
> - added get_default_jobs (Fam)
> - dropped 'When using TCG, wait longer for a VM to start'
> 
> Few patches I added while testing the VM tests without KVM access.
> I doubt many people want to suffer using TCG for VM testing, but
> it was handy to debug/support aarch64 VM tests.
> 
> Also this could be a useful TCG stress test...?
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (3):
>   tests/vm: Extract the kvm_available() handy function
>   tests/vm: Do not abuse parallelism when KVM is not available
>   tests/vm: Display remaining seconds to wait for a VM to start
> 
>  tests/vm/basevm.py | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
