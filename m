Received: from eggs.gnu.org ([2001:4830:134:3::10]:45939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dnKwh-0006xp-Ln
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dnKwe-0001l6-HC
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:35:27 -0400
Date: Thu, 31 Aug 2017 10:35:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170831103512.1bf5c908@nial.brq.redhat.com>
In-Reply-To: <6d03941e-d54e-dc80-4ba3-7c591b7fcddb@redhat.com>
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
	<1504099475-241036-9-git-send-email-imammedo@redhat.com>
	<6d03941e-d54e-dc80-4ba3-7c591b7fcddb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 8/8] ppc: remove non
 implemented cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 31 Aug 2017 09:58:45 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 30.08.2017 15:24, Igor Mammedov wrote:
> > Remove cpu models that aren't implemented and are not
> > compiled/tested since they are under TODO ifdef
> > which isn't defined in sources.
> > 
> > If someone really needs a removed model he/she should add
> > as regular one with corresponding implementation.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  target/ppc/cpu-models.c | 459 ------------------------------------------------
> >  1 file changed, 459 deletions(-)
> > 
> > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > index cf878a9..611fc1b 100644
> > --- a/target/ppc/cpu-models.c
> > +++ b/target/ppc/cpu-models.c  
> [...]
> > -#endif
> >  #if defined(TODO_USER_ONLY)
> >      POWERPC_DEF("440sp",         CPU_POWERPC_440SP,                  440EP,
> >                  "PowerPC 440 SP")
> > @@ -396,20 +207,6 @@
> >      POWERPC_DEF("440spe",        CPU_POWERPC_440SPE,                 440EP,
> >                  "PowerPC 440 SPE")
> >  #endif
> > -    /* PowerPC 460 family                                                    */
> > -#if defined(TODO)
> > -    POWERPC_DEF("464",           CPU_POWERPC_464,                    460,
> > -                "Generic PowerPC 464")
> > -#endif
> > -    /* PowerPC 464 microcontrollers                                          */
> > -#if defined(TODO)
> > -    POWERPC_DEF("464h90",        CPU_POWERPC_464H90,                 460,
> > -                "PowerPC 464H90")
> > -#endif
> > -#if defined(TODO)
> > -    POWERPC_DEF("464h90f",       CPU_POWERPC_464H90F,                460F,
> > -                "PowerPC 464H90F")
> > -#endif  
> 
> By the way, I guess you could also remove the 460 stuff from
> translate_init.c since there are no 460 CPUs defined in QEMU
> (but I guess that should go into a separate patch instead).

I would leave it to someone who knows more about PPC.
Would you like to post one?
