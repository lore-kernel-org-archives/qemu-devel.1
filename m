Received: from eggs.gnu.org ([2001:4830:134:3::10]:48625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crR1d-0001Lf-6w
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crR1Y-0007CN-Jx
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:21:13 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:34143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1crR1Y-0007BK-Dn
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:21:08 -0400
Received: by mail-wm0-x230.google.com with SMTP id w204so8132760wmd.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 08:21:08 -0700 (PDT)
References: <1488382850-19252-1-git-send-email-kraxel@redhat.com>
	<1488382850-19252-2-git-send-email-kraxel@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1488382850-19252-2-git-send-email-kraxel@redhat.com>
Date: Fri, 24 Mar 2017 15:21:05 +0000
Message-ID: <874lyiya3i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v3 1/3] replay: add record/replay for audio
 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>


Gerd Hoffmann <kraxel@redhat.com> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>
> This patch adds recording and replaying audio data. Is saves synchronization
> information for audio out and inputs from the microphone.
>
> v2: removed unneeded whitespace change
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Message-id: 20170202055054.4848.94901.stgit@PASHA-ISP.lan02.inno
>
> [ kraxel: add qemu/error-report.h include to fix osx build failure ]
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  audio/audio.c            |  9 ++++--
>  audio/audio.h            |  5 +++
>  audio/mixeng.c           | 32 ++++++++++++++++++++
>  docs/replay.txt          |  7 +++++
>  include/sysemu/replay.h  |  7 +++++
>  replay/Makefile.objs     |  1 +
>  replay/replay-audio.c    | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h |  4 +++
>  8 files changed, 142 insertions(+), 2 deletions(-)
>  create mode 100644 replay/replay-audio.c
>
<snip>
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index c26d079..ed66ed8 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -29,6 +29,10 @@ enum ReplayEvents {
>      /* for character device read all event */
>      EVENT_CHAR_READ_ALL,
>      EVENT_CHAR_READ_ALL_ERROR,
> +    /* for audio out event */
> +    EVENT_AUDIO_OUT,
> +    /* for audio in event */
> +    EVENT_AUDIO_IN,
>      /* for clock read/writes */
>      /* some of greater codes are reserved for clocks */
>      EVENT_CLOCK,

Well one thing I noticed while I was trying to work out the difference
between pre/post mttcg replay problems is the log format ABI has
changed. REPLAY_VERSION needs to be bumped to prevent confusion.

--
Alex Bennée
