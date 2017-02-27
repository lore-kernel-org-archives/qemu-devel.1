Received: from eggs.gnu.org ([2001:4830:134:3::10]:50809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciPbO-0007uQ-6w
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciPbL-0000iI-4J
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:00:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciPbK-0000hv-Vm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:00:47 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A566C0092CD
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170118135624.17368-1-ehabkost@redhat.com>
	<20170118135624.17368-3-ehabkost@redhat.com>
	<87mveos6aq.fsf@dusky.pond.sub.org>
	<20170118162409.GA3491@thinpad.lan.raisama.net>
Date: Mon, 27 Feb 2017 19:00:44 +0100
In-Reply-To: <20170118162409.GA3491@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Wed, 18 Jan 2017 14:24:09 -0200")
Message-ID: <877f4ba4z7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print warning when a default
 config file is loaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Jan 18, 2017 at 05:04:45PM +0100, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > In case there were options set in the default config file, print
>> > a warning so users can update their scripts.
>> 
>> Can you explain why you don't warn on an empty qemu.conf?
>
> I didnt't want to show the warning to users that won't be
> affected by the change. I assume that users with empty qemu.conf
> files won't care when we stop loading it.

Makes some sense.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
