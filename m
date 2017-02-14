Received: from eggs.gnu.org ([2001:4830:134:3::10]:59793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdcuP-0000to-23
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdcuL-00038c-SW
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:12:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdcuL-00038B-Nd
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:12:37 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F00DD4DD58
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 13:12:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-16-git-send-email-armbru@redhat.com>
	<a0a5df00-4d02-067b-4675-cbabf04bd461@redhat.com>
Date: Tue, 14 Feb 2017 14:12:34 +0100
In-Reply-To: <a0a5df00-4d02-067b-4675-cbabf04bd461@redhat.com> (Paolo
	Bonzini's message of "Tue, 14 Feb 2017 13:35:21 +0100")
Message-ID: <87d1ekc3wd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 15/24] util/cutils: Rename qemu_strtosz()
 to qemu_strtosz_mebi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/02/2017 11:26, Markus Armbruster wrote:
>> With qemu_strtosz(), no suffix means mebibytes.  It's used rarely.
>> I'm going to add a similar function where no suffix means bytes.
>> Rename qemu_strtosz() to qemu_strtosz_mebi() to make the name
>> qemu_strtosz() available for the new function.
>
> What about qemu_strtosz_MiB (yes, camelcase intended).

Yes, that seems clearer.  Thanks!
