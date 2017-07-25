Received: from eggs.gnu.org ([2001:4830:134:3::10]:54362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da3xI-00063t-RV
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1da3xG-0004uR-1H
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1da3xF-0004tL-RU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:49:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA92A8B137
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 17:49:08 +0000 (UTC)
Date: Tue, 25 Jul 2017 13:49:05 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <696948082.18968773.1501004945066.JavaMail.zimbra@redhat.com>
In-Reply-To: <be2523ce-7505-b3dd-d359-e91ac25f3cc4@redhat.com>
References: <20170725141041.1195-1-berrange@redhat.com>
	<be2523ce-7505-b3dd-d359-e91ac25f3cc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: document existance of
 versioned machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org


> 
> On 07/25/2017 10:10 AM, Daniel P. Berrange wrote:
> > The -machine docs did not explain what the versioned machine
> > types are for, nor that they'll be maintained across
> > releases.
> > 
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >   qemu-options.hx | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 746b5fa75d..9f6e2adfff 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -49,7 +49,20 @@ STEXI
> >   @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
> >   @findex -machine
> >   Select the emulated machine by @var{name}. Use @code{-machine help} to
> >   list
> > -available machines. Supported machine properties are:
> > +available machines.
> > +
> > +For architectures which aim to support live migration compatibility
> > +across releases, each release will introduce a new versioned machine
> > +type. For example, the 2.8.0 release introduced machine types
> > +``pc-i440fx-2.8'' and ``pc-q35-2.8'' for the x86_64/i686 architectures.
> 
> Seems like an improvement to me, but do we have any formal policy on how
> long we support said machine types? The new wording prompts that question.

Forever, and ever...

Paolo
