Received: from eggs.gnu.org ([209.51.188.92]:42712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1h0qD4-0004aq-NX
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1h0qD2-0005Ep-Oa
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:12:58 -0500
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com> <87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304132507.39273826@redhat.com> <20190304123908.GK4239@redhat.com>
	<20190304151641.3deefc3b@redhat.com> <20190304142432.GM4239@redhat.com>
	<20190304161932.0438c880@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <ae0335fb-9201-e09d-80ad-5e497365267b@redhat.com>
Date: Mon, 4 Mar 2019 17:12:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190304161932.0438c880@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, david@gibson.dropbear.id.au

On 3/4/19 4:19 PM, Igor Mammedov wrote:

> Then I'd guess that most VMs end up with default '-numa node,mem'
> which by design can produce only fake NUMA without ability to manage
> guest RAM on host side. So such VMs aren't getting performance benefits
> or worse run with performance regression (due to wrong sched/mm decisions
> as guest kernel assumes NUMA topology is valid one).

Specifying NUMA distances in libvirt XML makes it generate the modern 
cmd line.

Michal
