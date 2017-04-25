Received: from eggs.gnu.org ([2001:4830:134:3::10]:41702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2rbF-0004Vu-HQ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2rbB-0006sG-6j
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2rbB-0006s5-06
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:57:09 -0400
References: <1493010966-22976-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_9Du7_=-q2uGBKYporAQ+v8G9nGJNrcwJ1FCZ=OO8Hrw@mail.gmail.com>
	<282443be-9c8f-0135-6e6d-db6a71d66cbb@kaod.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2559b260-f1f6-1f4c-9cca-f8b424ca4420@redhat.com>
Date: Tue, 25 Apr 2017 11:57:03 +0800
MIME-Version: 1.0
In-Reply-To: <282443be-9c8f-0135-6e6d-db6a71d66cbb@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/8] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 2017=E5=B9=B404=E6=9C=8825=E6=97=A5 00:02, C=C3=A9dric Le Goater wrote=
:
> On 04/24/2017 03:49 PM, Peter Maydell wrote:
>> On 24 April 2017 at 06:15, Jason Wang <jasowang@redhat.com> wrote:
>>> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc=
68769d:
>>>
>>>    Merge remote-tracking branch 'remotes/juanquintela/tags/migration/=
20170421' into staging (2017-04-21 15:59:27 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>>
>>> for you to fetch changes up to 049f6d8237dd0b14dee02e4c22b20114c43cec=
ff:
>>>
>>>    COLO-compare: Optimize tcp compare trace event (2017-04-24 11:30:3=
6 +0800)
>>>
>>> ----------------------------------------------------------------
>>>
>>> ----------------------------------------------------------------
>> Hi. Clang picks up what looks like a typo:
>>
>> /Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: error: use
>> of logical '&&' with constant operand
>> [-Werror,-Wconstant-logical-operand]
>>      if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
>>                                  ^  ~~~~~~~~~~~~~~~~~~~~~~~
>> /Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: note: use
>> '&' for a bitwise operation
>>      if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
>>                                  ^~
>>                                  &
>> /Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: note:
>> remove constant to silence this warning
>>      if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
>>                                 ~^~~~~~~~~~~~~~~~~~~~~~~~~~
> Jason,
>
> How do you want to handle that ? A resend of the patch or a fix ?
>
> Thanks,
>
> C.
>

The fix looks trivial, let me fix it.

Thanks
