Received: from eggs.gnu.org ([2001:4830:134:3::10]:38665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eihsT-0003VE-GJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eihsL-0006nU-IT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:36:13 -0500
Date: Mon, 5 Feb 2018 15:35:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180205153547.71f4e00a.cohuck@redhat.com>
In-Reply-To: <20180201171935.29403-1-cohuck@redhat.com>
References: <20180201171935.29403-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] s390x: support zpci in tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, david@redhat.com

On Thu,  1 Feb 2018 18:19:33 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> More cleanup, as suggested by David, and also a fixed-up SIC. We can
> now turn on ais as well and run with a pre-4.15 kernel and pci devices.
> 
> Branch at git://github.com/cohuck/qemu pci-tcg updated.
> 
> Changes v2->v3:
> - SIC should depend on AIS, which is now supported for tcg as well
> - fixup calling css_do_sic()
> - no need to check return codes for the pci instruction handlers
> - minor cleanup
> 
> Cornelia Huck (2):
>   s390x/tcg: wire up pci instructions
>   s390x/cpumodel: allow zpci features in qemu model
> 
>  target/s390x/cpu_models.c   |   6 +++
>  target/s390x/gen-features.c |   6 ++-
>  target/s390x/helper.h       |   9 ++++
>  target/s390x/insn-data.def  |  13 ++++++
>  target/s390x/misc_helper.c  |  89 ++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c    | 102 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 224 insertions(+), 1 deletion(-)
> 

OK, queued to s390-next. Let's see what breaks :)
