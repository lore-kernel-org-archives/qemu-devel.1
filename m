Received: from eggs.gnu.org ([2001:4830:134:3::10]:57283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d7mld-00076c-7d
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d7mlc-00083D-JY
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:48:17 -0400
Date: Mon, 8 May 2017 13:48:05 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170508174805.GB15291@localhost.localdomain>
References: <cover.1493933558.git.jcody@redhat.com>
	<de25b9a195ff29f7d4bbaec5af4c2f98532d1b9c.1493933558.git.jcody@redhat.com>
	<4ca8dbaf-d5ce-1897-dad5-e181ec60ecdf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca8dbaf-d5ce-1897-dad5-e181ec60ecdf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block/vxhs: Allow VXHS to
 be built as a module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, ashmit602@gmail.com, qemu-block@nongnu.org

On Mon, May 08, 2017 at 01:29:46PM -0400, John Snow wrote:
> 
> 
> On 05/04/2017 05:35 PM, Jeff Cody wrote:
> > In 88d8879, protocol drivers had modularization enabled.  As VXHS is a
> > protocol, make sure it is able to be built as a module as well.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/configure b/configure
> > index 48a9370..eada141 100755
> > --- a/configure
> > +++ b/configure
> > @@ -5859,7 +5859,7 @@ if test "$pthread_setname_np" = "yes" ; then
> >  fi
> >  
> >  if test "$vxhs" = "yes" ; then
> > -  echo "CONFIG_VXHS=y" >> $config_host_mak
> > +  echo "CONFIG_VXHS=m" >> $config_host_mak
> >    echo "VXHS_LIBS=$vxhs_libs" >> $config_host_mak
> >  fi
> >  
> > 
> 
> ERROR: User requested feature vxhs block device
>        configure was not able to find it.
>        Install libvxhs See github
> 
> wow gee, thanks configure file. I'll go "see github."
> 
> Not actually that easy to find; separate patch, but could this be
> touched up?

Sure, that is an easy touch up.  I'll add it as a v2 to this patch.
