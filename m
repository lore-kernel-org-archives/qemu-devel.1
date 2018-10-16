Received: from eggs.gnu.org ([2001:4830:134:3::10]:45111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gCMJB-0003ti-U9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gCMJ9-0008Cg-GG
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gCMJ9-0007VT-7s
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:10:35 -0400
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_meKcp2pALQEKegYZOi-XVndRAd8+P7mOSNJFhm+-=RA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <066a1675-8030-9e59-7a2c-7cfeca6f5f28@redhat.com>
Date: Tue, 16 Oct 2018 18:10:09 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_meKcp2pALQEKegYZOi-XVndRAd8+P7mOSNJFhm+-=RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/26] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


On 2018/10/15 =E4=B8=8B=E5=8D=889:20, Peter Maydell wrote:
> On 15 October 2018 at 09:46, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit a73549f99612f758dec0fdea6ae1c30b6c7=
09a0b:
>>
>>    Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181012-pull-=
request' into staging (2018-10-12 16:45:51 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to a7ec0077c2db445d6bae421963188367d2695bd=
6:
>>
>>    qemu-options: Fix bad "macaddr" property in the documentation (2018=
-10-15 16:14:15 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> Hi; there seems to be a format string issue in this pullreq:
>
> In file included from hw/net/trace.c:4:0:
> hw/net/trace.h: In function '_nocheck__trace_e1000_receiver_overrun':
> hw/net/trace.h:2696:18: error: format '%lu' expects argument of type
> 'long unsigned int', but argument 5 has type 'size_t {aka long long
> unsigned int}' [-Werror=3Dformat=3D]
>           qemu_log("%d@%zu.%06zu:e1000_receiver_overrun " "Receiver
> overrun: dropped packet of %lu bytes, RDH=3D%u, RDT=3D%u" "\n",
>                    ^
>
> which means it won't compile on 32-bit hosts.
>
> thanks
> -- PMM


Sorry, will post V2.

Thanks
