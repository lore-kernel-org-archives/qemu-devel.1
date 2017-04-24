Received: from eggs.gnu.org ([2001:4830:134:3::10]:50071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2gS8-0004kR-6O
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2gS3-0001OX-A7
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:03:04 -0400
Received: from 3.mo7.mail-out.ovh.net ([46.105.34.113]:53154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d2gS3-0001NM-42
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 12:02:59 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 62B284C4C9
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 18:02:57 +0200 (CEST)
References: <1493010966-22976-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_9Du7_=-q2uGBKYporAQ+v8G9nGJNrcwJ1FCZ=OO8Hrw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <282443be-9c8f-0135-6e6d-db6a71d66cbb@kaod.org>
Date: Mon, 24 Apr 2017 18:02:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_9Du7_=-q2uGBKYporAQ+v8G9nGJNrcwJ1FCZ=OO8Hrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 04/24/2017 03:49 PM, Peter Maydell wrote:
> On 24 April 2017 at 06:15, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:
>>
>>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)
>>
>> are available in the git repository at:
>>
>>   https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 049f6d8237dd0b14dee02e4c22b20114c43cecff:
>>
>>   COLO-compare: Optimize tcp compare trace event (2017-04-24 11:30:36 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> 
> Hi. Clang picks up what looks like a typo:
> 
> /Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: error: use
> of logical '&&' with constant operand
> [-Werror,-Wconstant-logical-operand]
>     if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
>                                 ^  ~~~~~~~~~~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: note: use
> '&' for a bitwise operation
>     if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
>                                 ^~
>                                 &
> /Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: note:
> remove constant to silence this warning
>     if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
>                                ~^~~~~~~~~~~~~~~~~~~~~~~~~~

Jason,

How do you want to handle that ? A resend of the patch or a fix ?

Thanks,

C. 
