Received: from eggs.gnu.org ([2001:4830:134:3::10]:47887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0UkL-000145-UH
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0UkK-0006Yy-U8
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:13:21 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:34288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0UkK-0006Yf-O0
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:13:20 -0400
Received: by mail-oi0-x229.google.com with SMTP id u141-v6so16569519oif.1
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 09:13:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
	<9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Mar 2018 17:12:59 +0100
Message-ID: <CAFEAcA8qXbuR+o0h3P5HyGgqLxhn6s9W-jpZp2Cnm-YgSOeNBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 March 2018 at 15:23, Eric Blake <eblake@redhat.com> wrote:
> We'll want a followup patch to .mailmap to make the git log attribution look
> nicer.  We currently have the following patches all attributed to the same
> email address; I have no idea if .mailmap can correctly sort between them:
>
> $ git shortlog origin --author=qemu-devel | grep '^[^ ]'
> Ed Swierk via Qemu-devel (2):
> Ian McKellar via Qemu-devel (1):
> Julia Suvorova via Qemu-devel (1):
> Justin Terry (VM) via Qemu-devel (8):
> Paul Donohue (2):
>
> but it would be nice if we can improve our tooling to prevent future
> instances of the recurring problem.

Yuck. (Maybe we should try whatever the other workaround for
this SPF vs mailing lists problem is?)

If you can suggest a patch to my apply-pullreq script I'm
happy to change it to reject these at pull application time.

https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/apply-pullreq

thanks
-- PMM
