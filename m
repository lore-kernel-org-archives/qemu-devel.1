Received: from eggs.gnu.org ([2001:4830:134:3::10]:54146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cstjl-0007b7-N1
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cstjk-0000tC-MM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:12:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cstjk-0000sx-Gn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:12:48 -0400
Date: Tue, 28 Mar 2017 10:12:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170328101236.1ba09cd6@t450s.home>
In-Reply-To: <58DA695D.5020306@cn.fujitsu.com>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161234.2ada63fb@t450s.home>
	<58DA695D.5020306@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] vfio-pci: support recovery of AER
 non fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, mst@redhat.com

On Tue, 28 Mar 2017 21:47:09 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> On 03/25/2017 06:12 AM, Alex Williamson wrote:
> > On Thu, 23 Mar 2017 17:09:20 +0800
> > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> >   
> >> v3 changelog:
> >> 1. Address all comments from MST in patch 3, include remove the flag
> >>    pci_aer_non_fatal & passive_reset, also the boilerplate code.
> >>    The corresponding kernel patch is v6.
> >>
> >> Test:
> >> Test with func1 passthroughed while func0 doesn't have user.  
> > 
> > So the slot_reset trigger really hasn't been tested at all?  
> 
> No, because we don't have that kind of multi-function device. IIRC, in
> real world, most of multi-function devices have the same functions.

Why does that matter?  Even if the functions are identical, one can be
owned by the host and one can be owned by a completely different driver
in a guest.  The guest driver may be able to recover without a reset
while the host driver may require one for the same error.

> I plan to do basic test as described above before got Reviewed-by, and
> will do full test as before after reviewed.
> 
> I will consider if we can fake to trigger slot_reset.

If more testing is required for a patch series it should be explicitly
noted in the cover letter or sent as an RFC.  Otherwise you're
potentially wasting my time if I'm the first to test it or risking that
untested code will be approved an make it into upstream.  Thanks,

Alex
