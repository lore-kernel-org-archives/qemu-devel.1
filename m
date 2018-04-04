Received: from eggs.gnu.org ([2001:4830:134:3::10]:59314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f3eLs-0000Ri-5l
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1f3eLn-0008PK-8M
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:05:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1f3eLn-0008P6-4u
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:05:03 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180331185536.4835-1-bala24@linux.vnet.ibm.com> (Balamuruhan
	S.'s message of "Sun, 1 Apr 2018 00:25:36 +0530")
References: <20180331185536.4835-1-bala24@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 04 Apr 2018 11:04:59 +0200
Message-ID: <87sh8bz6is.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

Balamuruhan S <bala24@linux.vnet.ibm.com> wrote:
> expected_downtime value is not accurate with dirty_pages_rate * page_size,
> using ram_bytes_remaining would yeild it correct.
>
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

See my other mail on the thread, my understanding is that your change is
corret (TM).

Thanks, Juan.

> ---
>  migration/migration.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 58bd382730..4e43dc4f92 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2245,8 +2245,7 @@ static void migration_update_counters(MigrationState *s,
>       * recalculate. 10000 is a small enough number for our purposes
>       */
>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> -        s->expected_downtime = ram_counters.dirty_pages_rate *
> -            qemu_target_page_size() / bandwidth;
> +        s->expected_downtime = ram_bytes_remaining() / bandwidth;
>      }
>  
>      qemu_file_reset_rate_limit(s->to_dst_file);
