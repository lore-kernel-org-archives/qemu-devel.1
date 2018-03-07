Received: from eggs.gnu.org ([2001:4830:134:3::10]:59712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etPlM-0004XZ-Ev
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etPlJ-0003e4-B0
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:29:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33140 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etPlJ-0003dr-6i
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 22:29:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EF2940363BE
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 03:29:01 +0000 (UTC)
Date: Wed, 7 Mar 2018 11:28:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307032853.GF17720@xz-mi>
References: <20180305094938.31374-1-peterx@redhat.com>
	<20180306200837.GQ3096@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306200837.GQ3096@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration: fix applying wrong capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>

On Tue, Mar 06, 2018 at 08:08:37PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > When setting migration capabilities via QMP/HMP, we'll apply them even
> > if the capability check failed.  Fix it.
> > 
> > Fixes: 4a84214ebe ("migration: provide migrate_caps_check()", 2017-07-18)
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> OK, yes, that works, so:
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.

> 
> 
> It is a little odd in a way; 'caps_check' you might expect only checked
> and didn't change anything.   migrate_params is organised a bit
> differently; and somewhat more confusingly.

Indeed.  Maybe the cap_list copy should be within the function, and
then define the function as:

static bool migrate_caps_check(MigrationCapabilityStatusList *params,
                               Error **errp);

Then it at least looks more like the param_check one.

Let me know if you think it's good; I can post another one after
all, and this one would be easy. :)

-- 
Peter Xu
