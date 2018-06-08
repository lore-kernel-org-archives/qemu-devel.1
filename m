Received: from eggs.gnu.org ([2001:4830:134:3::10]:57070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRKBn-0006oB-Bm
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:24:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fRKBk-0003pU-6T
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:24:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fRKBj-0003oq-Vv
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:24:32 -0400
Date: Fri, 8 Jun 2018 19:24:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608192148-mutt-send-email-mst@kernel.org>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<20180607223111.27792-2-ross.zwisler@linux.intel.com>
	<20180608020724-mutt-send-email-mst@kernel.org>
	<5352d2fb-9244-78b0-4f4b-2818359a4425@redhat.com>
	<20180608190040-mutt-send-email-mst@kernel.org>
	<CAFEAcA-h3xxeRFO32pnqrwR_wZ1=us-t0FunS2aJRpQV==3-GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-h3xxeRFO32pnqrwR_wZ1=us-t0FunS2aJRpQV==3-GQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [qemu PATCH 2/5] acpi: "make check" should fail on
 asl mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>

On Fri, Jun 08, 2018 at 05:16:30PM +0100, Peter Maydell wrote:
> On 8 June 2018 at 17:03, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Pull requests are somewhat different, they are usually tested for lack
> > of warnings. This change didn't arrive as a result of a pull request
> > maybe that's why it slipped through the cracks. Peter?
> >
> > Maybe we need a "pedantic" flag to fail on any warnings, or just catch
> > output to stderr.
> 
> If there's a situation that shouldn't exist in the tree (ie
> a bug), then make check should catch it, and result in a
> failure, not just printing random stuff to stderr. Otherwise
> I'm not going to notice it, whether I'm applying a pull request
> or an individual patch.
> 
> thanks
> -- PMM

It's ok if it happens, but it just makes debugging and reviewing
ACPI patches a little bit harder until it's fixed.

-- 
MST
