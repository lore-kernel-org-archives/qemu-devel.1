Received: from eggs.gnu.org ([2001:4830:134:3::10]:59842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJjuv-0002Li-76
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkaplans@redhat.com>) id 1eJjuu-0007Tp-Bj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:43:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkaplans@redhat.com>) id 1eJjuu-0007Tf-5Q
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:43:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A1416A7C7
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 17:43:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EBD460602
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 17:43:31 +0000 (UTC)
Date: Tue, 28 Nov 2017 12:43:31 -0500 (EST)
From: Victor Kaplansky <vkaplans@redhat.com>
Message-ID: <1511657812.47105235.1511891011177.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171128181306-mutt-send-email-mst@kernel.org>
References: <20171128133123.17372-1-vkaplans@redhat.com>
	<20171128181306-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user spec: Clarify policy on setting
 log_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

> > +Note that master is not expected to issue more than one
> > VHOST_USER_SET_LOG_BASE
> > +request before the rings are fully stopped by the master. Thus no
> > modifications
> > +to log_base address are allowed before the rings are restated and the
> > client
> > +can ignore all subsequent VHOST_USER_SET_LOG_BASE requests after the
> > log_base
> > +address has been established.
> > +
> 
> Do we actually issue VHOST_USER_SET_LOG_BASE when ring is started?

Sorry, missed this question in the previous answer.
Yes, actually qemu issues set_log_base() only in the process of migration,
and before that rings are enabled and actively updated.

> 
> Can we put it simpler:
> 
> 	master must not send VHOST_USER_SET_LOG_BASE when ring
> 	is started and logging of used ring writes is started.
> 
> ?
