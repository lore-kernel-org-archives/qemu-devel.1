Received: from eggs.gnu.org ([2001:4830:134:3::10]:38349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cbEes-0005wh-NV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cbEen-0007C6-S9
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:54:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37934
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cbEen-0007Bc-Me
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:54:41 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v17Ms9tt092897
	for <qemu-devel@nongnu.org>; Tue, 7 Feb 2017 17:54:39 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28fgmta3v5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 17:54:39 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Wed, 8 Feb 2017 08:54:36 +1000
Date: Wed, 8 Feb 2017 09:53:36 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<900ea185630c17f315c4984b2a595b2d3fba7c9a.1486436186.git.sam.bobroff@au1.ibm.com>
	<148650556725.30868.4471226211017570314@loki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148650556725.30868.4471226211017570314@loki>
Message-Id: <20170207225336.GA10569@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/9] spapr: fix off-by-one error in
 spapr_ovec_populate_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Tue, Feb 07, 2017 at 04:12:47PM -0600, Michael Roth wrote:
> Quoting Sam Bobroff (2017-02-06 20:56:44)
> > The last byte of the option vector was missing due to an off-by-one
> > error. Without this fix, client architecture support negotiation will
> > fail because the last byte of option vector 5, which contains the MMU
> > support, will be missed.
> > 
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> >  hw/ppc/spapr_ovec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> > index 4f4c090a29..18dbc4a9ac 100644
> > --- a/hw/ppc/spapr_ovec.c
> > +++ b/hw/ppc/spapr_ovec.c
> > @@ -251,7 +251,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
> >          }
> >      }
> > 
> > -    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len);
> > +    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len + 1);
> >  }
> > 
> >  void spapr_ovec_ruler(int width, sPAPROptionVector *ov)
> > -- 
> > 2.11.0
> > 
> 
> I noticed this working on another series and ended up with the same fix.
> 
> The patch doesn't apply cleanly for me though due to the "spapr_ovec_ruler"
> reference. But, assuming that is unrelated to this series:
> 
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

You're corret, that line is unrelated.

Thanks!
Sam.
