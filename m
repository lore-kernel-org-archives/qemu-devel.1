Received: from eggs.gnu.org ([2001:4830:134:3::10]:53578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAVae-0003r6-DU
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAVab-0000hj-2L
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAVaa-0000hF-Qy
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 03:40:57 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180918185246.18109-1-danielhb413@gmail.com>
	<20180918185246.18109-3-danielhb413@gmail.com>
Date: Thu, 11 Oct 2018 09:40:50 +0200
In-Reply-To: <20180918185246.18109-3-danielhb413@gmail.com> (Daniel Henrique
	Barboza's message of "Tue, 18 Sep 2018 15:52:45 -0300")
Message-ID: <875zy97wxp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 2/3] qga: update guest-suspend-ram and
 guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

Daniel Henrique Barboza <danielhb413@gmail.com> writes:

> This patch updates the descriptions of 'guest-suspend-ram' and
> 'guest-suspend-hybrid' to mention that both commands relies now
> on the proper support for wake up from suspend, retrieved by the
> 'wakeup-suspend-support' attribute of the 'query-current-machine'
> QMP command.
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/qapi-schema.json | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index dfbc4a5e32..7ae7e2502c 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -567,9 +567,9 @@
>  # For the best results it's strongly recommended to have the pm-utils
>  # package installed in the guest.
>  #
> -# IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-ram.
> +# IMPORTANT: guest-suspend-ram requires working wakeup support in
> +# QEMU. You *must* check QMP command query-current-machine returns
> +# wakeup-suspend-support: true before issuing this command.
>  #
>  # This command does NOT return a response on success. There are two options
>  # to check for success:
> @@ -594,9 +594,9 @@
>  #
>  # This command requires the pm-utils package to be installed in the guest.
>  #
> -# IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-hybrid.
> +# IMPORTANT: guest-suspend-hybrid requires working wakeup support in
> +# QEMU. You *must* check QMP command query-current-machine returns
> +# wakeup-suspend-support: true before issuing this command.
>  #
>  # This command does NOT return a response on success. There are two options
>  # to check for success:

The emphasis in "You *must* check" hints at all kinds of terrible
disasters if you don't, but then you're not pointing to any.

So, what can happen if you issue this command when query-current-machine
returns wakeup-suspend-support: false?
