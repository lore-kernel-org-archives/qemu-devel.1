Received: from eggs.gnu.org ([2001:4830:134:3::10]:57017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqJDT-0003Xy-OO
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cqJDO-0005cN-Qq
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:48:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cqJDO-0005cC-HU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:48:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2LCcbkZ041921
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 08:48:40 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29awugj1nb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 08:48:39 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 21 Mar 2017 12:48:37 -0000
Date: Tue, 21 Mar 2017 13:48:32 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <07b024e8-fb7e-ba14-19ce-7f82c4703460@redhat.com>
References: <20170320180024.23432-1-arvolkov@inbox.ru>
	<07b024e8-fb7e-ba14-19ce-7f82c4703460@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170321134832.5a3f99b7.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Anton Volkov <arvolkov@inbox.ru>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, agraf@suse.de, borntraeger@de.ibm.com, kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Frederic Konrad <fred.konrad@greensocs.com>

On Tue, 21 Mar 2017 13:05:40 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 20.03.2017 19:00, Anton Volkov wrote:
> > Made functions *_exit in hw/ return void instead of int (they returned 0 all the time)
> > and removed related return value checks
> > 
> > Signed-off-by: Anton Volkov <arvolkov@inbox.ru>
> > ---
> >  hw/audio/hda-codec.c              | 3 +--
> >  hw/audio/intel-hda.c              | 3 +--
> >  hw/audio/intel-hda.h              | 2 +-
> >  hw/char/sclpconsole-lm.c          | 4 ++--
> >  hw/char/sclpconsole.c             | 4 ++--
> >  hw/core/qdev.c                    | 6 +-----
> >  hw/s390x/event-facility.c         | 6 +-----
> >  hw/s390x/virtio-ccw.c             | 7 +++----
> >  hw/s390x/virtio-ccw.h             | 2 +-
> >  hw/usb/dev-smartcard-reader.c     | 3 +--
> >  include/hw/qdev-core.h            | 2 +-
> >  include/hw/s390x/event-facility.h | 2 +-
> >  12 files changed, 16 insertions(+), 28 deletions(-)

> > diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> > index 07d6ebd..fbe5b42 100644
> > --- a/hw/char/sclpconsole-lm.c
> > +++ b/hw/char/sclpconsole-lm.c
> > @@ -318,9 +318,9 @@ static int console_init(SCLPEvent *event)
> >      return 0;
> >  }
> >  
> > -static int console_exit(SCLPEvent *event)
> > +static void console_exit(SCLPEvent *event)
> >  {
> > -    return 0;
> > +    return;
> >  }
> >  
> >  static void console_reset(DeviceState *dev)
> > diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> > index b78f240..644f7cd 100644
> > --- a/hw/char/sclpconsole.c
> > +++ b/hw/char/sclpconsole.c
> > @@ -246,9 +246,9 @@ static void console_reset(DeviceState *dev)
> >     scon->notify = false;
> >  }
> >  
> > -static int console_exit(SCLPEvent *event)
> > +static void console_exit(SCLPEvent *event)
> >  {
> > -    return 0;
> > +    return;
> >  }
> 
> Please avoid a "return;" at the end of a void function, that's just
> superfluous.
> (But in this case, as it has been mentioned by others already, I'd also
> recommend to rather remove the function completely instead of having an
> empty function here)

Yes, let's remove them.
