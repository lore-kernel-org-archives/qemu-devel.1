Received: from eggs.gnu.org ([2001:4830:134:3::10]:50547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1df5IK-0007CD-6h
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1df5II-0003J7-VL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:15:40 -0400
Date: Tue, 8 Aug 2017 10:15:16 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170808141516.GH1525@localhost.localdomain>
References: <20170803163353.19558-1-eblake@redhat.com>
	<3fdaf7c5-591e-4702-126d-b6013a12a690@redhat.com>
	<70c58145-ab14-a9b5-69d4-4bf39cc180af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c58145-ab14-a9b5-69d4-4bf39cc180af@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 for-2.10 0/4] improved
 --version/--help tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com

On Tue, Aug 08, 2017 at 08:50:55AM -0500, Eric Blake wrote:
> On 08/07/2017 07:08 PM, John Snow wrote:
> > 
> > 
> > On 08/03/2017 12:33 PM, Eric Blake wrote:
> >> Not sure if this should go through Kevin's block tree, Paolo's
> >> miscellaneous patches, or if I should just do a pull request
> >> myself (since patch 4 includes a change to qemu-nbd)
> >>
> 
> > 
> > Nothing to keep the commands from going out of order again, it looks
> > like -- can this be added as a comment or otherwise scripted as a
> > ./hey_it_looks_like_you_are_about_to_release_qemu.sh script that makes
> > sure we've dotted the 'i's and crossed the 't's?
> 
> We don't add subcommands to qemu-img all that frequently; I think a
> comment is okay without having to figure out where to script things.
> 
> > 
> > Lastly, Didn't we fix the certificate issue? (I thought Jeff had) -- and
> > even if not, it's still the correct address to send people to IMO. Let
> > people report to us if the SSL certificate appears to be broken.
> 
> That can be a followup-patch.
> 

Probably no need for one, really.  We force redirect to SSL, so the http://
versions will still end up https://.

And to confirm - the SSL certificates are now all in order.  The issue on
the website I think you were referencing in that commit message is because
we still had two URL resources pulling in non-ssl assets (Google fonts, and
jquery), so browsers blocked those mixed requests.  But that has been
updated.


-Jeff
