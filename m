Received: from eggs.gnu.org ([2001:4830:134:3::10]:52760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebQoq-0005nz-QK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebQoq-0001GY-19
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:58:24 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:32996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebQop-0001GF-SC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:58:23 -0500
Received: by mail-ot0-x244.google.com with SMTP id x15so13507478ote.0
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 04:58:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xYNvJ5rwog7HCV=WYfC8n5aR=xc0i9Uc3WS3xkmz7tw@mail.gmail.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
	<CAFEAcA9xYNvJ5rwog7HCV=WYfC8n5aR=xc0i9Uc3WS3xkmz7tw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 12:58:02 +0000
Message-ID: <CAFEAcA_613BexyCHuhtEd5WYFBL3u3-fBTg3toKwSMC+oDXZJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2018 at 12:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 16 January 2018 at 04:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>> A large pull due to patch buildup over the holiday period.
>> Most notable here is probably the addition of vhost-user-blk.
>>
>> The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:
>>
>>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>
>> for you to fetch changes up to 631ae6adb1fcea786e0db8c6f1b19570bad0f90c:
>>
>>   vhost: remove assertion to prevent crash (2018-01-16 06:36:19 +0200)
>>
>> ----------------------------------------------------------------
>> pc, pci, virtio: features, fixes, cleanups
>>
>> A bunch of fixes, cleanus and new features all over the place.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>
> Build failure, 32 bit:
>
> /home/peter.maydell/qemu/hw/virtio/vhost.c: In function 'vhost_commit':
> /home/peter.maydell/qemu/hw/virtio/vhost.c:666:28: error: cast to
> pointer from integer of different size [-Werror=int-to-pointer-cast]
>                             (void *)dev->mem->regions[i].userspace_addr,
>                             ^
>
> Test failures, ppc64, s390x, sparc64 hosts (so likely all bigendian):
>
> TEST: tests/device-introspect-test... (pid=57202)
>   /s390x/device/introspect/list:                                       OK
>   /s390x/device/introspect/list-fields:                                OK
>   /s390x/device/introspect/none:                                       OK
>   /s390x/device/introspect/abstract:                                   OK
>   /s390x/device/introspect/concrete:                                   **
> ERROR:/home/linux1/qemu/qom/object.c:372:object_initialize_with_type:
> assertion failed: (type != NULL)
> Broken pipe
> FAIL
> GTester: last random seed: R02S51c433c8a3c2fab5dd7233079b9dac7f
> (pid=57214)
>   /s390x/device/introspect/abstract-interfaces:                        OK
> FAIL: tests/device-introspect-test

I get this failure on arm and x86 too, so not big-endian specific.

thanks
-- PMM
