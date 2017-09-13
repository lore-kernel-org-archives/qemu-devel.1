Received: from eggs.gnu.org ([2001:4830:134:3::10]:58833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds9Tj-0001pT-6t
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds9Tg-0006Dp-33
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:21:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds9Tf-0006Cx-TR
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:21:24 -0400
Date: Wed, 13 Sep 2017 17:21:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913172115.1b7fb95d.cohuck@redhat.com>
In-Reply-To: <fb0909ad-19bb-3a92-27c6-652bf4d32277@redhat.com>
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-9-david@redhat.com>
	<fb0909ad-19bb-3a92-27c6-652bf4d32277@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/22] s390x: move sclp_service_call()
 to sclp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, 13 Sep 2017 16:29:23 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 13.09.2017 15:24, David Hildenbrand wrote:
> > Implemented in sclp.c, so let's move it to the right include file.
> > Fix up one include. Do a forward declaration of struct CPUS390XState to
> > fix the two sclp consoles complaining.  
> 
> Is that sentence about the forward declaration still valid? I did not
> see that anymore here...

Indeed. I can fix this up to:

"Implemented in sclp.c, so let's move it to the right include file.
Also adjust some includes."

?

> 
> Apart from that:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
