Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHYHC-0006ge-Mh
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHYH7-0005fy-Sg
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:53:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eHYH7-0005fZ-Lt
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:53:25 -0500
Date: Wed, 22 Nov 2017 17:53:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171122175321.6a3dad1b.cohuck@redhat.com>
In-Reply-To: <e0e56414-cde9-e403-2cfe-be3476331163@de.ibm.com>
References: <20171122163733.4007-1-pbonzini@redhat.com>
	<e0e56414-cde9-e403-2cfe-be3476331163@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] css: avoid over-large images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com

On Wed, 22 Nov 2017 17:48:28 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 11/22/2017 05:37 PM, Paolo Bonzini wrote:
> > Make sure that images are scaled to fit inside their container.  
> 
> Thanks God. I was thinking "what is wrong with the channel subsystem in QEMU?" when
> reading your subject.....

Me too. Hurray for overloaded TLAs ;)

>  
> > Tested-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  assets/css/style.css | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/assets/css/style.css b/assets/css/style.css
> > index 2d4fe0c..b828887 100644
> > --- a/assets/css/style.css
> > +++ b/assets/css/style.css
> > @@ -200,6 +200,10 @@
> > 
> >  	/* Images */
> > 
> > +		img {
> > +			max-width: 100%;
> > +		}
> > +
> >  		.image
> >  		{
> >  			display: inline-block;
> >   
> 
> 
