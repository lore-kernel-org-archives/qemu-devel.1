Received: from eggs.gnu.org ([2001:4830:134:3::10]:51093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crM9t-0002p4-Sk
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crM9s-0001Db-VE
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:09:25 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crM9s-0001DU-PF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:09:24 -0400
Received: by mail-wr0-x22a.google.com with SMTP id u1so6106712wra.2
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:09:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0596af14-a95c-edbf-1441-2f1a39bdff99@suse.com>
References: <20170323212848.8492-1-ehabkost@redhat.com>
	<20170323212848.8492-2-ehabkost@redhat.com>
	<0596af14-a95c-edbf-1441-2f1a39bdff99@suse.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 10:09:03 +0000
Message-ID: <CAFEAcA8Wif2DshJ1YEbxBU4MMY3W0r2U036+4qqL8YzWAuNzJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 1/4] [UNTESTED] xen: Don't force
 has_dynamic_sysbus on machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juergen Gross <jgross@suse.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 24 March 2017 at 08:23, Juergen Gross <jgross@suse.com> wrote:
> On 23/03/17 22:28, Eduardo Habkost wrote:
>> The xen-backend devices created by the Xen code are not supposed
>> to be treated as dynamic sysbus devices. This is an attempt to
>> change that and see what happens, but I couldn't test it because
>> I don't have a Xen host set up.
>>
>> If this patch breaks anything, this means we have a bug in
>> foreach_dynamic_sysbus_device(), which is supposed to return only
>> devices created using -device.
>>
>> The original code that sets has_dynamic_sysbus was added by
>> commit 3a6c9172ac5951e6dac2b3f6cbce3cfccdec5894, but I don't see
>> any comment explaining why it was necessary.
>
> xen-backend devices are created via qmp commands when attaching new
> pv-devices to a domain. They can be dynamically removed, too. Setting
> has_dynamic_sysbus was necessary to support this feature.

This seems like it ought to be handled by marking the xen-backend
devices as being ok-to-dynamically-create somehow, not by marking
the machine as supporting dynamic-sysbus (which it doesn't).
Maybe we don't have the necessary support code to do that though?

thanks
-- PMM
