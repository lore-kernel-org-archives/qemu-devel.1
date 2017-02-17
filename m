Received: from eggs.gnu.org ([2001:4830:134:3::10]:36557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1cem0b-0000H8-SN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1cem0a-0005tB-RU
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:07:49 -0500
MIME-Version: 1.0
In-Reply-To: <f42b803f-ba9e-fe14-a085-2023ac062c1c@redhat.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<f42b803f-ba9e-fe14-a085-2023ac062c1c@redhat.com>
From: Chad Joan <chadjoan@gmail.com>
Date: Fri, 17 Feb 2017 12:07:25 -0500
Message-ID: <CABHMSTWJseqJXq+S9y+38fym8H2FXLMumSGdQf6mn028mz7pcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

How wonderful!  Problem solved.  Now I think that just having an example
could kill the misconception forever ;)

On Fri, Feb 17, 2017 at 11:57 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 17/02/2017 17:54, Chad Joan wrote:
> > Regarding the signature: IIRC, setting up certificates on a machine
> > using gpg can be quite time consuming and learning-intensive if you've
> > never needed to do it before.  Having that example will go a long way to
> > help with this.  There is still a possible pain-point: you might write
> > one line of git code in the example, and it is easy for you due to your
> > workflow, but it could be hours of fiddling for someone who has never
> > done it before.  If I'm wrong, show me (the hypothetical reader) how
> > easy it is ;)  If I'm right (and that would be unfortunate, in this
> > case), then it might be helpful if you politely ask the reader to spend
> > time X amount of time on it (establish accurate expectations) and then
> > provide a link to the most helpful how-to article you can find on the
> > subject.
>
> GPG signing is not needed.  All you need is "git commit -s".
>
> Adding "Signed-off-by: Chad Joan <chadjoan@gmail.com>" basically is a
> way to tell us "I understand I'm contributing this under the GNU GPL or
> a compatible license".  It's not a cryptographic signature.
>
> Paolo
>
