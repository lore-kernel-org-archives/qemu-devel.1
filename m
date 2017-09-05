Received: from eggs.gnu.org ([2001:4830:134:3::10]:36161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpCXp-0004ie-Lj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpCXe-0006EJ-2G
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpCXd-0006Dq-T0
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:01:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF3B4C01417D
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 12:01:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <b604df0885958328765a9d481186a5d60a9ab4b1.1504609507.git.mprivozn@redhat.com>
	<87shg1tle7.fsf@dusky.pond.sub.org>
	<3b92c8bd-6575-1821-757a-8256639c45da@redhat.com>
Date: Tue, 05 Sep 2017 14:01:11 +0200
In-Reply-To: <3b92c8bd-6575-1821-757a-8256639c45da@redhat.com> (Michal
	Privoznik's message of "Tue, 5 Sep 2017 13:54:13 +0200")
Message-ID: <87d175s6bc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] watchdog: Allow setting action on the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org

Michal Privoznik <mprivozn@redhat.com> writes:

> On 09/05/2017 01:50 PM, Markus Armbruster wrote:
>> 
>> @action needs to be a QAPI enum.  It'll replace the #defines in
>> watchdog.  select_watchdog_action() then calls qapi_enum_parse() to map
>> string to enum, and qmp_watchdog_set_action() to make the actual change.
>
> Oh, okay. Sure, I can do that. I guess it makes the set of actions
> introspectable?

Yes!
