Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BEDC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 22:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4417213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 22:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4417213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59969 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDct6-0005bf-8o
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 18:37:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hDcr8-0004Y8-Hq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hDcr6-0005cz-FA
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hDcr6-0005Xy-0x
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 578DF30821C0;
	Mon,  8 Apr 2019 22:26:06 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B01015D9C9;
	Mon,  8 Apr 2019 22:26:03 +0000 (UTC)
Date: Mon, 8 Apr 2019 19:26:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190408222601.GR7238@habkost.net>
References: <20190407092314.11066-1-thuth@redhat.com>
	<20190408134517.GA9047@richard>
	<14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <14147807-8723-adac-dffb-31b7bbd0fc3b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 08 Apr 2019 22:26:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0] hw/i386/pc: Fix crash when
 hot-plugging nvdimm on older machine types
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408222601.iegtCw1JL0TMemNXW8QmzF2OrI0E5K2T3DOMXQHISq0@z>

On Mon, Apr 08, 2019 at 05:06:49PM +0200, Thomas Huth wrote:
> On 08/04/2019 15.45, Wei Yang wrote:
[...]
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 6077d27361..b11f3b15c1 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -2091,6 +2091,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      }
> >  
> >      hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
> > +    if (*errp) {
> > +        return;
> > +    }
> 
> Not sure, but I think you can not rely on the fact that the caller set
> *errp = NULL already... that's why it is more common to use a local_err
> variable and error_propagate() for such cases (which is what I did in my
> patch).

*errp can't be non-NULL (otherwise functions calling error_setg()
would crash).  errp can be NULL, though, and that's why you need
a local_err variable.

I'd love to eliminate NULL errp from our codebase, but I couldn't
find a way to do it that is safe and simple (i.e. not letting us
pass NULL errp by mistake and not requiring a macro wrapping
every `&local_err` expression).

-- 
Eduardo

