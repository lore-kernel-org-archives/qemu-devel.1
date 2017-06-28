Received: from eggs.gnu.org ([2001:4830:134:3::10]:39211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQDY3-0005wp-2L
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQDXy-0004jx-IA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQDXy-0004jZ-CY
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:02:22 -0400
Date: Wed, 28 Jun 2017 22:02:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170628140219.GI14166@lemon.lan>
References: <20170628124850.12821-1-famz@redhat.com>
	<20170628124850.12821-5-famz@redhat.com>
	<a729ca7e-726d-f8ca-79ab-243592d6bffa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a729ca7e-726d-f8ca-79ab-243592d6bffa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/7] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 06/28 15:38, Paolo Bonzini wrote:
> 
> 
> On 28/06/2017 14:48, Fam Zheng wrote:
> > 
> > It's implemented by creating a wrapper property that basically forwards
> > operations to a QOM "link-FOO" property, which handles the check
> > callback and flags. The feature that is missing from QOM is the dynamic
> > child pointer which is done in the added code with the usual "offset"
> > approach.
> 
> Would it be possible to add a ".create" field to PropertyInfo?  Then
> there's no need to introduce the wrapper.

QOM setter/getter want a LinkProperty opaque pointer, but qdev uses a Property
pointer. I don't see a way to adapt that with .create(). Can you elaborate?

> 
> Also, I think _check and _flags can be always
> qdev_prop_allow_set_link_before_realize and
> OBJ_PROP_LINK_UNREF_ON_RELEASE for DEFINE_PROP_LINK.

A quick grep gave me some object_property_add_link() callers using different
parameters, but I don't know if they should use DEFINE_PROP_LINK.

Fam
