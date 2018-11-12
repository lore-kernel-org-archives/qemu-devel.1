Received: from eggs.gnu.org ([2001:4830:134:3::10]:57672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gM1nX-0001eS-97
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 21:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gM1nT-0007Nn-5h
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 21:17:54 -0500
MIME-Version: 1.0
References: <20181031213550.4544-1-jcmvbkbc@gmail.com>
	<13f47aff-593a-e35e-959b-4ddd9f6c6121@linaro.org>
	<CAAdtpL4r52iMNzUtKEDvdwOVomGEfL9paPNGMyj=VG23sFQOSw@mail.gmail.com>
In-Reply-To: <CAAdtpL4r52iMNzUtKEDvdwOVomGEfL9paPNGMyj=VG23sFQOSw@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 11 Nov 2018 18:17:31 -0800
Message-ID: <CAMo8BfKwa22e9Dud0DKqRrOQFU43_TBMCMVMhnzCDASLQrma0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: drop num_[core_]regs from
 dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Sun, Nov 11, 2018 at 3:53 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Max,
>
> On Thu, Nov 1, 2018 at 12:02 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 10/31/18 9:35 PM, Max Filippov wrote:
> > > gdb_regmap::num_core_regs field is initialized incorrectly in the dc2=
32b
> > > and dc233c configurations. As a result the following message is
> > > displayed when attaching to an xtensa linux-user process:
> > >
> > >   "Register 105 is not available",
> > >
> > > and gdb is unable to control the inferior.
> > >
> > > Now that xtensa_count_regs does the right thing, remove manual
> > > initialization of these fields from the affected configurations and l=
et
> > > xtensa_finalize_config initialize them.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > > ---
> > >  target/xtensa/core-dc232b.c | 2 --
> > >  target/xtensa/core-dc233c.c | 2 --
> > >  2 files changed, 4 deletions(-)
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Can we include this patch for the 3.2 release?

I've found that this version is wrong (register lists are not
terminated for these
two cores), so I sent v2. After that I've found that it's still wrong,
i.e. the register
105 is still not available with v2. I dug a bit deeper and it looks
like register
handling should probably be the same for both system and linux-user cases.
I'll post v3 after some more testing in a few days.

--=20
Thanks.
-- Max
