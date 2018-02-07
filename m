Received: from eggs.gnu.org ([2001:4830:134:3::10]:48945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejOOx-0005MG-4S
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejOOw-0000lv-Bb
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:35 -0500
Date: Wed, 7 Feb 2018 10:00:24 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180207120024.GI3291@localhost.localdomain>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<20180206223213.GG13301@localhost.localdomain>
	<20180207095225.0400fce9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207095225.0400fce9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/25] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On Wed, Feb 07, 2018 at 09:52:25AM +0100, Igor Mammedov wrote:
[...]
> > * I suggest testing all CPU models in patch 02/25, but this
> >   shouldn't block the series.  Can be a follow-up patch.
> the goal of the test is that refactoring didn't regress
> 'none' machine after following change in 23/25:
> 
> @@ -24,9 +24,9 @@ static void machine_none_init(MachineState *mch)
>  {
>      CPUState *cpu = NULL;
>  
> -    /* Initialize CPU (if a model has been specified) */
> -    if (mch->cpu_model) {
> -        cpu = cpu_init(mch->cpu_model);
> +    /* Initialize CPU (if user asked for it) */
> +    if (mch->cpu_type) {
> +        cpu = cpu_create(mch->cpu_type);
> 
> for that it's sufficient to probe one cpu model.
> 
> We can do all cpus probing later if there will be need in it,
> but that's not related to this series and would just waste
> 'make check' time if it won't be doing something meaningful
> with probed cpu.

Not making "make check" slow is a good argument, I agree.

Extensive testing like testing all CPU models or all devices
probably should be done in a separate (slower) test set.

-- 
Eduardo
