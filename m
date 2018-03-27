Received: from eggs.gnu.org ([2001:4830:134:3::10]:53293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0puE-0005Pa-2J
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0puA-0003tN-0y
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:48:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1f0pu9-0003tH-SK
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:48:53 -0400
Date: Tue, 27 Mar 2018 16:48:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180327164840.78a7d905.cohuck@redhat.com>
In-Reply-To: <20180323173823.GD17165@work-vm>
References: <1521579652-180248-1-git-send-email-mst@redhat.com>
	<1521579652-180248-2-git-send-email-mst@redhat.com>
	<20180323173823.GD17165@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/3] update-linux-headers.sh: add
 unistd.h and kvm on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, James Hogan <jhogan@kernel.org>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, 23 Mar 2018 17:38:24 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Michael S. Tsirkin (mst@redhat.com) wrote:

> > @@ -120,6 +124,10 @@ EOF
> >          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
> >          cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
> >      fi
> > +    if [ $arch = s390 ]; then
> > +        cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-arm/"
> > +        cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm/"  
> 
> That doesn't look right - I'm guessing that should be copying into
> asm-s390 ?

I think we rather need "$arch = arm" or so here (s390 only has
unistd.h, which is already handled).
