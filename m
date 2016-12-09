Received: from eggs.gnu.org ([2001:4830:134:3::10]:49005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cFFmL-0003NR-8G
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 02:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cFFmI-0006lM-6s
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 02:39:37 -0500
Date: Fri, 9 Dec 2016 15:39:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161209073920.GA562@lemon>
References: <1477928314-11184-1-git-send-email-famz@redhat.com>
	<1477928314-11184-15-git-send-email-famz@redhat.com>
	<f89973af-5db3-a85d-0539-0a8ec0079fd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89973af-5db3-a85d-0539-0a8ec0079fd6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/14] tests: Add test-image-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

On Fri, 12/02 17:30, Max Reitz wrote:
> > +static struct CompatData {
> > +    bool write_1;
> > +    bool share_1;
> > +    bool write_2;
> > +    bool share_2;
> > +    bool compatible;
> > +} compat_data[] = {
> > +    /* Write 1, Share 1, Write 2, Share 2, Compatible. */
> > +    { RO,       SHARE,   RO,      SHARE,   true,  },
> > +    { RO,       SHARE,   RO,      EXCLU,   true,  },
> > +    { RO,       SHARE,   RW,      SHARE,   true,  },
> > +    { RO,       SHARE,   RW,      EXCLU,   true,  },
> > +    { RO,       EXCLU,   RO,      SHARE,   true,  },
> > +    { RO,       EXCLU,   RO,      EXCLU,   true,  },
> > +    { RO,       EXCLU,   RW,      SHARE,   false, },
> > +    { RO,       EXCLU,   RW,      EXCLU,   false, },
> > +};
> 
> Without having looked closer at the test, what about RW/RW compatibility?

Good catch, I will fix this matrix in next version.

Fam
