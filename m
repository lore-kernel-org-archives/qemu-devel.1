Received: from eggs.gnu.org ([2001:4830:134:3::10]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJr7p-0002FB-MX
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJr7l-0003rX-NE
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:25:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJr7l-0003rF-FI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:25:17 -0500
Date: Wed, 29 Nov 2017 09:25:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129012511.GA8889@lemon>
References: <151134740734.552.186654908491769740@bafd83ae6430>
	<3d7b93b2-76b1-cfc4-f87b-8983a8439bb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7b93b2-76b1-cfc4-f87b-8983a8439bb7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on
 Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, no-reply@patchew.org, yu.ning@linux.intel.com, huth@tuxfamily.org, sw@weilnetz.de, yu.ning@intel.com, pbonzini@redhat.com, jsnow@redhat.com, patchew-devel@freelists.org

On Tue, 11/28 13:57, Eric Blake wrote:
> On 11/22/2017 04:43 AM, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed automatic build test. Please find the testing commands and
> > their output below. If you have docker installed, you can probably reproduce it
> > locally.
> > 
> > Subject: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on Windows
> > Type: series
> > Message-id: 1511338200-20417-1-git-send-email-yu.ning@linux.intel.com
> 
> Just now noticing this, but it's impressive that:
> 
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > Switched to a new branch 'test'
> > 73987e06df Add a blog post about HAXM acceleration on Windows
> 
> the patch even applied, even though it wasn't against qemu.git!  Is it
> possible to teach patchew to ignore patches against the website, as that is
> maintained in a separate repository?

This patch was supposed to have "[qemu-web PATCH]" or "[PATCH web]" in the
subject. That way it wouldn't be processed by patchew. (I think that is in
general a good way to state which repo the series is targeting at.)

Fam
