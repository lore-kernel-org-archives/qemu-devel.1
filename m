Received: from eggs.gnu.org ([2001:4830:134:3::10]:35239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpbQc-0006Lx-JU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpbQX-0000Rk-UY
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:35:42 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpbQX-0000RQ-N1
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:35:37 -0400
Received: by mail-wm0-x234.google.com with SMTP id i145so30267974wmf.1
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:35:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906132936.7cf49b24.cohuck@redhat.com>
References: <20170906094927.22376-1-cohuck@redhat.com>
	<20170906132936.7cf49b24.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Sep 2017 15:35:16 +0100
Message-ID: <CAFEAcA9oOmX1u2zYHJ28AYFDUXVUs=8i04fC05TsxopbvxPmBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC] accel: default to an actually
 available accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 6 September 2017 at 12:29, Cornelia Huck <cohuck@redhat.com> wrote:
> On Wed,  6 Sep 2017 11:49:27 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>> @@ -79,8 +98,7 @@ void configure_accelerator(MachineState *ms)
>>
>>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
>>      if (accel == NULL) {
>> -        /* Use the default "accelerator", tcg */
>> -        accel = "tcg";
>> +        accel = default_accelerator();
>
> It actually may be easier to just switch the default to
> "tcg:kvm:xen:hax". Haven't tested that, though.

Does it make sense to include Xen in the default list?
I don't know much about Xen but I was under the impression
that it's a special purpose thing that you can only use
as part of a Xen setup, whereas tcg, kvm, hax are all
more-or-less interchangeable ways to run a VM under a
Linux/etc host. Do I have the wrong end of the Xen stick?

thanks
-- PMM
