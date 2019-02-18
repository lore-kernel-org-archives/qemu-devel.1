Received: from eggs.gnu.org ([209.51.188.92]:38762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gvnX2-0002SS-Q1
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gvnWz-0006IR-As
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:20:43 -0500
Date: Mon, 18 Feb 2019 23:50:22 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20190218135724.0dc82c32@bahia.lan>
Message-ID: <nycvar.YSQ.7.76.1902182347220.12428@xnncv>
References: <20190218101218.4177-1-ppandit@redhat.com>
	<20190218123811.5b7a1d61@bahia.lan>
	<20190218115218.GF32287@redhat.com>
	<20190218135724.0dc82c32@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] ppc: add host-serial and
 host-model machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

  Hello Greg, Dan,

+-- On Mon, 18 Feb 2019, Greg Kurz wrote --+
| >>> +    spapr->host_model = NULL;  
| >> 
| >> This isn't needed since object_initialize_with_type() already takes care
| >> of zeroing the instance for us.
| >>   
| >>> +    spapr->host_serial = NULL;  
| >> 
| >> Same here.
| 
| Alright then if there's prior consensus on compatibility versus security.
| 
| So, with or without the unneeded zeroing of the spapr->host_* fields:
| 
| Reviewed-by: Greg Kurz <groug@kaod.org>

I have sent a revised patch v4 removing above NULL initialisations. Thank you 
for the review.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
