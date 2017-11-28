Received: from eggs.gnu.org ([2001:4830:134:3::10]:47987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJkif-0007px-MS
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJkib-0002u6-JY
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:34:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eJkib-0002tg-E7
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:34:53 -0500
Date: Tue, 28 Nov 2017 16:34:50 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171128183450.GQ3037@localhost.localdomain>
References: <1511880838-56509-1-git-send-email-imammedo@redhat.com>
	<332cc741-ea50-897f-e03e-ada0ab022ce6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332cc741-ea50-897f-e03e-ada0ab022ce6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] numa: fix missing '-numa cpu' in '-help'
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, mjt@tls.msk.ru, armbru@redhat.com

On Tue, Nov 28, 2017 at 10:59:57AM -0600, Eric Blake wrote:
> On 11/28/2017 08:53 AM, Igor Mammedov wrote:
> > commit 419fcdec3c (numa: add '-numa cpu,...' option for property based node mapping)
> > added '-numa cpu' option but forgot to update appropriate section for '--help'.
> > Add '-numa cpu' description to '-help' output
> > 
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   qemu-options.hx | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Documentation only; safe for 2.11 if it makes it through someone's tree
> (although we're cutting it close); and harmless if it waits for 2.12
> instead.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, queueing it for 2.12 on machine-next.

-- 
Eduardo
