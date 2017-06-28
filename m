Received: from eggs.gnu.org ([2001:4830:134:3::10]:32885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQDB7-0003oR-7p
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQDB3-0007e7-AD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dQDB3-0007dd-4J
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:38:41 -0400
References: <20170628124850.12821-1-famz@redhat.com>
	<20170628124850.12821-5-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a729ca7e-726d-f8ca-79ab-243592d6bffa@redhat.com>
Date: Wed, 28 Jun 2017 15:38:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170628124850.12821-5-famz@redhat.com>
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
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 28/06/2017 14:48, Fam Zheng wrote:
> 
> It's implemented by creating a wrapper property that basically forwards
> operations to a QOM "link-FOO" property, which handles the check
> callback and flags. The feature that is missing from QOM is the dynamic
> child pointer which is done in the added code with the usual "offset"
> approach.

Would it be possible to add a ".create" field to PropertyInfo?  Then
there's no need to introduce the wrapper.

Also, I think _check and _flags can be always
qdev_prop_allow_set_link_before_realize and
OBJ_PROP_LINK_UNREF_ON_RELEASE for DEFINE_PROP_LINK.

Paolo
