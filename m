Received: from eggs.gnu.org ([2001:4830:134:3::10]:41935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTplS-0005XQ-Ga
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTplQ-0004YO-IW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:04:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTplO-0004WM-OT
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:03:58 -0500
Received: by mail-ot1-x343.google.com with SMTP id f18so11818654otl.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20181130023232.3079982-1-eblake@redhat.com>
	<a31b2898-e27f-2d31-6fba-7df83f8cf998@redhat.com>
In-Reply-To: <a31b2898-e27f-2d31-6fba-7df83f8cf998@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 15:03:46 +0000
Message-ID: <CAFEAcA_yD5ewX4EJGHAcaSZXcupDXHuy4x2ijB3diOwmvSLiVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1? 0/3] NBD dirty bitmap cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On Fri, 30 Nov 2018 at 15:36, Eric Blake <eblake@redhat.com> wrote:
>
> On 11/29/18 8:32 PM, Eric Blake wrote:
> > I'm working on a larger series for 4.0 that will add
> > 'qemu-nbd --list' to show all possible information about a
> > server's exports, to make it easier to diagnose if the right
> > exports and bitmaps are present.  But in the process, I found
> > a few bugs that may be worth fixing in 3.1.  By itself, this
> > series does not warrant -rc4 (particularly since all of the
> > problems exist in the 3.0 release, so this is not a regression
> > fix), but if we have -rc4 for other reasons, these would make
> > incremental backup support a bit more reliable.
>
> And CVEs might be the reason for an -rc4. I'm queuing this on my NBD
> tree, ready to send a Pull Request by early Monday if we indeed end up
> with an -rc4.

...which we will, so would you like to send that pullreq ?

thanks
-- PMM
