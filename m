Received: from eggs.gnu.org ([2001:4830:134:3::10]:57793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cWSCq-0003d4-2Y
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cWSCl-0002Kl-2f
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:22:04 -0500
Received: from mail-db5eur01on0116.outbound.protection.outlook.com
	([104.47.2.116]:3231
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cWSCk-0002Ka-FD
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:21:59 -0500
References: <20170116155113.21034-1-pbutsykin@virtuozzo.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <37c47ab8-362b-58ee-a49b-7ab32d20e037@openvz.org>
Date: Wed, 25 Jan 2017 19:50:06 +0300
MIME-Version: 1.0
In-Reply-To: <20170116155113.21034-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] migration capability to discard the
 migrated ram pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, eblake@redhat.com, armbru@redhat.com

On 01/16/2017 06:51 PM, Pavel Butsykin wrote:
> This feature frees the migrated memory on the source during postcopy-ram
> migration. In the second step of postcopy-ram migration when the source vm
> is put on pause we can free unnecessary memory. It will allow, in particular,
> to start relaxing the memory stress on the source host in a load-balancing
> scenario.
>
> Pavel Butsykin (2):
>   add 'discard-ram' migrate capability
>   migration: discard non-dirty ram pages after the start of postcopy
>
>  include/migration/migration.h |  2 ++
>  include/migration/qemu-file.h |  3 ++-
>  migration/migration.c         | 11 ++++++++
>  migration/qemu-file.c         | 59 ++++++++++++++++++++++++++++++++++++++-----
>  migration/ram.c               | 49 ++++++++++++++++++++++++++++++++++-
>  qapi-schema.json              |  5 +++-
>  6 files changed, 119 insertions(+), 10 deletions(-)
>
ping
