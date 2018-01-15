Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eavat-0005V6-3s
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eavao-0004fO-6n
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:37:55 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eavao-0004f5-0f
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 22:37:50 -0500
Received: by mail-pl0-x244.google.com with SMTP id d21so2738752pll.1
	for <qemu-devel@nongnu.org>; Sun, 14 Jan 2018 19:37:49 -0800 (PST)
References: <2f3d36f8.1ce36.160f49d0471.Coremail.linzc@zju.edu.cn>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <adef140f-7a4e-d3e0-a66a-39e2fa529757@ozlabs.ru>
Date: Mon, 15 Jan 2018 14:37:44 +1100
MIME-Version: 1.0
In-Reply-To: <2f3d36f8.1ce36.160f49d0471.Coremail.linzc@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] question about share flatviews
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: CheneyLin <linzc@zju.edu.cn>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 14/01/18 23:20, CheneyLin wrote:
> Hi， Paolo,
> 
> Alexey
> commit 967dc9b
> 
> commit 967dc9b
> 
> 
> commit 967dc9b
> 
> commit 967dc9b Share FlatView's and dispatch trees between address spaces
> 
>  commit 967dc9b.
> 
> . 
> 
> I'm wondering why we have to shares flatviews between different ASes.

Flatviews are only shared between address spaces which have the same root
MR, basically.

> In my
> opinion, arch like x86 only have two ASes(memory AS and io AS), each AS is
> related with only one flatview. Their ASes are definitely different.

Sure, and they are not shared as memory AS and IO AS have different MRs are
a root.


-- 
Alexey
