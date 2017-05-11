Received: from eggs.gnu.org ([2001:4830:134:3::10]:47363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8msO-0001WB-QI
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8msM-0007cT-5V
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8msL-0007cO-VA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:07:22 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C94599D41E
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:07:20 +0000 (UTC)
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-2-marcandre.lureau@redhat.com>
	<53e35958-82ee-5d90-6c55-7a126dc9108f@redhat.com>
	<87tw4rwqnp.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75637827-a07e-1275-33b1-77cb9046d588@redhat.com>
Date: Thu, 11 May 2017 14:07:16 +0200
MIME-Version: 1.0
In-Reply-To: <87tw4rwqnp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/17] qdev: remove PropertyInfo.qtype field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 11/05/2017 13:59, Markus Armbruster wrote:
> 
> What I don't like is enumerating PropertyInfo in helpers.  A relatively
> straightforward way to avoid this would be moving the part of
> qdev_property_add_static() that varies between properties into a new
> PropertyInfo method.  Assumes that *all* instances of the same
> PropertyInfo should behave the same.  Paolo, is that the case?

Yes, it is the case, and yes, a virtual method such as
void (*init_default_value)(DeviceState *dev, Property *prop)
would be much better.

Thanks,

Paolo
