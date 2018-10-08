Received: from eggs.gnu.org ([2001:4830:134:3::10]:43436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1g9Y2C-0001aZ-Ga
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1g9Y24-000115-Eh
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:05:24 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20181008153204.18845-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a7c21fdb-8b4c-d176-7b9a-4378af785194@twiddle.net>
Date: Mon, 8 Oct 2018 09:04:52 -0700
MIME-Version: 1.0
In-Reply-To: <20181008153204.18845-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: always enable AFP for linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/8/18 8:32 AM, David Hildenbrand wrote:
> linux-user should always enable AFP, otherwise our emulated binary
> might crash once it tries to make use of additional floating-point
> registers or instructions.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Fixes: db0504154e ("s390x/tcg: check for AFP-register, BFP and DFP data exceptions")
> Reported-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
