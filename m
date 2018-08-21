Received: from eggs.gnu.org ([2001:4830:134:3::10]:57958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs5Xj-0007Ae-Dt
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs5QK-0000J3-DS
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:06:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs5QK-0000It-8p
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:06:12 -0400
Date: Tue, 21 Aug 2018 14:06:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821120606.tgnnsrfreizy2mm3@sirius.home.kraxel.org>
References: <20180821074509.22688-1-kraxel@redhat.com>
	<20180821074509.22688-9-kraxel@redhat.com>
	<685ad9d2-bf48-2dec-1e69-c1d4a5e2b41c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685ad9d2-bf48-2dec-1e69-c1d4a5e2b41c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 08/12] spice-display: fix
 qemu_spice_cursor_refresh_bh locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On Tue, Aug 21, 2018 at 11:45:20AM +0200, Paolo Bonzini wrote:
> On 21/08/2018 09:45, Gerd Hoffmann wrote:
> > +    qemu_mutex_lock(&ssd->lock);
> >      if (ssd->cursor) {
> > +        QEMUCursor *c = ssd->cursor;
> >          assert(ssd->dcl.con);
> > +        cursor_get(c);
> > +        qemu_mutex_unlock(&ssd->lock);
> >          dpy_cursor_define(ssd->dcl.con, ssd->cursor);
> 
> Gerd,
> 
> this ssd->cursor should be "c" in the call to dpy_cursor_define.  My
> apologies; please tell me if you'd like me to send a follow-up fix.

Fixed, pull v2 on the way.

cheers,
  Gerd
