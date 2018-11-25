Received: from eggs.gnu.org ([2001:4830:134:3::10]:34165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gQszu-0005ay-8H
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 06:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gQszo-0005QN-C8
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 06:54:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gQszm-0005Pt-S9
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 06:54:39 -0500
Date: Sun, 25 Nov 2018 13:53:57 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181125115357.GA5477@lap1>
References: <20181122121402.13764-1-yuval.shaia@oracle.com>
	<20181122121402.13764-18-yuval.shaia@oracle.com>
	<335892d6-7475-8465-4b20-060bd2960c0f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335892d6-7475-8465-4b20-060bd2960c0f@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 17/24] hw/pvrdma: Fill error code in
 command's response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com, yuval.shaia@oracle.com

> >       err = cmd_handlers[dsr_info->req->hdr.cmd].exec(dev, dsr_info->req,
> > -                            dsr_info->rsp);
> > +                                                    dsr_info->rsp);
> >   out:
> >       set_reg_val(dev, PVRDMA_REG_ERR, err);
> >       post_interrupt(dev, INTR_VEC_CMD_RING);
> 
> 
> As I responded in V4 thread :) one might forget to set hdr.error to 0
> resulting in errors hard to debug.
> 
> Please consider clearing the field on init.

Will fix.

> 
> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Please review v6.

> 
> Thanks,
> Marcel
