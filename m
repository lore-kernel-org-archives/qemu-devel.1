Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2eNI-00075Q-4r
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2eNG-0003n1-Qd
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:49:56 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2eNE-0003mf-2M
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 09:49:52 -0400
Received: by mail-wm0-x232.google.com with SMTP id r190so68443506wme.1
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 06:49:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493010966-22976-1-git-send-email-jasowang@redhat.com>
References: <1493010966-22976-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 14:49:30 +0100
Message-ID: <CAFEAcA_9Du7_=-q2uGBKYporAQ+v8G9nGJNrcwJ1FCZ=OO8Hrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/8] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 April 2017 at 06:15, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 32c7e0ab755745e961f1772e95cac381cc68769d:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20170421' into staging (2017-04-21 15:59:27 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 049f6d8237dd0b14dee02e4c22b20114c43cecff:
>
>   COLO-compare: Optimize tcp compare trace event (2017-04-24 11:30:36 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi. Clang picks up what looks like a typo:

/Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: error: use
of logical '&&' with constant operand
[-Werror,-Wconstant-logical-operand]
    if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
                                ^  ~~~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: note: use
'&' for a bitwise operation
    if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
                                ^~
                                &
/Users/pm215/src/qemu-for-merges/hw/net/ftgmac100.c:809:33: note:
remove constant to silence this warning
    if (size < 64 && !(s->maccr && FTGMAC100_MACCR_RX_RUNT)) {
                               ~^~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.


thanks
-- PMM
