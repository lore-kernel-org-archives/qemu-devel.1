Received: from eggs.gnu.org ([2001:4830:134:3::10]:45975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8RaV-0005UD-7f
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8RaS-0006mG-G0
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:28:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8RaS-0006ln-AY
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:28:00 -0400
Date: Tue, 17 Apr 2018 11:27:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417142739.GV29865@localhost.localdomain>
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<87zi21apkh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zi21apkh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Tue, Apr 17, 2018 at 04:13:34PM +0200, Markus Armbruster wrote:
> Igor Mammedov <imammedo@redhat.com> writes:
> 
> [...]
> > Series allows to configure NUMA mapping at runtime using QMP
> > interface. For that to happen it introduces a new '-preconfig' CLI option
> > which allows to pause QEMU before machine_init() is run and
> > adds new set-numa-node QMP command which in conjunction with
> > query-hotpluggable-cpus allows to configure NUMA mapping for cpus.
> >
> > Later we can modify other commands to run early, for example device_add.
> > I recall SPAPR had problem when libvirt started QEMU with -S and, while it's
> > paused, added CPUs with device_add. Intent was to coldplug CPUs (but at that
> > stage it's considered hotplug already), so SPAPR had to work around the issue.
> 
> That instance is just stupidity / laziness, I think: we consider any
> plug after machine creation a hot plug.  Real machines remain cold until
> you press the power button.  Our virtual machines should remain cold
> until they start running, i.e. with -S until the first "cont".
> 
> I vaguely remember me asking this before, but your answer didn't make it
> into this cover letter, which gives me a pretext to ask again instead of
> looking it up in the archives: what exactly prevents us from keeping the
> machine cold enough for numa configuration until the first "cont"?

I also think this would be better, but it seems to be difficult
in practice, see:
http://mid.mail-archive.com/20180323210532.GD28161@localhost.localdomain

-- 
Eduardo
