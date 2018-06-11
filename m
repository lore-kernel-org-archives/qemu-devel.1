Received: from eggs.gnu.org ([2001:4830:134:3::10]:47120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSU0C-0004Pe-Lb
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSU09-00085x-Fu
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSU09-000859-9F
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:05:21 -0400
Date: Mon, 11 Jun 2018 18:05:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611210515.GZ7451@localhost.localdomain>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
	<1528498581-131037-3-git-send-email-babu.moger@amd.com>
	<DM5PR12MB24718C2709BB60179BAD2F9495780@DM5PR12MB2471.namprd12.prod.outlook.com>
	<20180611204623.GV7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611204623.GV7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v13 2/5] i386: Introduce auto_topoext bit
 to manage topoext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Moger, Babu" <Babu.Moger@amd.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kash@tripleback.net" <kash@tripleback.net>, "geoff@hostfission.com" <geoff@hostfission.com>

On Mon, Jun 11, 2018 at 05:46:23PM -0300, Eduardo Habkost wrote:
[...]
> On PC_COMPAT_2_12, both would work:
>   { TYPE_X86_CPU, "auto-topoext", "off" }
> or
>   { "EPYC" "-" TYPE_X86_CPU, "auto-topoext", "off" }.
> 
> I prefer the latter, but both would work.

Oh, while we're at it: please name the property "x-auto-topoext",
to indicate it's only for QEMU internal use or debugging, and not
a supported command-line option.

-- 
Eduardo
