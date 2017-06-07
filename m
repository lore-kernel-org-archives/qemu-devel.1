Received: from eggs.gnu.org ([2001:4830:134:3::10]:34538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIfbE-00070f-HH
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIfbB-0008Qg-DQ
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:22:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIfbB-0008Qb-7H
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 14:22:29 -0400
Date: Wed, 7 Jun 2017 14:22:24 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1265195474.6852496.1496859744613.JavaMail.zimbra@redhat.com>
In-Reply-To: <0281E149-DE28-4D6D-80E0-1132CAB8ABDB@nutanix.com>
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
	<7a06506e-20ba-66b8-8c69-c500efe86301@redhat.com>
	<0281E149-DE28-4D6D-80E0-1132CAB8ABDB@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 18/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

> > How, since there is no synchronization point between the vhost-user
> > server on the source and the destination?
> 
> The idea is that the backend should both stop picking up new requests and
> also quiesce outstanding requests upon a GET_VRING_BASE vhost message.

This could be documented, but perhaps it's best to add a START_STOP
feature and message to the vhost-user protocol?

The feature then can be optional for vhost-user-net and mandatory for
vhost-user-scsi.  When this is done we can remove .unmigratable.

Thanks,

Paolo

> > 
> > Can you please send a version of your patch that uses .unmigratable?
> 
> Sure I can do that. We can work on the migration later on.
> 
> > 
> > I'll send a v6 that momentarily drops vhost-scsi, but I intend to
> > include it again in the next pull request.
> 
> Sounds good to me.
> 
> Felipe
> 
> > 
> > Thanks,
> > 
> > Paolo
> 
> 
