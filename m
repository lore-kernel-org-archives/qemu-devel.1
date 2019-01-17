Received: from eggs.gnu.org ([209.51.188.92]:40948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gk59x-0007d8-OG
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gk4xZ-0000hP-9q
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:31:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gk4xZ-0000fx-1B
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:31:41 -0500
References: <20190116174941.342900-1-sgarzare@redhat.com>
	<00ff0393-1eab-9bc4-6370-0f959df9dca0@redhat.com>
	<bbec0a30-6b3e-6ba1-b439-7cc72999ea6b@redhat.com>
	<20190117075049.lm5sbws73swdmrgq@steredhat>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8108b59f-5140-0bc6-f92e-3ac931753da5@redhat.com>
Date: Thu, 17 Jan 2019 11:31:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190117075049.lm5sbws73swdmrgq@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] pvh: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

On 17/01/19 08:50, Stefano Garzarella wrote:
>> Also, the $? in the new rule should be $^.  I wouldn't use a pattern
>> rule for that, writing it explicitly as "pvh.img: pvh.S pvh_main.c"
> I'll fix the Makefile.

(of course it's "pvh.img: pvh.o pvh_main.o").

I can fix up as well if it's okay for you.

Paolo
