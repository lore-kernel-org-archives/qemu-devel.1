Received: from eggs.gnu.org ([2001:4830:134:3::10]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQsqi-0000DS-6Q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQsqe-000319-DC
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:36:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQsqe-00030q-7H
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:36:08 -0500
References: <20161222152300.32395-1-pbonzini@redhat.com>
	<20161222152300.32395-22-pbonzini@redhat.com>
	<CAFEAcA_G4Cgwimce6kMzWkB2zHLbTMwWH8ZcEP2kRu8853Lu_Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3e12905-6679-e575-0921-5404faef6b53@redhat.com>
Date: Tue, 10 Jan 2017 10:36:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_G4Cgwimce6kMzWkB2zHLbTMwWH8ZcEP2kRu8853Lu_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 21/25] scsi-disk: fix VERIFY for scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 09/01/2017 20:42, Peter Maydell wrote:
>> +    case VERIFY_10:
>> +    case VERIFY_12:
>> +    case VERIFY_16:
>> +        /* We get here only for BYTCHK =3D=3D 0x01 and only for scsi-=
block.
>> +         * As far as DMA is concerned, we can treat it the same as a =
write;
>> +         * scsi_block_do_sgio will send VERIFY commands.
>> +         */
>>          if (r->req.cmd.buf[1] & 0xe0) {
>>              goto illegal_request;
>>          }
> Coverity now complains about the fallthrough into the case statements
> added here. I assume from the patch that the fallthrough is deliberate,
> in which case a /* fall through */ comment would assist future
> readers...

Indeed---I thought I had waived that already in the scan dashboard.

Paolo
