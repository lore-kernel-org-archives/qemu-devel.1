Received: from eggs.gnu.org ([2001:4830:134:3::10]:53303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eWPsr-00009d-88
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eWPsn-0002KQ-Ac
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:57:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eWPsn-0002Jo-4w
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:57:45 -0500
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8J53A93+SQz01W13gRCX-ecw0v+8JTaRqwmrUeFjqaJA@mail.gmail.com>
	<51174e3a-12d3-f3e0-2d76-b776e0fe62b6@redhat.com>
	<e7994a8d-3a02-99c7-d919-c940aa4bc066@redhat.com>
	<40dbaff2-918c-bba6-2a70-7c5f9b19cb66@vivier.eu>
	<0d3d6598-608c-0079-426f-7455a92de7d8@vivier.eu>
	<64440fda-1799-f50d-21ed-dc898e08d82f@redhat.com>
	<8033acdb-f88a-2df3-83f3-e3e304c8eb51@vivier.eu>
	<183d1158-2aa3-7ecb-3372-4a206f4c5292@redhat.com>
	<3aee5f72-55ee-3653-d409-0f77e40cf90f@vivier.eu>
	<172eed1f-4769-b3d5-e9f8-48dd834049d8@vivier.eu>
	<de9c2db1-8d00-f66c-0d4d-f3d06b560090@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <47b8bf5d-2c19-f3a2-a582-b534f0af24af@redhat.com>
Date: Tue, 2 Jan 2018 17:57:41 +0100
MIME-Version: 1.0
In-Reply-To: <de9c2db1-8d00-f66c-0d4d-f3d06b560090@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] out of bounds in set_cc_op()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21.12.2017 20:30, Paolo Bonzini wrote:
> On 21/12/2017 20:20, Laurent Vivier wrote:
>>>> Yes, this is good too.  After my pull request is in, feel free to take
>>>> Thomas's m68k boot-serial-test patch in your tree.
>> And what about:
>>
>>       tests/boot-serial-test: Add tests for microblaze boards
>>       tests/boot-serial-test: Add a test for the moxiesim machine
>>       tests/boot-serial-test: Add support for the raspi2 machine
> 
> I didn't want to hold the whole pull request close to the Christmas
> holidays; once either Thomas or I will test them with the sanitizers,
> they will go in.

I've now checked them with '-fsanitize=undefined -fno-sanitize=shift'
(using clang) and I do not get any further errors with the three
remaining patches, so I think they should be fine for the next PULL request.

 Thomas
