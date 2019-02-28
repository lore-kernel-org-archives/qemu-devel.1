Received: from eggs.gnu.org ([209.51.188.92]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzNsU-00012i-LX
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1gzNsT-0002kg-Mr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 10:45:42 -0500
Message-ID: <57c52958d286c103551108b7a9eaab7f8ec34c9b.camel@gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Thu, 28 Feb 2019 21:15:15 +0530
In-Reply-To: <20190228135054.GE9217@redhat.com>
References: <4817f5c3b20aedba869608c06e76d11a722f4864.camel@gmail.com>
	<20190228135054.GE9217@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] trivial malloc to g_malloc in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>

On Thu, 2019-02-28 at 13:50 +0000, Daniel P. Berrangé wrote:
> On Thu, Feb 28, 2019 at 07:12:45PM +0530, Aarushi Mehta wrote:
> > Hi
> > 
> > This is a trivial contribution part of the BiteSizedTasks on the
> > wiki.
> > I found this discussion 
> > http://git.corpit.ru/?p=qemu.git;a=commit;h=b45c03f585ea9bb1af76c73e82195418c294919d
> > on migrating even g_malloc to g_new, is this not appropriate for
> > the same? 
> > The wiki can presumably use an update regarding this.
> 
> This kind of question should not be in the commit message - it shoudl
> go below the '---'
> 
> > 
> > Signed-off-by: Aarushi <mehta.aaru20@gmail.com>
> > ---
> 
> ....here....
> 
> This lets people answer the question, without the question becoming
> part of the git history.

Eek, apologies. Thank you.
> >  thunk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/thunk.c b/thunk.c
> > index d5d8645cd4..03fb2abab7 100644
> > --- a/thunk.c
> > +++ b/thunk.c
> > @@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char
> > *name, const argtype *types)
> >      for(i = 0;i < 2; i++) {
> >          offset = 0;
> >          max_align = 1;
> > -        se->field_offsets[i] = malloc(nb_fields * sizeof(int));
> > +        se->field_offsets[i] = g_malloc(nb_fields * sizeof(int));
> 
> Yes, this should use g_new0

Sent a patch in with the same
> >          type_ptr = se->field_types;
> >          for(j = 0;j < nb_fields; j++) {
> >              size = thunk_type_size(type_ptr, i);
> > -- 
> > 2.17.1
> > 
> > 
> > 
> 
> Regards,
> Daniel
