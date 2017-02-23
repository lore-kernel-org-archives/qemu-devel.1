Received: from eggs.gnu.org ([2001:4830:134:3::10]:46385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgr0E-0008RO-BU
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgr0D-0005Rb-JX
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:52:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgr0D-0005RR-Dw
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:52:01 -0500
Date: Thu, 23 Feb 2017 10:51:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170223105155.GA2383@work-vm>
References: <20170220185020.774-1-dgilbert@redhat.com>
	<20170220185020.774-5-dgilbert@redhat.com>
	<8760k3od2r.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8760k3od2r.fsf@emacs.mitica>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] slirp: VMStatify socket level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

Samual, Jan: Can you just take 1-3 of this series;  4 has a problem;

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Working up the stack, this replaces the slirp_socket_load/save
> > with VMState definitions.
> >
> > A place holder for IPv6 support is added as a comment; it needs
> > testing once the rest of the IPv6 code is there.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> 
> > +/* Win has a signed family number */
> > +#define VMSTATE_SS_FAMILY(f, s) VMSTATE_INT16(f, s)
> 
> Great!
> Just hope that there is no 32000 families soon :-)

Actually; that's a problem;  it turns out FreeBSD has a char for it's
family type rahter than the uint16 that linux and windows have.
I need to think hth to abstract that.

Dave


> 
> 
> > +#if 0
> > +        /* Untested: Needs checking by someone with IPv6 test */
> > +        VMSTATE_BUFFER_TEST(sin6.sin6_addr, union slirp_sockaddr,
> > +                            slirp_family_inet6),
> > +        VMSTATE_UINT16_TEST(sin6.sin6_port, union slirp_sockaddr,
> > +                            slirp_family_inet6),
> > +        VMSTATE_UINT32_TEST(sin6.sin6_flowinfo, union slirp_sockaddr,
> > +                            slirp_family_inet6),
> > +        VMSTATE_UINT32_TEST(sin6.sin6_scope_id, union slirp_sockaddr,
> > +                            slirp_family_inet6),
> > +#endif
> 
> I think this is wrong, we have different fieldbs depending in if it is
> ipv6 or not?
> 
> Later, Juan.
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
