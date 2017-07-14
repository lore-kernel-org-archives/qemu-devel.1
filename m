Received: from eggs.gnu.org ([2001:4830:134:3::10]:36755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVxFm-0007eS-Mi
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVxFl-0005Tn-Tj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:51:18 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVxFl-0005Sh-LJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:51:17 -0400
Received: by mail-wm0-x232.google.com with SMTP id f67so17281849wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:51:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <72a57684-fcbe-6096-32c6-6dfe19804667@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
	<72a57684-fcbe-6096-32c6-6dfe19804667@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 10:50:55 +0100
Message-ID: <CAFEAcA8MuMQAXspZO0s8dgjLhO5v1g7EDRgitS9eSMxhVWrktg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/20] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>

On 14 July 2017 at 10:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 14/07/2017 04:14, Fam Zheng wrote:
>> v4: Add a pointer type param to DEFINE_PROP_LINK, don't change pointer types to
>>     "Object *". [Paolo]
>>
>> v3: Include Igor's patch, and fix virtio-crypto too.
>>     Always use qdev_prop_allow_set_link_before_realize and
>>     OBJ_PROP_LINK_UNREF_ON_RELEASE.
>>     Include as many applicable devices as possible and some more clean-ups.
>>     There are still more left but they use uncommon check and flags parameters,
>>     it's better to take care of them in following batches.
>>
>> v2: Create a new header for link properties. [Paolo]
>>     Don't wrap, use PropertyInfo.create() (much better diffstat, yay!).
>>     [Paolo]
>>
>> Link properties of devices created with object_property_add_link() are not
>> reflected in HMP "info qtree". For example, whether a virtio-blk device has an
>> iothread (i.e. has enabled data plane) can not be introspected easily.
>>
>> Introduce a new type of qdev property macro to fix that.

> I'm leaving the ARM patches to Peter and respinning my pull request with
> the others.

OK. Fam, you'll need to send a patchset with whatever the stuff
I need to pick up is, then (and it'll need to get to me by monday
given the freeze date is tuesday).

thanks
-- PMM
