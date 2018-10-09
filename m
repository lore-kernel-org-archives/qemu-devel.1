Received: from eggs.gnu.org ([2001:4830:134:3::10]:55786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9one-0007Ak-Iy
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g9ona-0004AU-Qm
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g9onW-0003mS-6Y
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:59:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35E3883F51
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 09:59:20 +0000 (UTC)
Date: Tue, 9 Oct 2018 11:59:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181009115917.7e29e5b1@redhat.com>
In-Reply-To: <53871bae-5b1c-df8c-f6d2-b2ce81be831c@redhat.com>
References: <20180925160248.30801-1-kchamart@redhat.com>
	<20180925160248.30801-3-kchamart@redhat.com>
	<20180926172427.05a2de94@redhat.com>
	<87zhw33t8z.fsf@dusky.pond.sub.org>
	<20181001081845.GD25720@paraplu>
	<20181001105904.4c155ffd@redhat.com>
	<53871bae-5b1c-df8c-f6d2-b2ce81be831c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] docs: Document vCPU hotplug
 procedure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com

On Mon, 8 Oct 2018 14:10:50 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 10/1/18 3:59 AM, Igor Mammedov wrote:
> 
> >>> Anyway, what about this:
> >>>
> >>>      The command returns an object with a "qom-path" member for each
> >>>      present CPU.  In this case, it shows an IvyBridge-IBRS-x86_64-cpu in
> >>>      socket 0.
> >>>
> >>>      It returns an object without a "qom-path" for every possibly CPU
> >>>      hot-plug.  In this case, it shows you can plug an
> >>>      IvyBridge-IBRS-x86_64-cpu into socket 1, and the additional
> >>>      properties you need to pass to device_add for that.  
> > not really sure my English (CCed Eric) but to match 'an object' with
> > the rest of sentence:
> > 
> >   It returns an object without a "qom-path" for a possible to hot-plug CPU.
> >   +
> >   In this case, it shows you can plug an  IvyBridge-IBRS-x86_64-cpu
> >   into socket 1/core = 0/thread 0, where 'props' list describes
> >   additional properties you need to pass to device_add for hot-pluging
> >   that CPU.  
> 
> Maybe:
> 
> The command returns an object for CPUs that are present (containing a 
> "qom-path" member) or which may be hot-plugged (no "qom-path" member). 
> In this example, an IvyBridge-IBRS-x86_64-cpu is present in socket 0,
> while hot-plugging a CPU into socket 1 requires passing the listed 
> properties to device_add.
to be precise it's a logical cpu in socket/core/thread, but considering
example has only 2 socket and 2 cpus total, suggested variant probably
is good too.
