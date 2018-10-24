Received: from eggs.gnu.org ([2001:4830:134:3::10]:52500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gFNvl-0001QW-N2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gFNvk-0001TK-Ve
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:30:57 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:40988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gFNvk-0001T7-PV
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 14:30:56 -0400
Received: by mail-yw1-xc41.google.com with SMTP id 135-v6so2486224ywo.8
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 11:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181024023831.2529-1-jcmvbkbc@gmail.com>
	<eac0b0b9-351f-20bf-c5e9-b4fb1f8885d1@vivier.eu>
	<CAMo8Bf+SEQmHMct+ONPb4YanHMiP18Z5iYJTzLbUPGDDLf0uKA@mail.gmail.com>
In-Reply-To: <CAMo8Bf+SEQmHMct+ONPb4YanHMiP18Z5iYJTzLbUPGDDLf0uKA@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 24 Oct 2018 11:30:44 -0700
Message-ID: <CAMo8BfKCQ1-j7yx_hijvCaBMn_UfU25DVDmc67WYLOZ==26S6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user/flatload: fix initial stack
 pointer alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Wed, Oct 24, 2018 at 10:19 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Wed, Oct 24, 2018 at 4:35 AM Laurent Vivier <laurent@vivier.eu> wrote:
> > > diff --git a/linux-user/flatload.c b/linux-user/flatload.c
> > > index 2eefe55e5000..1893966b5b30 100644
> > > --- a/linux-user/flatload.c
> > > +++ b/linux-user/flatload.c
>
> > > -        sp -= 16 - ((sp + stack_len) & 15);
> > > +    if ((sp - stack_len) & 15) {
> > > +        sp -= ((sp - stack_len) & 15);
> > > +    }
> >
> > If I understand correctly the purpose, I think it could be clearer like:
> >
> >     sp = (sp - stack_len) & ~15;
>
> Yes, you're right. I'll send v2.

Well, not exactly. The sp is not moved down stack_len + alignment bytes,
only the alignment bytes. I'll send v2 anyway.

-- 
Thanks.
-- Max
