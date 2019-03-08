Received: from eggs.gnu.org ([209.51.188.92]:56446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1h2Ct4-0001Mo-MA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1h2Ct3-0000xf-Ue
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:37:58 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:39847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1h2Ct3-0000w8-PY
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:37:57 -0500
Received: by mail-it1-x144.google.com with SMTP id l15so20598146iti.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 02:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20190307170440.3113-1-richard.henderson@linaro.org>
	<20190307170440.3113-4-richard.henderson@linaro.org>
	<CABoDooPFtQhUrzwmcYioHrNTf8RoWCq9Ro_zqCEB1Cf_+aJviA@mail.gmail.com>
In-Reply-To: <CABoDooPFtQhUrzwmcYioHrNTf8RoWCq9Ro_zqCEB1Cf_+aJviA@mail.gmail.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 8 Mar 2019 11:37:45 +0100
Message-ID: <CABoDooO1=s51bgDsxbBBpOvnNB8+ZEAwm9dVxZbDyS+SzCKgBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 03/22] target/arm: Add MTE system
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Mar 8, 2019 at 11:31 AM Laurent Desnogues
<laurent.desnogues@gmail.com> wrote:
>
> Hello,
>
> On Thu, Mar 7, 2019 at 6:09 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
[...]
> > +static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
> > +                                 bool isread)
> > +{
> > +    int el = arm_current_el(env);
> > +
> > +    if (el < 2 &&
> > +        arm_feature(env, ARM_FEATURE_EL2) &&
> > +        !(arm_hcr_el2_eff(env) & HCR_ATA)) {
> > +        return CP_ACCESS_TRAP_EL2;
> > +    }
>
> arm_hcr_el2_eff seems to be clearing HCR_ATA bit.  I think it needs to
> be updated.

Forget that.  I read it wrong and that's my test that is buggy!

Perhaps the comment about ARMv8.4 in arm_hcr_el2_eff should be updated?

Sorry,

Laurent
