Received: from eggs.gnu.org ([209.51.188.92]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMcsi-0006yx-G9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMcsh-0006Cn-MZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:26:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMcsh-0006Al-HZ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:25:59 -0400
Date: Fri, 3 May 2019 15:25:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190503182549.GS28722@habkost.net>
References: <20190425225610.28350-1-Janakarajan.Natarajan@amd.com>
	<20190425225610.28350-2-Janakarajan.Natarajan@amd.com>
	<20190426142908.5d63d530@Igors-MacBook-Pro.local>
	<3d272b2b-67ba-de54-9683-d3361ecbe276@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d272b2b-67ba-de54-9683-d3361ecbe276@amd.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] ram-encrypted-notifier: Introduce a
 RAM block encrypted notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janakarajan Natarajan <jnataraj@amd.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, Fam Zheng <fam@euphon.net>

On Fri, Apr 26, 2019 at 02:32:51PM +0000, Janakarajan Natarajan wrote:
> On 4/26/19 7:29 AM, Igor Mammedov wrote:
[...]
> >> diff --git a/numa.c b/numa.c
> >> index 3875e1efda..08601366c5 100644
> >> --- a/numa.c
> >> +++ b/numa.c
> > looks like wrong file to put RAMBlock code in. I though that we should put it in exec.c
> 
> 
> I placed the RAMBlockEncrypted Notifier code along with the RAMBlock 
> Notifier code.

Paolo, Fam, do you remember why was the ram block notifier code
added to numa.c instead of memory.c or exec.c?

-- 
Eduardo
