Received: from eggs.gnu.org ([2001:4830:134:3::10]:51935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fzkdD-0003Np-O2
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fzkdA-0008Ot-HI
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fzkdA-0008O6-Al
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:31:08 -0400
Date: Tue, 11 Sep 2018 12:31:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180911153105.GL12698@habkost.net>
References: <20180905151927.8884-1-ehabkost@redhat.com>
	<0dd0910c-6120-a485-e0b0-c354bd4038cd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd0910c-6120-a485-e0b0-c354bd4038cd@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] configure: Support
 --enable-capstone=internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Danilo C. L. de Paula" <ddepaula@redhat.com>

On Tue, Sep 11, 2018 at 07:33:08AM -0700, Richard Henderson wrote:
> On 09/05/2018 08:19 AM, Eduardo Habkost wrote:
> > Currently there's no way to make configure not try to use the
> > system-provided capstone library using pkgconfig.
> 
> Certainly there is.
> 
> > 
> > Add support to --enable-capstone=internal option to make QEMU not
> > use the system-provided library automatically.

Oops, the commit message is inaccurate: we can prevent
./configure from trying the system library, but there's no way to
make it avoid using git submodule at the same time.


> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  configure | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/configure b/configure
> > index 58862d2ae8..34ed00f6d9 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1431,6 +1431,8 @@ for opt do
> > +  --enable-capstone[=LOCATION]
> > +                           Where to look for capstone library.
> > +                           Supported options: internal, git, system
> 
> That's what "git" means here.

"git" makes ./configure add capstone to GIT_SUBMODULES, and I'm
pretty sure we don't want that if we're not building from a git
tree.

-- 
Eduardo
