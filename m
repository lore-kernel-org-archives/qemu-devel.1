Received: from eggs.gnu.org ([2001:4830:134:3::10]:53889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2wLp-0001Br-9o
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2wLo-0008To-BH
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2wLo-0008Sd-5d
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12C31804FA
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 09:01:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170419153734.GB7758@work-vm> (David Alan Gilbert's message of
	"Wed, 19 Apr 2017 16:37:35 +0100")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-8-quintela@redhat.com>
	<20170419153734.GB7758@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 25 Apr 2017 11:01:33 +0200
Message-ID: <878tmooo7m.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/19] migration: Export socket.c functions
 in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  8 --------
>>  include/migration/socket.h    | 25 +++++++++++++++++++++++++
>>  migration/migration.c         |  1 +
>>  migration/socket.c            |  1 +
>>  4 files changed, 27 insertions(+), 8 deletions(-)
>>  create mode 100644 include/migration/socket.h
>> 
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index 077b75b..0c6dae5 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -194,14 +194,6 @@ void migration_tls_channel_connect(MigrationState *s,
>>  
>>  uint64_t migrate_max_downtime(void);
>>  
>> -void tcp_start_incoming_migration(const char *host_port, Error **errp);
>> -
>> -void tcp_start_outgoing_migration(MigrationState *s, const char
>> *host_port, Error **errp);
>> -
>> -void unix_start_incoming_migration(const char *path, Error **errp);
>> -
>> -void unix_start_outgoing_migration(MigrationState *s, const char
>> *path, Error **errp);
>> -
>>  void rdma_start_outgoing_migration(void *opaque, const char
>> *host_port, Error **errp);
>>  
>>  void rdma_start_incoming_migration(const char *host_port, Error **errp);
>
> Have you considered a header with just the transports in it?
>
> There doesn't seem to be that much point with one with just the
> rdma's in, and one iwth just the tcp's in etc.

In the future, the transports should be using module_type() and no need
of this stuff at all.  It should make easier to compile transports out
(famous last words).

Later, Juan.
