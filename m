Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AEFC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD036218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD036218CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOjb-0002ED-2q
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hjOXg-0000nU-GG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hjOXW-0006BO-BE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:46:18 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:39678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hjOXN-0003Zj-6z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:46:09 -0400
Received: from player697.ha.ovh.net (unknown [10.108.54.217])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 84607183F81
 for <qemu-devel@nongnu.org>; Fri,  5 Jul 2019 15:45:38 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 02D427A3950A;
 Fri,  5 Jul 2019 13:45:28 +0000 (UTC)
Date: Fri, 5 Jul 2019 15:45:26 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190705154526.59b557ed@bahia.lan>
In-Reply-To: <5e49e2e8-0753-67f0-d453-74d9dd8372ce@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
 <20190320112646.3712-2-xieyongji@baidu.com>
 <20190524121909.277ae31e@bahia.lan>
 <CAONzpcbf+AcY4yEO6hBnyp1dBaV4XgUrSTdU55B3S+wcn6gOVA@mail.gmail.com>
 <20190527124446.6b809c7f@bahia.lan>
 <20190527145329-mutt-send-email-mst@kernel.org>
 <CAONzpcb6dtsnYhVW+yy0FijXtHoLavXX_bwStVEZC1hqJr9wSQ@mail.gmail.com>
 <20190531193633.GI22103@habkost.net>
 <20190601174941.00bf108f@bahia.lab.toulouse-stg.fr.ibm.com>
 <5e49e2e8-0753-67f0-d453-74d9dd8372ce@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6089429649697577254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrfeeggdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.162.229
Subject: Re: [Qemu-devel] [PULL v2 04/36] virtio: Introduce started flag to
 VirtioDevice
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhang Yu <zhangyu31@baidu.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Yongji Xie <elohimes@gmail.com>, Xie Yongji <xieyongji@baidu.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 19:54:27 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 01/06/2019 17:49, Greg Kurz wrote:
> > On Fri, 31 May 2019 16:36:33 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> >> On Tue, May 28, 2019 at 10:48:09AM +0800, Yongji Xie wrote:
> >>> On Tue, 28 May 2019 at 02:54, Michael S. Tsirkin <mst@redhat.com> wrote:  
> >>>>
> >>>> On Mon, May 27, 2019 at 12:44:46PM +0200, Greg Kurz wrote:  
> >>>>> On Fri, 24 May 2019 19:56:06 +0800
> >>>>> Yongji Xie <elohimes@gmail.com> wrote:
> >>>>>  
> >>>>>> On Fri, 24 May 2019 at 18:20, Greg Kurz <groug@kaod.org> wrote:  
> >>>>>>>
> >>>>>>> On Mon, 20 May 2019 19:10:35 -0400
> >>>>>>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>>>>>>  
> >>>>>>>> From: Xie Yongji <xieyongji@baidu.com>  
> >> [...]
> >>>>>>>> @@ -1770,6 +1796,13 @@ static bool virtio_broken_needed(void *opaque)
> >>>>>>>>      return vdev->broken;
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>> +static bool virtio_started_needed(void *opaque)
> >>>>>>>> +{
> >>>>>>>> +    VirtIODevice *vdev = opaque;
> >>>>>>>> +
> >>>>>>>> +    return vdev->started;  
> >>>>>>>
> >>>>>>> Existing machine types don't know about the "virtio/started" subsection. This
> >>>>>>> breaks migration to older QEMUs if the driver has started the device, ie. most
> >>>>>>> probably always when it comes to live migration.
> >>>>>>>
> >>>>>>> My understanding is that we do try to support backward migration though. It
> >>>>>>> is a regular practice in datacenters to migrate workloads without having to
> >>>>>>> take care of the QEMU version. FWIW I had to fix similar issues downstream
> >>>>>>> many times in the past because customers had filed bugs.
> >>>>>>>  
> >>>>>>
> >>>>>> If we do need to support backward migration, for this patch, what I
> >>>>>> can think of is to only migrate the flag in the case that guest kicks
> >>>>>> but not set DRIVER_OK. This could fix backward migration in most case.  
> >>>>>
> >>>>> You mean something like that ?
> >>>>>
> >>>>> static bool virtio_started_needed(void *opaque)
> >>>>> {
> >>>>>     VirtIODevice *vdev = opaque;
> >>>>>
> >>>>>     return vdev->started && !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK);
> >>>>> }
> >>>>>  
> >>>>>> Not sure if there is a more general approach...
> >>>>>>  
> >>>>>
> >>>>> Another approach would be to only implement the started flag for
> >>>>> machine version > 4.0. This can be achieved by adding a "use-started"
> >>>>> property to the base virtio device, true by default and set to
> >>>>> false by hw_compat_4_0.  
> >>>>
> >>>> I think this is best frankly.
> >>>>  
> >>>
> >>> Only implement the started flag for machine version > 4.0 might not be
> >>> good because vhost-user-blk now need to use this flag. How about only
> >>> migrating this flag for machine version > 4.0 instead?  
> >>
> >> Was this implemented?  Is migration from QEMU 4.1 to QEMU 4.0
> >> currently broken?
> >>
> > 
> > Answer is yes for both questions.
> > 
> 
> Is there a fix?
> 

The fix was merged with this PR:

https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01565.html

Cheers,

--
Greg

> The problem is really easy to reproduce: start a guest with virtio-blk
> and migrate once the driver has started.
> 
> Thanks,
> Laurent


