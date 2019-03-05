Received: from eggs.gnu.org ([209.51.188.92]:41514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1h1CQN-0002Hq-PC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1h1CQM-0001WW-Tf
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:56:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1h1CQM-0001PH-Og
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:56:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id d2so9403548qti.11
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 07:56:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550842915.git.berto@igalia.com>
	<w511s3lco9c.fsf@maestria.local.igalia.com>
In-Reply-To: <w511s3lco9c.fsf@maestria.local.igalia.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 5 Mar 2019 16:55:56 +0100
Message-ID: <CAMxuvaypw9B_Tdd0NmBscAoZozP87cO0m-nkoOX2=zdf6Rf5Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

Hi

On Tue, Mar 5, 2019 at 4:52 PM Alberto Garcia <berto@igalia.com> wrote:
>
> ping

I can queue this in the next chardev PR. This can probably wait until
the softfreeze though. I think Paolo had some plans to look at chardev
issues.

>
> On Fri 22 Feb 2019 02:46:23 PM CET, Alberto Garcia wrote:
> > This fixes a race condition in which the tcp_chr_read() ioc handler
> > can close a connection that is being written to from another thread.
> >
> > Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.
> >
> > Berto
