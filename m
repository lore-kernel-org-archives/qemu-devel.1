Received: from eggs.gnu.org ([209.51.188.92]:40934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk59S-0007d0-Qe
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk521-0004DL-Ll
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:36:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk521-0004BN-Ev
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:36:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so10350437wrr.12
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:36:13 -0800 (PST)
Date: Thu, 17 Jan 2019 11:36:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117103609.dzauq4ut2pkqyyqf@steredhat>
References: <20190116174941.342900-1-sgarzare@redhat.com>
	<00ff0393-1eab-9bc4-6370-0f959df9dca0@redhat.com>
	<bbec0a30-6b3e-6ba1-b439-7cc72999ea6b@redhat.com>
	<20190117075049.lm5sbws73swdmrgq@steredhat>
	<8108b59f-5140-0bc6-f92e-3ac931753da5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8108b59f-5140-0bc6-f92e-3ac931753da5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jan 17, 2019 at 11:31:27AM +0100, Paolo Bonzini wrote:
> On 17/01/19 08:50, Stefano Garzarella wrote:
> >> Also, the $? in the new rule should be $^.  I wouldn't use a pattern
> >> rule for that, writing it explicitly as "pvh.img: pvh.S pvh_main.c"
> > I'll fix the Makefile.
> 
> (of course it's "pvh.img: pvh.o pvh_main.o").
> 
> I can fix up as well if it's okay for you.

I already sent a v4 fixing your comments (and I put "pvh.img: pvh.o
pvh_main.o" :) ), but if want to fix this series is okay for me.

Thanks,
Stefano
