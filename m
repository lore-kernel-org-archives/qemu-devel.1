Received: from eggs.gnu.org ([2001:4830:134:3::10]:53794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTBXn-0003zn-Fw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTBXk-0006Ea-73
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTBXj-0006DF-W1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 14:30:24 -0400
Date: Thu, 6 Jul 2017 15:30:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170706183014.GH12152@localhost.localdomain>
References: <1499242883-2184-4-git-send-email-peterx@redhat.com>
	<1499306921-5391-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499306921-5391-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2.1 3/4] doc: add item for "-M
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, lvivier@redhat.com, quintela@redhat.com, groug@kaod.org, dgilbert@redhat.com

On Thu, Jul 06, 2017 at 10:08:41AM +0800, Peter Xu wrote:
> It's never documented, and now we have one more parameter for it (which
> obsoletes this one). Document it properly.
> 
> Although now when enforce-config-section is set, it'll override the
> other "-global" parameter, that is not necessarily a rule. Forbid that
> usage in the document.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2.1:
> - remove the "undefined behavior" sentence [Markus]
> 
>  qemu-options.hx | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 297bd8a..1ce7a37 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -85,6 +85,14 @@ Enables or disables NVDIMM support. The default is off.
>  @item s390-squash-mcss=on|off
>  Enables or disables squashing subchannels into the default css.
>  The default is off.
> +@item enforce-config-section=on|off
> +If @option{enforce-config-section} is set to @var{on}, force migration
> +code to send configuration section even if the machine-type sets the
> +@option{migration.send-configuration} property to @var{off}.
> +NOTE: this parameter is deprecated. Please use @option{-global}
> +@option{migration.send-configuration}=@var{on|off} instead.
> +@option{enforce-config-section} cannot be used together with
> +@option{-global} @option{migration.send-configuration}.
>  @end table

I'm not sure if "cannot be used together" is much better than
"behavior is undefined when they are used together".  I prefer
Markus' suggestion to simply leave it unspecified.  (In other
words, just removing the last 2 lines)

-- 
Eduardo
