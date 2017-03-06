Received: from eggs.gnu.org ([2001:4830:134:3::10]:40325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckw77-0005mj-VL
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckw77-000060-2a
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:08:01 -0500
Date: Mon, 6 Mar 2017 19:07:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170306170751.jr7cgwsz3yqq2kd2@kozik-lap>
References: <20170305214857.9510-1-krzk@kernel.org>
	<f441f1d9-b312-5f96-0fbf-53a46a8b16a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f441f1d9-b312-5f96-0fbf-53a46a8b16a8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/exynos: Convert fprintf to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Mon, Mar 06, 2017 at 10:55:12AM -0600, Eric Blake wrote:
> On 03/05/2017 03:48 PM, Krzysztof Kozlowski wrote:
> > error_report() is preferred over fprintf() for logging errors.  Also
> > remove square brackets [] and additional new line characters in printed
> > messages.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> 
> I don't see a 0/3 cover letter. When sending multiple patches, it's
> always best to package them in-reply-to the cover letter ('git config
> format.coverLetter auto' makes it easy to remember).

The patches are trivial cleanups without any dependencies so the cover
letter would be one sentence of "trivial cleanup". :)

If that's the practice in qemu, I can send them, no problem.

> 
> 
> > @@ -101,9 +102,8 @@ static Exynos4210State *exynos4_boards_init_common(MachineState *machine,
> >      MachineClass *mc = MACHINE_GET_CLASS(machine);
> >  
> >      if (smp_cpus != EXYNOS4210_NCPUS && !qtest_enabled()) {
> > -        fprintf(stderr, "%s board supports only %d CPU cores. Ignoring smp_cpus"
> > -                " value.\n",
> > -                mc->name, EXYNOS4210_NCPUS);
> > +        error_report("%s board supports only %d CPU cores. Ignoring smp_cpus value.",
> 
> Most uses of error_report() avoid trailing dot.

Sure, I can rephrase it to one sentence without dot.

Best regards,
Krzysztof
