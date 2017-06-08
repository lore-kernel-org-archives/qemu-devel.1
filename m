Received: from eggs.gnu.org ([2001:4830:134:3::10]:45206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIxYm-00086B-Bn
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIxYi-000202-GA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:33:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIxYi-0001ym-A1
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:33:08 -0400
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
	<CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
	<8229C6EB-56EA-475E-99D4-6D9B36B5D0A7@nutanix.com>
	<7a06506e-20ba-66b8-8c69-c500efe86301@redhat.com>
	<0281E149-DE28-4D6D-80E0-1132CAB8ABDB@nutanix.com>
	<1265195474.6852496.1496859744613.JavaMail.zimbra@redhat.com>
	<20170607212825-mutt-send-email-mst@kernel.org>
	<1191656469.6862786.1496861817272.JavaMail.zimbra@redhat.com>
	<20170608032440-mutt-send-email-mst@kernel.org>
	<7A6952CE-E364-4265-A3B9-9BAB7CA620D2@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a819c39f-66e2-8879-0f5f-dce822c8b7d0@redhat.com>
Date: Thu, 8 Jun 2017 15:33:03 +0200
MIME-Version: 1.0
In-Reply-To: <7A6952CE-E364-4265-A3B9-9BAB7CA620D2@nutanix.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Felipe Franciosi <felipe@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>



On 08/06/2017 13:05, Felipe Franciosi wrote:
>> Weird.  Doesn't QEMU wait for response to GET_VRING_BASE? I think
>> it does since we migrate the returned value.
>
> It does and that's what I said on my first message. On
> GET_VRING_BASE, a vhost-user-scsi backend application will stop
> picking up new requests and, _additionally_, quiesce the VQ (by
> waiting for any outstanding I/O to complete or cancelling them)
> before returning the last_avail_idx.

Yes, I understand now.

> Such an application therefore doesn't _necessarily_ need a drain
> call. However, we could extend vhost-user to include a message for
> draining (which can be implemented as "wait for pending I/O to
> complete" or "cancel all outstanding" depending on the
> implementation).

Ok, and I see that vhost_dev_stop also calls get_vring_base so my
worries are appeased. :)

Paolo
