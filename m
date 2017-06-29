Received: from eggs.gnu.org ([2001:4830:134:3::10]:45324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQY5Z-00082M-AG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQY5V-00084O-Bh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:58:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQY5V-00083y-5v
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:58:21 -0400
Date: Thu, 29 Jun 2017 19:58:16 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629115816.GI28654@lemon.lan>
References: <20170629080452.26470-1-famz@redhat.com>
	<20170629080452.26470-5-famz@redhat.com>
	<3a67102f-7be4-a4cb-9dad-ce6cdcb3b0a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a67102f-7be4-a4cb-9dad-ce6cdcb3b0a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/7] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

On Thu, 06/29 13:51, Paolo Bonzini wrote:
> 
> 
> On 29/06/2017 10:04, Fam Zheng wrote:
> > +#define DEFINE_PROP_LINK(_name, _state, _field, _type, _check, _flags) {\
> > +        .name = (_name),                                                \
> > +        .info = &(qdev_prop_link),                                      \
> > +        .offset = offsetof(_state, _field)                              \
> > +            + type_check(Object *, typeof_field(_state, _field)),       \
> > +        .link.check = _check,                                           \
> > +        .link.flags = _flags,                                           \
> > +        .link_type  = _type,                                            \
> > +        }
> > +
> 
> Still unsure about _check; qdev_prop_allow_set_link_before_realize is
> mimicking the same behavior of any other qdev property, so it should be
> always okay for DEFINE_PROP_LINK.

OK, let's drop Property.link and use constant check and flags. A
DEFINE_PROP_LINK_FULL can always be added later.

Fam
