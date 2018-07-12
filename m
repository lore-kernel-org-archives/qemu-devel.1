Received: from eggs.gnu.org ([2001:4830:134:3::10]:51451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZkd-00027m-9x
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZka-0006eP-NE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:27:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fdZka-0006dK-HF
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:27:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26D902BCA6
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:27:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180712111221.20326-19-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 12 Jul 2018 13:12:19 +0200")
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-19-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 12 Jul 2018 13:27:02 +0200
Message-ID: <87d0vslmnt.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 18/20] migration-test: Clean up string
 interpolation into QMP, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Markus Armbruster <armbru@redhat.com> wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the recent commit "tests: Clean up
> string interpolation into QMP input (simple cases)".
>
> migrate() interpolates members into a JSON object.  Change it to take
> its extra QMP arguments as arguments for qdict_from_jsonf_nofail()
> instead of a string containing JSON members.
>
> Bonus: gets rid of a non-literal format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>

Again, much clearen.  Thanks.
