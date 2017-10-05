Received: from eggs.gnu.org ([2001:4830:134:3::10]:56188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e02FT-0004Pp-O9
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e02FN-0007n0-Gx
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e02FN-0007mJ-AW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 05:15:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C8707C82F
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 09:15:12 +0000 (UTC)
Date: Thu, 5 Oct 2017 11:15:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171005111509.197fe1f5@nial.brq.redhat.com>
In-Reply-To: <20171005111241.4085e98d@nial.brq.redhat.com>
References: <1507049162-27026-1-git-send-email-thuth@redhat.com>
	<20171003184946.GR17385@localhost.localdomain>
	<20171005103629.156e9a9b@nial.brq.redhat.com>
	<5165bbdd-b36a-ab89-e819-c85a788f8415@redhat.com>
	<20171005111241.4085e98d@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qdev: Check for the availability of a
 hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Thu, 5 Oct 2017 11:12:41 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 5 Oct 2017 11:00:29 +0200
> Thomas Huth <thuth@redhat.com> wrote:
[...] 
> > Yes, currently we might be able to do it with the typename only ... but
> > that seems to be a rather big rework right now, and we might indeed need
> > a real device instance later again, so I'd prefer to rather not do that
> > rework right now.  
> it was just remark why it uses 'dev' and a call for an action.
forgot the most important word

s/a call/NOT a call/

[...]
