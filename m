Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86071C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE2820869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE2820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDcT-0001T1-H9
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:26:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDba-00013D-G8
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDbZ-0004GF-E5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDbZ-0004Ff-6K
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68A1F307D78B
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:25:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FDC719C58;
	Thu, 18 Apr 2019 20:25:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1CFEF1138648; Thu, 18 Apr 2019 22:25:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
References: <20190417190641.26814-1-armbru@redhat.com>
	<20190417190641.26814-8-armbru@redhat.com>
	<20190417160508.7b87d59a@x1.home> <87a7gnrg33.fsf@dusky.pond.sub.org>
	<20190418103608.70668bda@x1.home>
Date: Thu, 18 Apr 2019 22:25:52 +0200
In-Reply-To: <20190418103608.70668bda@x1.home> (Alex Williamson's message of
	"Thu, 18 Apr 2019 10:36:08 -0600")
Message-ID: <87lg07hxgv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 18 Apr 2019 20:25:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 07/15] vfio: Report warnings with
 warn_report(), not error_printf()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418202552.L3ERhnJfUKToPEgDguRClCnJddgFRVP2HwQBWPxipI4@z>

Alex Williamson <alex.williamson@redhat.com> writes:

> On Thu, 18 Apr 2019 08:18:56 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Alex Williamson <alex.williamson@redhat.com> writes:
>> 
>> > On Wed, 17 Apr 2019 21:06:33 +0200
>> > Markus Armbruster <armbru@redhat.com> wrote:
>> >  
>> >> Cc: Alex Williamson <alex.williamson@redhat.com>
>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> >> ---
>> >>  hw/vfio/pci.c | 19 +++++++++++++------
>> >>  1 file changed, 13 insertions(+), 6 deletions(-)
>> >> 
>> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> >> index 504019c458..0142819ea6 100644
>> >> --- a/hw/vfio/pci.c
>> >> +++ b/hw/vfio/pci.c
>> >> @@ -947,8 +947,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>> >>      if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>> >>          /* Since pci handles romfile, just print a message and return */
>> >>          if (vfio_blacklist_opt_rom(vdev) && vdev->pdev.romfile) {
>> >> -            error_printf("Warning : Device at %s is known to cause system instability issues during option rom execution. Proceeding anyway since user specified romfile\n",
>> >> -                         vdev->vbasedev.name);
>> >> +            warn_report("Device at %s is known to cause system instability"
>> >> +                        " issues during option rom execution",
>> >> +                        vdev->vbasedev.name);
>> >> +            error_printf("Proceeding anyway since user specified romfile\n");  
>> >
>> > I'm confused, the original warning is "this device is know to have
>> > issues, proceeding because you asked me to".  Are we categorizing the
>> > first half as a warning and the latter as random uncategorized error
>> > spew?  Did an automated script chunk it this way because of the period
>> > and strict application of the "single phrase" specification of
>> > warn_report()?  If this is the recommended semantics, I'm not sure how
>> > I'd know to generate this myself for similar situations.  Should we
>> > instead try to express this in something acceptable as a single
>> > phrase?  Thanks,  
>> 
>> This is an instance of the following error reporting pattern:
>> 
>>     concise error / warning message (one line, single phrase)
>>     additional information (free format)
>> 
>> We use error_report() / warn_report() for the former (this adds
>> decorations to the message), and error_printf() for the latter.
>> 
>> "git-grep -w error_printf" will lead you to other instances.  Recommend
>> to look with this series applied, because it removes misuses of
>> error_printf().
>> 
>> Particularly relevant instances are error_report_err() and
>> warn_report_err(): these print the error proper with error_report() /
>> warn_report_err(), and the hint, if any, with error_printf().
>> 
>> Clearer now?
>
> I can't guarantee that I'd be able to reproduce these sorts of
> semantics without prompting, but yes, there does seem to be some method
> to the madness ;)  Thanks,

Hopefully, presence of good examples, absence of bad examples, and
review will do the trick often enough.

> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks!

