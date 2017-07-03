Received: from eggs.gnu.org ([2001:4830:134:3::10]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dRzcX-0007s8-Ch
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dRzcU-0000YX-8d
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dRzcU-0000Xd-3I
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:34:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 238EC7F406
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 11:34:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1499049848-18012-4-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Mon, 3 Jul 2017 10:44:07 +0800")
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
	<1499049848-18012-4-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Jul 2017 13:34:18 +0200
Message-ID: <87r2xx4uv9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/4] doc: add item for "-M
 enforce-config-section"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> It's never documented, and now we have one more parameter for it (which
> means this one can be obsolete in the future). Document it properly.
>
> Although now when enforce-config-section is set, it'll override the
> other "-global" parameter, that is not necessarily a rule. Forbid that
> usage in the document.
>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qemu-options.hx | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 297bd8a..927c51f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -85,6 +85,14 @@ Enables or disables NVDIMM support. The default is off.
>  @item s390-squash-mcss=on|off
>  Enables or disables squashing subchannels into the default css.
>  The default is off.
> +@item enforce-config-section=on|off
> +Decides whether we will send the configuration section when doing
> +migration. By default, it is turned on. We can set this to off to
> +explicitly disable it. Note: this parameter will be obsolete soon,
> +please use "-global migration.send-configuration=on|off" instead.
> +"enforce-config-section" cannot be used together with "-global
> +migration.send-configuration". If it happens, the behavior is
> +undefined.
>  @end table
>  ETEXI

Reviewed-by: Juan Quintela <quintela@redhat.com>

I will have been explicit that it is *already* obsolete, just that we
don't have a way to say that.

Later, Juan.
