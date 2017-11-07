Received: from eggs.gnu.org ([2001:4830:134:3::10]:43149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC7Dr-00058K-Vy
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eC7Do-00006H-4t
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:59:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eC7Dn-00005q-V7
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:59:32 -0500
Date: Tue, 7 Nov 2017 17:59:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171107175922.201c2055.cohuck@redhat.com>
In-Reply-To: <c26e207a-c522-3441-75cc-02c6fa287b4e@linaro.org>
References: <20170913172941.5470-1-cohuck@redhat.com>
	<c26e207a-c522-3441-75cc-02c6fa287b4e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] accel: default to an actually available
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

On Wed, 13 Sep 2017 11:09:04 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 09/13/2017 10:29 AM, Cornelia Huck wrote:
> > configure_accelerator() falls back to tcg if no accelerator has
> > been specified. Formerly, we could be sure that tcg is always
> > available; however, with --disable-tcg, this is not longer true,
> > and you are not able to start qemu without explicitly specifying
> > another accelerator on those builds.
> > 
> > Instead, choose an accelerator in the order tcg->kvm->hax.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > RFC->v2:
> > - drop xen from the list of fallbacks
> > - use comma-delimited list of accelerators (much easier)
> > - changed one place in qemu-options.hx that had been missed  
> 
> Queued to tcg-next.  Thanks,

Hm, has this fallen through the cracks?
