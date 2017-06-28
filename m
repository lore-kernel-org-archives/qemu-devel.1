Received: from eggs.gnu.org ([2001:4830:134:3::10]:40492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQDce-0000Jx-CO
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQDcb-0007BD-8D
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dQDcb-0007Ao-1x
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 10:07:09 -0400
References: <20170628124850.12821-1-famz@redhat.com>
	<20170628124850.12821-5-famz@redhat.com>
	<a729ca7e-726d-f8ca-79ab-243592d6bffa@redhat.com>
	<20170628140219.GI14166@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3553624c-4f6a-7671-41d6-db22a2e37003@redhat.com>
Date: Wed, 28 Jun 2017 16:06:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170628140219.GI14166@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 28/06/2017 16:02, Fam Zheng wrote:
>>> It's implemented by creating a wrapper property that basically forwards
>>> operations to a QOM "link-FOO" property, which handles the check
>>> callback and flags. The feature that is missing from QOM is the dynamic
>>> child pointer which is done in the added code with the usual "offset"
>>> approach.
>> Would it be possible to add a ".create" field to PropertyInfo?  Then
>> there's no need to introduce the wrapper.
> QOM setter/getter want a LinkProperty opaque pointer, but qdev uses a Property
> pointer. I don't see a way to adapt that with .create(). Can you elaborate?

The .create() callback would call object_property_add_link directly.
There would be no change in the properties at the QOM level, but the
PropertyInfo lets "info qtree" show the property.

Paolo
