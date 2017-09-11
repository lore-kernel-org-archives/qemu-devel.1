Received: from eggs.gnu.org ([2001:4830:134:3::10]:47651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drRhy-0001Ab-VK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1drRhy-0003bz-22
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:37:14 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:38834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1drRhx-0003b1-SY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:37:13 -0400
Received: by mail-wr0-x241.google.com with SMTP id p37so4663563wrb.5
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 09:37:12 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <06b2af89-9871-f121-7641-b2b1a0d8a02c@redhat.com>
References: <cover.1503077821.git.alistair.francis@xilinx.com>
	<06b2af89-9871-f121-7641-b2b1a0d8a02c@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 11 Sep 2017 09:36:40 -0700
Message-ID: <CAKmqyKPk90_SfHv+1X0+gbPaSCG+WNwxzG7OrXgrxAEBbvrSwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Remove libqemustub.a in order to
 improve error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On Mon, Sep 11, 2017 at 2:57 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 18/08/2017 20:47, Alistair Francis wrote:
>> As discussed with Paolo and Markus let's combine libqemustub.a into
>> libqemuutil.a to avoid circular dependencies.
>>
>> Alistair Francis (2):
>>   Makefile: Remove libqemustub.a
>>   Convert remaining single line fprintf() to warn_report()
>>
>>  Makefile                    |  7 +++----
>>  Makefile.target             |  2 +-
>>  docs/devel/build-system.txt | 14 +++++---------
>>  tests/Makefile.include      |  8 ++++----
>>  util/cutils.c               |  3 ++-
>>  5 files changed, 15 insertions(+), 19 deletions(-)
>>
>
> Queued, thanks (with Philippe's adjustments to the comments).

Thanks Paolo.

I actually sent a new version with Philippe's comments, it's included
as part of the "More warning reporting fixed" series.

Version 5 of that has been reviewed by Markus, I will send it out
today. Can you take that instead?

Thanks,
Alistair

>
> Paolo
