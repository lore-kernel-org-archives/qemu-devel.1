Received: from eggs.gnu.org ([2001:4830:134:3::10]:45500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDC6-0004eb-9e
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDC2-0007FD-3h
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:43:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duDC1-0007Ei-Tn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:43:42 -0400
References: <20170707142138.411-1-pbutsykin@virtuozzo.com>
	<55a8a300-2247-dadb-40b3-0c1d4e651e08@redhat.com>
	<61dd88c7-3f8c-471b-b33c-61aa2b09f981@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b59ad03-fb7f-704c-9f2b-ed2ee9cd2b30@redhat.com>
Date: Tue, 19 Sep 2017 09:43:32 +0200
MIME-Version: 1.0
In-Reply-To: <61dd88c7-3f8c-471b-b33c-61aa2b09f981@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-serial: add enable_backend callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, dgilbert@redhat.com, amit@kernel.org, den@openvz.org

On 18/09/2017 11:37, Pavel Butsykin wrote:
>>>
>>
>> To understand the patch better this doesn't fix _all_ stopped states,
>> only migration, right?  That said it's a valid bugfix even independent
>> of the effects for stopped runstate.
> Yes, the bug only appears on the migration. Actually, to protect memory
> during the migration, this approach is already used for other virtio
> devices, for example net_vhost, see virtio_net_vhost_status().

Cool, can you rebase?

Paolo
