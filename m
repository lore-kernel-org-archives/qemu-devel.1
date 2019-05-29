Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB27C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AEC20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AEC20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50261 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVuW0-0000VK-Ho
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:04:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVuUs-0008KY-9O
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVuUq-0001bb-Ez
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hVuUq-0001aN-Ae
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:03:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30E0D9C158
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:03:42 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0158C1A4D9;
	Wed, 29 May 2019 09:03:38 +0000 (UTC)
Date: Wed, 29 May 2019 10:03:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190529090335.GB2882@work-vm>
References: <20190523145840.11774-1-dgilbert@redhat.com>
	<20190523145840.11774-2-dgilbert@redhat.com>
	<3fe6b079-94ed-a379-78b8-396dee1665b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe6b079-94ed-a379-78b8-396dee1665b9@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 29 May 2019 09:03:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] net/announce: Allow optional list of
 interfaces
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, laine@redhat.com,
	armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 5/23/19 9:58 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Allow the caller to restrict the set of interfaces that announces are
> > sent on.  The default is still to send on all interfaces.
> > 
> > e.g.
> > 
> >   { "execute": "announce-self", "arguments": { "initial": 50, "max": 550, "rounds": 5, "step": 50, "ifaces": ["vn2","vn1"] } }
> > 
> > Note: There's still only one timer for the qmp command, so that
> > performing an 'announce-self' on one list of interfaces followed
> > by another 'announce-self' on another list will stop the announces
> > on the existing set.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> 
> > +++ b/qapi/net.json
> > @@ -706,7 +706,8 @@
> >    'data': { 'initial': 'int',
> >              'max': 'int',
> >              'rounds': 'int',
> > -            'step': 'int' } }
> > +            'step': 'int',
> > +            '*ifaces': ['str'] } }
> 
> Missing documentation for the addition, including a '(since 4.1)' tag.

Oops, thanks, added:

# @ifaces: An optional list of interface names, which restrict the
#        announcment to the listed interfaces. (Since 4.1)
#

Dave

> >  
> >  ##
> >  # @announce-self:
> > @@ -718,9 +719,10 @@
> >  #
> >  # Example:
> >  #
> > -# -> { "execute": "announce-self"
> > +# -> { "execute": "announce-self",
> >  #      "arguments": {
> > -#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
> > +#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> > +#          "ifaces": ["vn2","vn3"] } }
> >  # <- { "return": {} }
> >  #
> >  # Since: 4.0
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

