Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2139C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34192073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 09:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34192073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyNQ-0004tc-Vs
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 05:58:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFyMh-0004aR-ST
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hFyMh-00075k-2C
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hFyMg-00075M-Pb
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA8F181DEB;
	Mon, 15 Apr 2019 09:57:23 +0000 (UTC)
Received: from work-vm (ovpn-117-222.ams2.redhat.com [10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EBD4D1018A0C;
	Mon, 15 Apr 2019 09:57:21 +0000 (UTC)
Date: Mon, 15 Apr 2019 10:57:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190415095719.GB2852@work-vm>
References: <20190412152652.827-1-dgilbert@redhat.com>
	<20190415094552.GC29134@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190415094552.GC29134@stefanha-x1.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 15 Apr 2019 09:57:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hmp: gva2gpa debug command
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415095719.QMS9WdRqlr-QW4XFY865bG2Hqmoh33OZCOgul3ttCMA@z>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Fri, Apr 12, 2019 at 04:26:52PM +0100, Dr. David Alan Gilbert (git) wrote:
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index d3bad2fc27..ba4690b9ac 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -585,6 +585,21 @@ STEXI
> >  @findex gpa2hpa
> >  Print the host physical address at which the guest's physical address @var{addr}
> >  is mapped.
> > +ETEXI
> > +
> > +    {
> > +        .name       = "gva2gpa",
> > +        .args_type  = "addr:l",
> > +        .params     = "addr",
> > +        .help       = "print the guest physical address corresponding to a guest virtual address",
> > +        .cmd        = hmp_gva2gpa,
> > +    },
> > +
> > +STEXI
> > +@item gpa2hpa @var{addr}
> > +@findex gpa2hpa
> 
> s/gpa2hpa/gva2gpa/

Oops, thanks!

Dave

> Aside from this:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

