Received: from eggs.gnu.org ([2001:4830:134:3::10]:57696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqO0S-00023Z-VD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cqO0P-00056U-Q5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cqO0P-000568-Jk
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:55:37 -0400
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
Date: Tue, 21 Mar 2017 18:55:34 +0100
MIME-Version: 1.0
In-Reply-To: <1489561105.24841.25.camel@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janne Huttunen <janne.huttunen@nokia.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org



On 15/03/2017 07:58, Janne Huttunen wrote:
> 
> Since real HW has this capability, there exist certain
> auxiliary systems that are built on it. Having similar
> semantics available in QEMU allows me to build a virtual
> machine that works with these systems without modifying
> them in any way.

How does real hardware do it?  I suppose you'd do it with a firmware
setup menu or something like that; would it be enough to add a way to
modify bootindex during runtime?

Paolo
