Received: from eggs.gnu.org ([2001:4830:134:3::10]:52461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eb3RT-0005Fq-Iw
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eb3RN-0000GE-Vv
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:00:43 -0500
Date: Mon, 15 Jan 2018 13:00:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <1516008655-31732-1-git-send-email-thuth@redhat.com>
Message-ID: <alpine.BSF.2.21.1801151238370.57536@zero.eik.bme.hu>
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/2] Clean up the ppc default
 configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 15 Jan 2018, Thomas Huth wrote:
> ppc64-softmmu is a superset of ppc-softmmu which in turn is a superset
> of ppcemb-softmmu. But since the config files are currently independent
> from each other, we missed to define some CONFIG switches in the super-
> sets: CONFIG_SUNGEM is missing from the ppc64-softmmu config, and the
> CONFIG_IDE_SII3112 switch is only defined in ppcemb-softmmu.

I'm not sure about this. The Sun GEM network interface is a device 
typically found on Apple PowerMacs but also seems to be found on G5 based 
Macs so it's probably OK to add. The SiI3112 is now only used on the (not 
yet fully merged) Sam460EX emulation which is to be added to ppcemb, 
that's why I've only added it to that target. Defining it on other targets 
does no harm (other than making the binary bigger) just maybe not 
necessary. If you think this makes the configs simpler I'm OK with this 
change just note that it probably makes it impossible to add options only 
for ppcemb without also adding them to ppc and ppc64. If that's OK then go 
ahead.

> (off-topic question: Do we still need a separate ppcemb-softmmu nowadays?
> It seemed to be useful 10 years ago when everybody was doing KVM on
> embedded PPC, but these days seem to be pretty much over now, so IMHO
> just using ppc-softmmu for embedded should be enough nowadays? We could
> save quite some compilation- and "make check"-time if we could finally get
> rid of ppcemb-softmmu again...)

I've also noticed that most of the boards were available both in ppcemb 
and ppc targets so maybe these could be merged now to avoid confusion but 
I don't know the reason why ppcemb existed in the first place so I don't 
know what other implications dropping ppcemb may have.

Regards,
BALATON Zoltan
