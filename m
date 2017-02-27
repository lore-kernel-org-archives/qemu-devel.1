Received: from eggs.gnu.org ([2001:4830:134:3::10]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciTir-0006XU-Lv
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:24:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciTiq-0008DA-Ly
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:24:49 -0500
Date: Mon, 27 Feb 2017 17:24:41 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170227222441.GL25637@localhost.localdomain>
References: <cover.1488220970.git.jcody@redhat.com>
	<871655967d4f29e1357abe088df38270e95f5f19.1488220970.git.jcody@redhat.com>
	<9452f3c1-1f9f-f508-1711-1e8eb5a5c2f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9452f3c1-1f9f-f508-1711-1e8eb5a5c2f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] block/rbd: add all the currently
 supported runtime_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

On Mon, Feb 27, 2017 at 04:18:57PM -0600, Eric Blake wrote:
> On 02/27/2017 12:58 PM, Jeff Cody wrote:
> > This adds all the currently supported runtime opts, which
> > are the options as parsed from the filename.  All of these
> > options are explicitly checked for during during runtime,
> > with an exception to the "keyvalue-pairs" option.
> > 
> > This option contains all the key/value pairs that the QEMU rbd
> > driver merely unescapes, and passes along blindly to rados.
> 
> Maybe worth adding a comment that keyvalue-pairs will NOT be exposed in
> QAPI in the later patches, making it command-line only and
> non-introspectible.
>

Yes, I will do that.


> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/rbd.c | 62 ++++++++++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 43 insertions(+), 19 deletions(-)
> > 
> 
> > +static QemuOptsList runtime_opts = {
> > +    .name = "rbd",
> > +    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> > +    .desc = {
> > +        {
> > +            .name = "filename",
> > +            .type = QEMU_OPT_STRING,
> > +            .help = "Specification of the rbd image",
> > +        },
> > +        {
> > +            .name = "password-secret",
> > +            .type = QEMU_OPT_STRING,
> > +            .help = "ID of secret providing the password",
> > +        },
> > +        {
> > +            .name = "conf",
> 
> Is "conf" the best name, or do we want "configuration"?
> 

I chose "conf" because it matches the rados option name (and the command
line option name; it is of the form "conf=filename").

> > +            .type = QEMU_OPT_STRING,
> > +        },
> 
> Worth documenting all the options?
> 

Yes, probably so - and especially to map them up with what rados/ceph
options they correspond to.

> I'm not seeing where "keyvalue-pairs" is used yet, but assume it is in a
> later patch. But assuming the QAPI version in a later patch matches,
> other than keyvalue-pairs, I think you're okay.
> 

Yep, the next patch (where we switch over to .bdrv_parse_filename()).

> Reviewed-by: Eric Blake <eblake@redhat.com>
>

Thanks!

-Jeff
