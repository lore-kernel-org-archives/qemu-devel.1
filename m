Received: from eggs.gnu.org ([2001:4830:134:3::10]:39802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIPFv-0008NI-Vf
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIPFv-0003Z3-8S
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:55:28 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1496481564-20545-1-git-send-email-jcmvbkbc@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cdeaf0b3-e304-3518-9d71-95a30e85a8a1@twiddle.net>
Date: Tue, 6 Jun 2017 17:55:18 -0700
MIME-Version: 1.0
In-Reply-To: <1496481564-20545-1-git-send-email-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: handle unknown registers in
 gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

On 06/03/2017 02:19 AM, Max Filippov wrote:
> +        memset(mem_buf, 0, reg->size);
> +        return reg->size;
>           return 0;

Leaving a dead return.


r~
