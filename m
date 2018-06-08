Received: from eggs.gnu.org ([2001:4830:134:3::10]:40168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKvw-0000v1-4c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKvt-00010K-7H
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:12:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fRKvt-00010C-1Q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:12:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABFDC79D36
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 17:12:12 +0000 (UTC)
Date: Fri, 8 Jun 2018 18:12:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180608171209.GE18233@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608170231.27912-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608170231.27912-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Purge uses of banned g_assert_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Jun 08, 2018 at 07:02:31PM +0200, Markus Armbruster wrote:
> We banned use of certain g_assert_FOO() functions outside tests, and
> made checkpatch.pl flag them (commit 6e9389563e5).  We neglected to
> purge existing uses.  Do that now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/ide/ahci.c                 |  2 +-
>  hw/ppc/spapr_ovec.c           | 12 ++++++------
>  hw/usb/dev-smartcard-reader.c |  2 +-
>  qom/object.c                  | 10 +++++-----
>  util/qht.c                    |  2 +-
>  5 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c

> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
> index 2131e33d27..13d0befd9c 100644
> --- a/hw/usb/dev-smartcard-reader.c
> +++ b/hw/usb/dev-smartcard-reader.c
> @@ -786,7 +786,7 @@ static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
>          DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
>      }
>      if (len) {
> -        g_assert_nonnull(data);
> +        assert(data);

nitpick - all the other conversions used  g_assert()


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
