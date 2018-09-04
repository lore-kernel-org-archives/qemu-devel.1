Received: from eggs.gnu.org ([2001:4830:134:3::10]:52754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wehuang@redhat.com>) id 1fxEo4-0004Ym-MG
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wehuang@redhat.com>) id 1fxEo1-0007bD-HB
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:08:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wehuang@redhat.com>) id 1fxEo1-0007av-9c
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:07:57 -0400
Date: Tue, 4 Sep 2018 13:07:56 -0400 (EDT)
From: Wei Huang <wehuang@redhat.com>
Message-ID: <1199030251.32861977.1536080876430.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180903115335.i763ae67bykvjijl@kamzik.brq.redhat.com>
References: <1535778675-32170-1-git-send-email-wei@redhat.com>
	<1535778675-32170-5-git-send-email-wei@redhat.com>
	<20180903115335.i763ae67bykvjijl@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 4/4] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peter maydell <peter.maydell@linaro.org>, quintela@redhat.com, dgilbert@redhat.com



----- Original Message -----
> From: "Andrew Jones" <drjones@redhat.com>
> To: "Wei Huang" <wei@redhat.com>
> Cc: qemu-devel@nongnu.org, lvivier@redhat.com, "peter maydell" <peter.maydell@linaro.org>, quintela@redhat.com,
> dgilbert@redhat.com
> Sent: Monday, September 3, 2018 6:53:35 AM
> Subject: Re: [Qemu-devel] [PATCH V8 4/4] tests: Add migration test for aarch64
> 
> On Sat, Sep 01, 2018 at 01:11:15AM -0400, Wei Huang wrote:
> > +.section .text
> > +
> > +        .globl  _start
> > +
> > +_start:
> > +        /* disable MMU to use phys mem address */
> > +        mrs     x0, sctlr_el1
> > +        bic     x0, x0, #(1<<0)
> > +        msr     sctlr_el1, x0
> > +        isb
> > +
> > +        /* traverse test memory region */
> > +        mov     x0, #ARM_TEST_MEM_START
> > +        mov     x1, #ARM_TEST_MEM_END
> 
> I don't think there's any reason to require the start and
> end addresses to be hard coded. We should be able to get
> the start address with

Are you saying that we should make the .S file as independent as possible? These variables need to be defined for migration-test.c anyway. Why can't we just use them here?

> 
> #define KERNEL_OFFSET 0x80000
>            adr     x0, _start
>            add     x0, x0, #(1024 * 1024 - KERNEL_OFFSET)
> 
> and the end address with
> 
>            add     x1, x0, #(99 * 1024 * 1024)
> 
> Thanks,
> drew
> 
