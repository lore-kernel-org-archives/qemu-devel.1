Received: from eggs.gnu.org ([2001:4830:134:3::10]:60373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJtXg-0000xf-Lq
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eJtXd-0001LP-Kj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:00:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eJtXd-0001Ky-EA
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:00:09 -0500
Date: Wed, 29 Nov 2017 12:00:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171129040003.GE8889@lemon>
References: <20171129015851.16429-1-famz@redhat.com>
	<7f5eac13-d29b-db32-56a5-afb799a35180@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f5eac13-d29b-db32-56a5-afb799a35180@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu-web] Suggest qemu-web prefix in the
 introductory post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, yu.ning@linux.intel.com, pbonzini@redhat.com

On Tue, 11/28 20:54, Eric Blake wrote:
> On 11/28/2017 07:58 PM, Fam Zheng wrote:
> > Chances are qemu-devel@nongnu.org patches only adding new files can be
> > picked up by patchew and treated like a qemu.git patch. Patchew already
> > ignores [qemu-web] patches, so suggest it in this article as well. (Are
> > there better places to document this?)
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >   _posts/2017-02-04-the-new-qemu-website-is-up.md | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/_posts/2017-02-04-the-new-qemu-website-is-up.md b/_posts/2017-02-04-the-new-qemu-website-is-up.md
> > index 66d3181..c16053c 100644
> > --- a/_posts/2017-02-04-the-new-qemu-website-is-up.md
> > +++ b/_posts/2017-02-04-the-new-qemu-website-is-up.md
> > @@ -19,7 +19,8 @@ and the source code for the website can be cloned from the
> >   repository.  Just like for any other project hosted by QEMU, the best way
> >   to propose or contribute a new change is by sending a patch through the
> >   [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)
> > -mailing list.
> > +mailing list. (Add `[qemu-web PATCH]` to the subject so that CI will not be
> > +confused with qemu.git patches.)
> 
> I suggest mentioning that "git config format.subjectprefix 'qemu-web PATCH"'
> will automate that process, so you don't have to think about it when doing
> git send-email.

Yes, I will send v2 and add that.

Fam
