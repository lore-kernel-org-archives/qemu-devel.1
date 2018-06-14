Received: from eggs.gnu.org ([2001:4830:134:3::10]:54382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTaIC-0003sJ-Tb
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTaI8-0002tt-LT
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:00:32 -0400
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:58807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTaI8-0002sY-Eo
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:00:28 -0400
Received: from player731.ha.ovh.net (unknown [10.109.120.101])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7BB57107E77
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 00:00:26 +0200 (CEST)
Date: Fri, 15 Jun 2018 00:00:20 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180615000020.2a3372a5@bahia.lan>
In-Reply-To: <ea3044c2-d8cd-d41d-91a6-5d78bff86e76@linaro.org>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
	<ea3044c2-d8cd-d41d-91a6-5d78bff86e76@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 14 Jun 2018 09:52:55 -1000
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 06/12/2018 10:19 PM, Greg Kurz wrote:
> > I'm confused... I don't see anything related to HTM in TCG. Also we have
> > the following in cap_htm_apply():
> > 
> >     if (tcg_enabled()) {
> >         error_setg(errp,
> >                    "No Transactional Memory support in TCG, try cap-htm=off");
> > 
> > I'm probably missing something... can you enlighten me ?  
> 
> One of the two IBM machines -- and I thought it was ppc not s390x, but the code
> you quote seems to deny that memory -- has stub support for TM within TCG.
> 

Oh ? I didn't know and didn't check :)

> To wit, the instructions are recognized and transactions always fail.  Which is
> not a bad way to test the required fallback paths that rarely fail on hardware.
>  ;-)

If TM instructions don't cause an exception, I guess its reasonable to say
they're supported :)

--
G

> 
> 
> r~
