Received: from eggs.gnu.org ([2001:4830:134:3::10]:44765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNdvd-0007yn-JF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNdva-0004Jg-F4
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dNdva-0004JO-8N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 07:36:06 -0400
Date: Wed, 21 Jun 2017 08:36:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170621113600.GA3928@thinpad.lan.raisama.net>
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170619142852.GS5016@thinpad.lan.raisama.net>
	<7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
	<08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
	<1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
	<9d24bf00-cf82-717a-eccd-f51e2c80dd6f@redhat.com>
	<eaa2cd40-0d64-6843-7e39-c0f94c7e797f@ilande.co.uk>
	<48c8f007-f388-59f5-9af8-f5eefe033e2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c8f007-f388-59f5-9af8-f5eefe033e2a@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, imammedo@redhat.com

On Wed, Jun 21, 2017 at 09:48:16AM +0200, Laszlo Ersek wrote:
> On 06/21/17 08:58, Mark Cave-Ayland wrote:
> > On 19/06/17 23:43, Laszlo Ersek wrote:
> > 
> >> It looks good to me, but please await Eduardo's reply as well.
> >>
> >> In particular, it should be confirmed that object_resolve_path_type()
> >> matches instances of *subclasses* as well (as I expect it would). Your
> >> test results confirm that; let's make sure it is intentional behavior.
> >> Eduardo (or someone else on the CC list), can you please comment on that?
> > 
> > Thanks Laszlo. Eduardo, can you confirm this is the correct behaviour?

Sorry for taking so long to reply.  Yes, it should be the correct
behavior.  It's how it's documented:

"This is similar to object_resolve_path.  However, when looking
for a partial path only matches that implement the given type are
considered.  This restricts the search and avoids spuriously
flagging matches as ambiguous."

(Key part here is "implement the given type").

Approach used by commit f92063028a "hw/acpi/vmgenid: prevent more
than one vmgenid device" looks good to me.

> > 
> > I now have a v7 patchset ready to go (currently hosted at
> > https://github.com/mcayland/qemu/tree/fwcfg7 for the curious). Laszlo,
> > I've currently left off your Tested-by tag since I'm not sure it's still
> > valid for less-than-trivial changes - if you're happy for me to re-add
> > it before I send the v7 patchset to the list, please let me know.
> 
> I intend to test v7 when you post it.

I still see the instance_init assert() in that branch (commit
17d75643f880).  Is that correct?

-- 
Eduardo
