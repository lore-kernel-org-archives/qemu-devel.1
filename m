Received: from eggs.gnu.org ([2001:4830:134:3::10]:54197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5Bu-0001iM-Hb
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5Bq-0001bl-MQ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:02:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj5Bq-0001bL-G6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:02:02 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-17-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58ecbcf5-b943-65d9-a9fe-63762afe5b61@redhat.com>
Date: Fri, 27 Jul 2018 11:02:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-17-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/23] migration-test: Make
 wait_command() cope with '%'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> wait_command() passes its argument @command to qtest_qmp_send().
> Falls apart if @command contain '%'.  Two ways to disarm this trap:
> suppress interpretation of '%' by passing @command as argument to
> format string "%s", or fix it by having wait_command() take the
> variable arguments to go with @command.  Do the latter.
> 
> This is another step towards compile-time format string checking
> without triggering -Wformat-nonliteral.
> 

Aha - fixes up the complaints I had on 15/23.

> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/migration-test.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
