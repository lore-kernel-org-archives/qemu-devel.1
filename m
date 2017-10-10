Received: from eggs.gnu.org ([2001:4830:134:3::10]:53229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1yQd-0001iX-8S
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1yQZ-0001Da-AY
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1yQZ-0001DQ-2V
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:34:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07898C059B60
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:34:46 +0000 (UTC)
Date: Tue, 10 Oct 2017 18:34:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010173442.GB18266@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
	<20171010154328.8419-2-berrange@redhat.com>
	<931753df-dfb4-906f-0991-b075da984469@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <931753df-dfb4-906f-0991-b075da984469@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/7] io: monitor encoutput buffer size
 from websocket GSource
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

On Tue, Oct 10, 2017 at 11:51:00AM -0500, Eric Blake wrote:
> On 10/10/2017 10:43 AM, Daniel P. Berrange wrote:
> > The websocket GSource is monitoring the size of the rawoutput
> > buffer to determine if the channel can accepts more writes.
> > The rawoutput buffer, however, is merely a temporary staging
> > buffer before data is copied into the encoutput buffer. This
> 
> s/This/Thus/
> 
> > its size will always be zero when the GSource runs.
> > 
> > This flaw causes the encoutput buffer to grow without bound
> > if the other end of the underlying data channel doesn't
> > read data being sent. This can be seen with VNC if a client
> > is on a slow WAN link and the guest OS is sending many screen
> > updates. A malicious VNC client can act like it is on a slow
> > link by playing a video in the guest and then reading data
> > very slowly, causing QEMU host memory to expand arbitrarily.
> > 
> > This issue is assigned CVE-2017-????, publically reported in
> 
> If we get the assignment in time, I'm sure you'll update this before the
> PULL request.

Yes, exactly the plan...



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
