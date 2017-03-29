Received: from eggs.gnu.org ([2001:4830:134:3::10]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct8cV-0002Qw-Pu
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct8cS-0001md-Jw
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:06:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ct8cS-0001mU-DB
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:06:16 -0400
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
	<1490033952-26735-1-git-send-email-sstabellini@kernel.org>
	<20170323140005.6b0853b3@bahia.lan>
	<15207674-c5cd-3874-7ac9-5b23cdac8888@suse.com>
	<28db5816-2ed9-0d92-a15d-af47b58a9da1@redhat.com>
	<alpine.DEB.2.10.1703230953120.8001@sstabellini-ThinkPad-X260>
	<3d94c0aa-6b18-5574-4034-110cc2cf4b90@suse.com>
	<alpine.DEB.2.10.1703241030391.8001@sstabellini-ThinkPad-X260>
	<d02897ba-88c6-f92e-ccf5-afab3c584f75@suse.com>
	<alpine.DEB.2.10.1703271537330.8001@sstabellini-ThinkPad-X260>
	<b0ef8967-302f-e308-4d2c-207299c250ef@suse.com>
	<alpine.DEB.2.10.1703281653340.27589@sstabellini-ThinkPad-X260>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25280fb4-5ffd-a523-b5c1-4725fa55e44b@redhat.com>
Date: Wed, 29 Mar 2017 10:06:11 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1703281653340.27589@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/8] xen: import ring.h from xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, xen-devel <xen-devel@lists.xenproject.org>



On 29/03/2017 01:54, Stefano Stabellini wrote:
>>> I understand your point of view, and honestly it wouldn't be a problem
>>> doing it the way you suggested either. However, I think that going
>>> forward it will be less of a maintenance pain to keep ring.h in sync,
>>> compared to maintaining a versioned build dependency between Xen and
>>> QEMU for the compilation of one PV backend. We do have version checks
>>> in QEMU for Xen compatibility, but not for PV backends or the xenpv
>>> machine yet.
>> For the pvUSB backend I just used a mandatory macro from the header for
>> the #ifdef. The backend will signal support when it was defined during
>> build and will refuse initialization otherwise. Xen tools are able to
>> recoginze qemu support of the backend by looking into Xenstore.
> 
> What do you think of the following:

Let's just copy the header...

Paolo
