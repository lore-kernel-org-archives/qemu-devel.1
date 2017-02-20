Received: from eggs.gnu.org ([2001:4830:134:3::10]:41957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfoLE-0001GH-OG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cfoLB-0007QA-Jr
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:49:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cfoLB-0007Px-Cy
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:49:21 -0500
References: <1487543454-20373-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170220100705.GD15874@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77eb6c23-fc16-c7ad-c69b-afd6cae5e339@redhat.com>
Date: Mon, 20 Feb 2017 14:49:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170220100705.GD15874@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Ashish Mittal <ashmit602@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, jcody@redhat.com, famz@redhat.com, ashish.mittal@veritas.com, stefanha@gmail.com, jferlan@redhat.com, Buddhi.Madhav@veritas.com, Suraj.Singh@veritas.com, Nitin.Jerath@veritas.com, peter.maydell@linaro.org, rakesh.ranjan@veritas.com, venkatesha.mg@veritas.com, Ketan.Nilangekar@veritas.com, Abhijit.Dey@veritas.com



On 20/02/2017 11:07, Daniel P. Berrange wrote:
>> +        if (qemu_uuid_is_null(&qemu_uuid)) {
> This is the wrong check - QEMU provides a 'qemu_uuid_set' boolean
> to determine if 'qemu_uuid' is set or not. If it is not set, then
> the code should return an error, not use a hardcoded uuid.

Or otherwise that hardcoded uuid should be all zeroes (UUID_NONE).

Paolo

>> +            if (iio_init(QNIO_VERSION, vxhs_iio_callback, VXHS_UUID_DEF)) {
>> +                return -ENODEV;
>> +            }
