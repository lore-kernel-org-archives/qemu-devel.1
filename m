Received: from eggs.gnu.org ([2001:4830:134:3::10]:35177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e5U9X-0006FO-FO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1e5U9T-0002nU-Gh
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:03:43 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:35738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1e5U9T-0002mx-7u
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:03:39 -0400
Date: Fri, 20 Oct 2017 11:03:33 +0100
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171020100333.dgjrpad3c4kt22oj@starbug-vm.ie.oracle.com>
References: <20171020092844.13880-1-berrange@redhat.com>
	<20171020095431.GG21172@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171020095431.GG21172@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: avoid leak of listen file
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Oct 20, 2017 at 10:54:31AM +0100, Daniel P. Berrange wrote:
>On Fri, Oct 20, 2017 at 10:28:44AM +0100, Daniel P. Berrange wrote:
>> If we iterate over the full port range without successfully binding+listening
>> on the socket, we'll try the next address, whereupon we overwrite the slisten
>> file descriptor variable without closing it.
>>
>> Rather than having two places where we open + close socket FDs on different
>> iterations of nested for loops, re-arrange the code to always open+close
>> within the same loop iteration.
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  util/qemu-sockets.c | 31 +++++++++++++++++++------------
>>  1 file changed, 19 insertions(+), 12 deletions(-)
>
>Self-NACK this has a bug too

Missed this... 

Darren.

>
>
>Regards,
>Daniel
>-- 
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>
