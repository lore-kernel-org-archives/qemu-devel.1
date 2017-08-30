Received: from eggs.gnu.org ([2001:4830:134:3::10]:41594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn3l9-0008TC-Mv
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn3l5-0003p0-I2
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:14:23 -0400
Date: Wed, 30 Aug 2017 16:14:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170830161416.07b6d533@nial.brq.redhat.com>
In-Reply-To: <69765b5d-273d-c695-9094-049e0a486718@redhat.com>
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
	<1504099475-241036-9-git-send-email-imammedo@redhat.com>
	<69765b5d-273d-c695-9094-049e0a486718@redhat.com>
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

On Wed, 30 Aug 2017 15:46:30 +0200
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
> > @@ -19,11 +19,6 @@
> >   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> >   */  
> [...]
> >      /* PowerPC 440 family                                                    */
> > -#if defined(TODO_USER_ONLY)
> > -    POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
> > -                "Generic PowerPC 440")
> > -#endif  
> 
> Please don't remove this TODO_USER_ONLY entry. It's still used if the
> code is compiled with CONFIG_USER_ONLY.
oops, thanks for catching it.
it wasn't intentional, I'll send fixup

> 
>  Thomas
