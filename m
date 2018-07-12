Received: from eggs.gnu.org ([2001:4830:134:3::10]:52579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZpG-00067B-Ov
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZpE-0001Tr-64
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:31:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fdZpE-0001Tj-19
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:31:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B7D8407577D
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:31:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180712111221.20326-20-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 12 Jul 2018 13:12:20 +0200")
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-20-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 12 Jul 2018 13:31:49 +0200
Message-ID: <878t6glmfu.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 19/20] migration-test: Clean up string
 interpolation into QMP, part 3
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
> migration-test.c interpolates strings into JSON in a few places:
>
> * migrate_set_parameter() interpolates string parameter @value as a
>   JSON number.  Change it to long long.  This requires changing
>   migrate_check_parameter() similarly.
>
> * migrate_set_capability() interpolates string parameter @value as a
>   JSON boolean.  Change it to bool.
>
> * deprecated_set_speed() interpolates string parameter @value as a
>   JSON number.  Change it to long long.
>
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I did it someway because at some point I was also using strings, not
only ints.  But I came to conclusion that it is much better to just
having different functions for different types.

Thanks, again.
