Received: from eggs.gnu.org ([2001:4830:134:3::10]:55427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5qje-0006FY-Rq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f5qje-0007mI-2l
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:42:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f5qjd-0007mE-Uu
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:42:46 -0400
References: <1523021879-25807-1-git-send-email-thuth@redhat.com>
	<1523021879-25807-2-git-send-email-thuth@redhat.com>
	<53b776ad-a1c9-29a3-e5de-6cf4528b49f4@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e604c9d-2933-9da2-7019-172d30dc8568@redhat.com>
Date: Tue, 10 Apr 2018 12:42:40 +0200
MIME-Version: 1.0
In-Reply-To: <53b776ad-a1c9-29a3-e5de-6cf4528b49f4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.13 1/3] net: Remove the deprecated
 "vlan" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 06.04.2018 16:17, Paolo Bonzini wrote:
> On 06/04/2018 15:37, Thomas Huth wrote:
>> It's been marked as deprecated since QEMU v2.9.0, so that should have
>> been enough time for everybody to switch to the modern -device + -netdev
>> syntax for connecting guest NICs with host network backends, or to switch
>> to the "hubport" netdev in case hubs are really wanted instead.
> 
> ... or to just drop unnecessary "vlan=0", which is the really common case.
> 
>>
>>  # @NetdevL2TPv3Options:
>>  #
>> -# Connect the VLAN to Ethernet over L2TPv3 Static tunnel
>> +# Configure an Ethernet over L2TPv3 Static tunnel.
>>  #
> 
> Since you are at it, probably remove "Static"?  I don't see the point
> really.

Sure, will do.

>> or the netdev 'nd' (for pluggable\n"
>> "                NICs please use '-device devtype,netdev=nd' instead)\n"
> 
> Maybe remove this if -net is prominently marked deprecated?  And mention
> using -nic instead of "-net nic,netdev=...".

Yes, "-net nic,netdev=..." does indeed not make much sense anymore now
that we've got "-nic". I'll remove it from the documentation in the next
version of the patch.

 Thomas
