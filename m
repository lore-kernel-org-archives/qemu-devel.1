Received: from eggs.gnu.org ([2001:4830:134:3::10]:35449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6Hqn-0000cx-IO
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6Hqj-0003CG-PH
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:39:57 -0400
Date: Wed, 11 Apr 2018 17:39:46 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180411173946.6e247d54.cohuck@redhat.com>
In-Reply-To: <20180411152942.GA4480@flamenco>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<e863cce3-d06e-f225-eb25-212729c5f05f@linaro.org>
	<20180411152942.GA4480@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/10] Avoid integer overflow in
 next_page_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On Wed, 11 Apr 2018 11:29:42 -0400
"Emilio G. Cota" <cota@braap.org> wrote:

> On Wed, Apr 11, 2018 at 10:08:58 +1000, Richard Henderson wrote:
> > On 04/11/2018 02:19 AM, Emilio G. Cota wrote:  
> > > Richard pointed out in another thread that when computing
> > > next_page_start we can break checks for the last page in the
> > > address space due to integer overflow. This affects several targets;
> > > the appended fixes them.
> > > 
> > > You can fetch the patches from:
> > >   https://github.com/cota/qemu/tree/next_page_overflow  
> > 
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>  
> 
> Thanks!
> 
> To ease an eventual merge I'll be updating the patches' R-b tags as
> they come in this branch:
>   https://github.com/cota/qemu/tree/next_page_overflow-r-b
> 
> BTW to avoid conflicts we should merge this before the translator loop
> conversion series; I'll make that clear when I send a new version
> of that patch set.
> 
> 		Emilio

So, this series will be merged in one go, then? I'll ack the s390x
patch.
