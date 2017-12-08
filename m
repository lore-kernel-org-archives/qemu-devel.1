Received: from eggs.gnu.org ([2001:4830:134:3::10]:49557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNJzS-0006Hw-9b
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eNJzN-0006KB-KZ
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:51:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eNJzN-0006Is-Ee
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:50:57 -0500
Date: Fri, 8 Dec 2017 15:50:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171208155050.1a6db1c2@redhat.com>
In-Reply-To: <CAFEAcA8Gc1XQVYR9+_uD7Be3WSDE5tzxVAuJNBTokb3HdJ6fHw@mail.gmail.com>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
	<20171207174832.42663bef@redhat.com>
	<CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
	<20171207170719.GT3037@localhost.localdomain>
	<CAFEAcA9fzkedj_VLeTaK-WOTLGk1RinyadRmR5FaJ44KOAQU3w@mail.gmail.com>
	<CAFEAcA9Uh9f3UddCNiB3u6BD9Qg=sUMDmMYYn1+sryiJUMOFYg@mail.gmail.com>
	<20171208141618.11e60846@redhat.com>
	<CAFEAcA8Gc1XQVYR9+_uD7Be3WSDE5tzxVAuJNBTokb3HdJ6fHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] in a device or CPU instance init/realize,
 can I rely on something having the BQL or equivalent?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 8 Dec 2017 13:19:27 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 8 December 2017 at 13:16, Igor Mammedov <imammedo@redhat.com> wrote:
> > TBH:
> >  I do not recall why we have x86 max/host cpu types do feature
> >  loading at realize time instead of at class init like the rest
> >  of static cpu types.  
> 
> class init is too early, IIRC -- it's before KVM has been set up at all.

that shouldn't be an issue as kvm_ppc_register_host_cpu_type() demonstrates
(i.e. an additional class init at kvm/tcg init time),

so it might be some compat issue or just legacy approach why it
havn't been rewritten to class_init for x86 the way PPC does.
But Eduardo probably knows better if there is anything left that
prevents using class init there.

> 
> thanks
> -- PMM
