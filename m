Received: from eggs.gnu.org ([2001:4830:134:3::10]:50546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1ctjTB-0007DK-6l
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1ctjTA-0000EW-21
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:27:09 -0400
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:33649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1ctjT9-0000EC-TA
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 19:27:07 -0400
Received: by mail-vk0-x229.google.com with SMTP id d188so72712340vka.0
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 16:27:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dd90d073-5a24-4d89-5be4-1c51af748091@redhat.com>
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
	<dd90d073-5a24-4d89-5be4-1c51af748091@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Thu, 30 Mar 2017 16:26:26 -0700
Message-ID: <CAO_EM_mk+8a=x3KP3s-BP7W5RaGHg2aDe0m3-qLnqY6BGMMOKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] New iotest repros failures on virtio external
 snapshot with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Mar 30, 2017 at 4:06 PM, John Snow <jsnow@redhat.com> wrote:
> On 03/29/2017 10:01 PM, Ed Swierk via Qemu-devel wrote:
>> * 2.9.0-rc2
>> - guest, virtio-blk, iothread, single snapshot create+commit:
>> "include/block/aio.h:457: aio_enable_external: Assertion
>> `ctx->external_disable_cnt > 0' failed." after snapshot create
>> - guest, virtio-blk, iothread, repeated snapshot create+commit: same as above
>> - guest, virtio-scsi, iothread, single snapshot create+commit: same as above
>> - guest, virtio-scsi, iothread, repeated snapshot create+commit: same as above
>> - no guest, virtio-blk, iothread, repeated snapshot create+commit: same as above
>> - no guest, virtio-scsi, iothread, single snapshot create+commit: same as above
>> - no guest, virtio-scsi, iothread, repeated snapshot create+commit:
>> same as above
>
> Do you mean to say that all of these 2.9.0-rc2 cases produce the same
> aio.h assertion?

Correct.

--Ed
