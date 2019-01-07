Received: from eggs.gnu.org ([209.51.188.92]:43319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggTjf-0006wN-FI
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggTje-0003vO-Qi
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:10:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggTje-0003ur-Ir
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:10:26 -0500
Date: Mon, 7 Jan 2019 20:06:49 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190107120649.GA26108@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-5-yang.zhong@intel.com>
	<c6341e9e-0166-53f2-690d-aa7e01a7e4ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6341e9e-0166-53f2-690d-aa7e01a7e4ca@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 04/25] minikconfig: add AST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

On Fri, Jan 04, 2019 at 03:13:03PM +0100, Paolo Bonzini wrote:
> On 27/12/18 07:33, Yang Zhong wrote:
> > +        self.clauses.append(KconfigData.DependsOnClause(var, expr))
> >  
> >      def do_select(self, var, symbol, cond=None):
> > -        pass
> > +        cond = (cond & var) if not (cond is None) else var
> 
> A better way to write this in Python is
> 
>     cond = (cond & var) if cond is not None else var
> 
> (My Python has improved since 2015 :)).
> 
> Paolo

  Hello Paolo,

  Thanks! i will change this in next version.

  Regards,

  Yang
