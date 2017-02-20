Received: from eggs.gnu.org ([2001:4830:134:3::10]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <codyprime@gmail.com>) id 1cfou8-0002aC-9Z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <codyprime@gmail.com>) id 1cfou7-0008O2-F3
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:25:28 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <codyprime@gmail.com>) id 1cfou7-0008Nn-9g
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:25:27 -0500
Received: by mail-it0-x242.google.com with SMTP id e137so10904225itc.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 06:25:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <77eb6c23-fc16-c7ad-c69b-afd6cae5e339@redhat.com>
References: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170220100705.GD15874@redhat.com>
	<77eb6c23-fc16-c7ad-c69b-afd6cae5e339@redhat.com>
From: Jeff Cody <codyprime@gmail.com>
Date: Mon, 20 Feb 2017 09:25:25 -0500
Message-ID: <CAJ8Q05n8nx05KZD_1+xQQ1yfKsf45yieHnHSW=Uwjn+gaO7GeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v9 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Buddhi.Madhav@veritas.com, Daniel Berrange <berrange@redhat.com>, stefanha@gmail.com, qemu-devel@nongnu.org, venkatesha.mg@veritas.com, Abhijit.Dey@veritas.com, Nitin.Jerath@veritas.com, Suraj.Singh@veritas.com, rakesh.ranjan@veritas.com, peter.maydell@linaro.org, armbru@redhat.com, jcody@redhat.com, Ashish Mittal <ashmit602@gmail.com>, famz@redhat.com, ashish.mittal@veritas.com, jferlan@redhat.com, Ketan.Nilangekar@veritas.com, kwolf@redhat.com

On Feb 20, 2017 8:49 AM, "Paolo Bonzini" <pbonzini@redhat.com> wrote:



On 20/02/2017 11:07, Daniel P. Berrange wrote:
>> +        if (qemu_uuid_is_null(&qemu_uuid)) {
> This is the wrong check - QEMU provides a 'qemu_uuid_set' boolean
> to determine if 'qemu_uuid' is set or not. If it is not set, then
> the code should return an error, not use a hardcoded uuid.

Or otherwise that hardcoded uuid should be all zeroes (UUID_NONE).



(Replying from phone, sorry for formatting issues)

I think the issue is that boolean is not defined when linking qemu-img, so
if it is used in vxhs.c there will be a linking error.  I can't test that
hypothesis right now, though, as I am traveling.

This also ties into the TLS certs, I believe.  The uuid is being used by
libqnio to determine the cert path, to allow/disallow certain operations
based on if it is being called by qemu-img/io or qemu, etc.





>> +            if (iio_init(QNIO_VERSION, vxhs_iio_callback,
VXHS_UUID_DEF)) {
>> +                return -ENODEV;
>> +            }
