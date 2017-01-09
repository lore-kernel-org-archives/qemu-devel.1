Received: from eggs.gnu.org ([2001:4830:134:3::10]:53845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cQQhi-0007W0-RM
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cQQhd-0007RJ-Tq
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:33:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cQQhd-0007R8-Nv
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:32:57 -0500
References: <1483690133-25104-1-git-send-email-lprosek@redhat.com>
	<F68AE366-F432-43FA-BBD8-6B4EF72BDC14@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c9214859-d672-5f13-3d01-09325204c6bb@redhat.com>
Date: Mon, 9 Jan 2017 11:32:48 +0800
MIME-Version: 1.0
In-Reply-To: <F68AE366-F432-43FA-BBD8-6B4EF72BDC14@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: optimize checksum computation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B401=E6=9C=8808=E6=97=A5 17:03, Dmitry Fleytman wrote:
>> On 6 Jan 2017, at 10:08 AM, Ladi Prosek <lprosek@redhat.com> wrote:
>>
>> Very simple loop optimization with a significant performance impact.
>>
>> Microbenchmark results, modern x86-64:
>>
>> buffer size | speed up
>> ------------+---------
>> 1500        | 1.7x
>> 64          | 1.5x
>> 8           | 1.15x
>>
>> Microbenchmark results, POWER7:
>>
>> buffer size | speed up
>> ------------+---------
>> 1500        | 5x
>> 64          | 3.3x
>> 8           | 1.13x
>>
>> There is a lot of room for further improvement at the expense of
>> code complexity - aligned multibyte reads, LE/BE considerations,
>> architecture-specific optimizations, etc. This patch still keeps
>> things simple and readable.
> Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
>

Applied to -net.

Thanks
