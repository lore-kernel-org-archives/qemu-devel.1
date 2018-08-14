Received: from eggs.gnu.org ([2001:4830:134:3::10]:41832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpUSr-000565-TD
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpUSr-0006t6-2U
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:14:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpUSq-0006sn-SN
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:14:04 -0400
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-3-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f2b1597-6cb1-b6ae-b2a0-38c54e1c34d1@redhat.com>
Date: Tue, 14 Aug 2018 10:14:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180813171132.21939-3-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] monitor: show sync profiling info with
 'info sync'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>

On 13/08/2018 19:11, Emilio G. Cota wrote:
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 70639f656a..56a3249bad 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -297,6 +297,22 @@ STEXI
>  @item info opcount
>  @findex info opcount
>  Show dynamic compiler opcode counters
> +ETEXI
> +
> +    {
> +        .name       = "sync",
> +        .args_type  = "max:i?",
> +        .params     = "[max]",
> +        .help       = "show sync profiling info for "
> +	              "up to max entries (default: 10). "
> +		      "Entries are sorted by wait time.",
> +        .cmd        = hmp_info_sync,
> +    },
> +
> +STEXI

Would it make sense to add a flag to sort by average wait time, and one
to coalesce all mutexes for the same call site?

Can be done separately of course.

Paolo
