Received: from eggs.gnu.org ([209.51.188.92]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2fjE-0005cc-E4
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2fjC-0006m7-9u
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:25:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2fjA-0006kN-8y
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:25:40 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
	<20190305181602.9051-6-dgilbert@redhat.com>
Date: Sat, 09 Mar 2019 18:25:33 +0100
In-Reply-To: <20190305181602.9051-6-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Tue, 5 Mar 2019 18:15:46 +0000")
Message-ID: <87zhq40xki.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 05/21] migration: Introduce ignore-shared
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: Yury Kotov <yury-kotov@yandex-team.ru>
>
> We want to use local migration to update QEMU for running guests.
> In this case we don't need to migrate shared (file backed) RAM.
> So, add a capability to ignore such blocks during live migration.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Message-Id: <20190215174548.2630-3-yury-kotov@yandex-team.ru>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
[...]
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 1fd7bbea9b..eab87340b2 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -409,13 +409,16 @@
>  #           devices (and thus take locks) immediately at the end of migration.
>  #           (since 3.0)
>  #
> +# @x-ignore-shared: If enabled, QEMU will not migrate shared memory (since 4.0)

What exactly is considered "shared memory"?

Specifically: say you have an ivshmem-plain device.  Is its shared
memory migrated?

No objection to the pull request; if documentation improvements are
necessary, we can do them in a follow-up patch.

> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
>             'block', 'return-path', 'pause-before-switchover', 'x-multifd',
> -           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' ] }
> +           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> +           'x-ignore-shared' ] }
>  
>  ##
>  # @MigrationCapabilityStatus:
