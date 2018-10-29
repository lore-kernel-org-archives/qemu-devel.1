Received: from eggs.gnu.org ([2001:4830:134:3::10]:44617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3Ug-0003O7-9S
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3Uc-0000PB-DN
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH3UZ-0000FI-24
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E83A308424E
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:05:35 +0000 (UTC)
Date: Mon, 29 Oct 2018 10:05:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029090529.k6frhegns3k3qrkf@sirius.home.kraxel.org>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-3-kraxel@redhat.com>
	<7210c7e6-4b85-053c-83c5-524a3b74ef6f@redhat.com>
	<nycvar.YSQ.7.76.1810261458190.8270@xnncv>
	<6a284fc1-e948-3c32-dba1-9740be5a2d82@redhat.com>
	<nycvar.YSQ.7.76.1810261720070.8270@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1810261720070.8270@xnncv>
Subject: Re: [Qemu-devel] [PATCH 2/3] adlib: mark as insecure and deprecated.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, libvir-list@redhat.com

On Fri, Oct 26, 2018 at 05:23:37PM +0530, P J P wrote:
> +-- On Fri, 26 Oct 2018, Paolo Bonzini wrote --+
> | Oh, thanks!  I said I was dumb. :)  So the fix is just this:
> | 
> | diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
> | index e7e578a48e..7199afaa3c 100644
> | --- a/hw/audio/fmopl.h
> | +++ b/hw/audio/fmopl.h
> | @@ -72,8 +72,8 @@ typedef struct fm_opl_f {
> |  	/* Rhythm sention */
> |  	uint8_t rhythm;		/* Rhythm mode , key flag */
> |  	/* time tables */
> | -	int32_t AR_TABLE[75];	/* atttack rate tables */
> | -	int32_t DR_TABLE[75];	/* decay rate tables   */
> | +	int32_t AR_TABLE[76];	/* atttack rate tables */
> | +	int32_t DR_TABLE[76];	/* decay rate tables   */
> |  	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
> |  	/* LFO */
> |  	int32_t *ams_table;
> | 
> | and init_timetables will just fill it with the right value?  (I checked
> | against another implementation at http://opl3.cozendey.com/).
> 
> Gerd has proposed to a patch to deprecate adlib, as it's not used as much. IMO 
> deprecation is better option. But if that is not happening, above seems good.

I think we can actually do both.

cheers,
  Gerd
