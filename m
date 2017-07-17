Received: from eggs.gnu.org ([2001:4830:134:3::10]:45598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dX3TQ-0006Mn-Tx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dX3TN-0000gQ-Ny
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dX3TN-0000eT-HC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:41:53 -0400
Date: Mon, 17 Jul 2017 12:41:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170717124146.5ae39d2b@nial.brq.redhat.com>
In-Reply-To: <5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-15-git-send-email-imammedo@redhat.com>
	<5bec6275-8e15-16c7-8d23-2975a563c78f@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/28] m68k: replace cpu_m68k_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Sat, 15 Jul 2017 08:08:58 -1000
Richard Henderson <rth@twiddle.net> wrote:

> On 07/14/2017 03:52 AM, Igor Mammedov wrote:
> > @@ -230,6 +230,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
> >       M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
> >       Error *local_err = NULL;
> >   
> > +    register_m68k_insns(&cpu->env);
> > +  
> 
> I think it would make more sense to do this during m68k_tcg_init.
> 
it seems that m68k_cpu_initfn accesses 'env' via some global,
while cpu_mk68k_init() used to access concrete pointer of just created cpu,

how about moving register_m68k_insns() to m68k_cpu_initfn(), instead?
it should be equivalent to what cpu_mk68k_init() used to do.
