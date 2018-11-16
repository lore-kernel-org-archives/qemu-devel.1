Received: from eggs.gnu.org ([2001:4830:134:3::10]:42859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNfov-0001EU-B0
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNfos-0005c2-6m
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gNfor-0005bC-SE
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:14:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4D423097063
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 15:14:03 +0000 (UTC)
Date: Fri, 16 Nov 2018 16:14:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181116161400.1e3c2669.cohuck@redhat.com>
In-Reply-To: <1c020087-acd7-302a-d5be-dcdbf7b7084d@redhat.com>
References: <20181026105711.29605-1-cohuck@redhat.com>
	<20181115172032.53945f5e.cohuck@redhat.com>
	<1c020087-acd7-302a-d5be-dcdbf7b7084d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] MAINTAINERS: clarify some of the tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 15 Nov 2018 10:46:21 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 11/15/18 10:20 AM, Cornelia Huck wrote:
> > On Fri, 26 Oct 2018 12:57:11 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> The MAINTAINERS file is a bit sparse on information about what
> >> the different designators are. Let's add some more information
> >> to give contributors a better idea about what the different
> >> roles are.
> >>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>
> >> This came out of a discussion about what being a 'reviewer' listed in
> >> this file actually means. A reviewer probably should already have a
> >> track record of doing helpful reviews before being listed in here.
> >>
> >> While at it, I also tried to add some more hints for the other entries.
> >> This patch is supposed to be a starting point for further discussion.  
> > 
> > Ping. Further discussion would be good :)  
> 
> Recent threads have mentioned the possibility of potentially adding a 
> new category P: for the person that submits pull requests, although I'm 
> not quite sure how that is different from M: as a maintainer

Let's wait how that discussion turns out (I'm not quite sure about the
semantics, either.) We can document it then.

> 
> >> +++ b/MAINTAINERS
> >> @@ -12,9 +12,14 @@ consult qemu-devel and not any specific individual privately.
> >>   Descriptions of section entries:
> >>   
> >>   	M: Mail patches to: FullName <address@domain>
> >> +	   Maintainers are looking after a certain area and must be CCed on
> >> +	   patches. They are considered the main contact point.  
> 
> Maybe add something along the lines of "However, a maintainer may accept 
> code that has been reviewed by others without explicitly reviewing it 
> themselves"?

I'm not sure whether that adds vital information. If a maintainer picks
a patch that has been reviewed by others, they may or may not do a
proper review themselves; but the end result is basically the same
(patch makes its way into the tree.)

> 
> >>   	R: Designated reviewer: FullName <address@domain>
> >>   	   These reviewers should be CCed on patches.
> >> +	   Reviewers are familiar with the subject matter and provide feedback
> >> +	   even though they are not maintainers.
> >>   	L: Mailing list that is relevant to this area
> >> +	   These lists should be CCed on patches.
> >>   	W: Web-page with status/info
> >>   	Q: Patchwork web based patch tracking system site
> >>   	T: SCM tree type and location.  Type is one of: git, hg, quilt, stgit.  
> >   
> 
> At any rate, I like the idea of adding the additional descriptions for 
> the categories, even if we still bike-shed on the wording or even the 
> set of categories to use.

What about going with this as a starting point?
