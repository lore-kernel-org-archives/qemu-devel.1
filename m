Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXWEH-0000kO-Lu
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXWED-00075F-Nu
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:28:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fXWED-00074y-Hj
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 14:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08F8F81A4EB3
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 18:28:41 +0000 (UTC)
References: <1529950933-28347-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a46cbc1c-197d-1460-0f55-a918c7ff3497@redhat.com>
Date: Mon, 25 Jun 2018 20:28:38 +0200
MIME-Version: 1.0
In-Reply-To: <1529950933-28347-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Deprecate the -enable-hax option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 25/06/2018 20:22, Thomas Huth wrote:
> We currently have got three ways of turning on the HAX accelerator:
> "-machine accel=hax", "-accel hax" and "-enable-hax". That's really
> confusing and overloaded. Since "-accel" is our preferred way to enable
> an accelerator nowadays, and "-accel hax" is even less to type than
> "-enable-hax", let's deprecate the "-enable-hax" option now.
> 
> Note: While "-enable-kvm" is available since a long time and can hardly be
> removed since it is used in a lot of upper layer tools and scripts, the
> "-enable-hax" option is still rather new and not very widespread yet, so
> I think that it should be OK if we remove this in a couple of releases again
> (we'll see whether someone complains after seeing the deprecation message -
> then we could still reconsider to keep it if there a well-founded reasons).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Let's give this a try at least :-)

Sounds good, queued.

Paolo
