Received: from eggs.gnu.org ([2001:4830:134:3::10]:46288)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1d1ClD-00052h-2e
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1d1Cl9-0008Pg-2K
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:08:38 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:33500 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1d1Cl8-0008N3-Oe
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 10:08:34 -0400
References: <1488288927-4607-1-git-send-email-pl@kamp.de>
	<20170420140514.GM24486@lemon.lan>
From: Peter Lieven <pl@kamp.de>
Message-ID: <a5a4fb7e-8e2f-2031-bbdd-0abb15fdba10@kamp.de>
Date: Thu, 20 Apr 2017 16:08:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170420140514.GM24486@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, stefanha@gmail.com, mreitz@redhat.com, eblake@redhat.com

Am 20.04.2017 um 16:05 schrieb Fam Zheng:
> On Tue, 02/28 14:35, Peter Lieven wrote:
>> img_convert has been around before there was an ImgConvertState or
>> a block backend, but it has never been modified to directly use
>> these structs. Change this by parsing parameters directly into
>> the ImgConvertState and directly use BlockBackend where possible.
>> Futhermore variable initalization has been reworked and sorted.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
> I see an iotest failure with this patch, in Kevin's block-next tree:
>
> 019 1s ... - output mismatch (see 019.out.bad)
> --- /stor/work/qemu/tests/qemu-iotests/019.out	2017-04-17 16:19:56.523968474 +0800
> +++ 019.out.bad	2017-04-20 22:03:29.868216955 +0800
> @@ -1086,8 +1086,8 @@
>   
>   Checking if backing clusters are allocated when they shouldn't
>   
> -0/128 sectors allocated at offset 1 MiB
> -0/128 sectors allocated at offset 4.001 GiB
> +128/128 sectors allocated at offset 1 MiB
> +128/128 sectors allocated at offset 4.001 GiB
>   Reading
>   
>   === IO: pattern 42
> Failures: 019
> Failed 1 of 1 tests

Thanks for notifying, Fam.

@Kevin: Can you drop the patch again? I will send a V2 addressing this issue and the other comments

I have got.


Peter
