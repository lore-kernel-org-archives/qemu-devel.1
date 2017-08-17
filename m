Received: from eggs.gnu.org ([2001:4830:134:3::10]:39372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diNUq-00020s-Hq
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diNUp-0000pu-OC
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:18:12 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:38163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1diNUp-0000pM-HX
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:18:11 -0400
Received: by mail-wr0-x235.google.com with SMTP id 5so23405339wrz.5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 09:18:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2e763f07-c688-ce55-2824-c2d0d7562edb@redhat.com>
References: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
	<2e763f07-c688-ce55-2824-c2d0d7562edb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2017 17:17:49 +0100
Message-ID: <CAFEAcA_H7_qbjTma9sUmKxpkCy7UP2+tbwJVEOwKLNodA7HQhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10???] fix build failure in
 nbd_read_reply_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 17 August 2017 at 17:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 17/08/2017 18:14, Igor Mammedov wrote:
>> travis builds fail at HEAD at rc3 master with
>>
>>   block/nbd-client.c: In function =E2=80=98nbd_read_reply_entry=E2=80=99=
:
>>   block/nbd-client.c:110:8: error: =E2=80=98ret=E2=80=99 may be used uni=
nitialized in this function [-Werror=3Duninitialized]
>>
>> fix it by initializing 'ret' to 0
>
> This is a false positive, but it's understandably impossible for the
> compiler to figure it out.
>
> Even though we disable -Werror on release builds, it may be worth fixing
> this in 2.10 if it doesn't delay the release.  Peter, what do you think
> about applying this on top of -rc3 without doing a fourth candidate?

I don't like doing releases which haven't had an rc,
but we've had abbreviated "just a couple of days" rc-to-final
cycles before.

thanks
-- PMM
