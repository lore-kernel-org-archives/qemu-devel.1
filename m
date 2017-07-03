Received: from eggs.gnu.org ([2001:4830:134:3::10]:45031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS3tg-0004si-Dh
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS3tZ-00007e-D4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:08:21 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS3tZ-00006S-7w
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:08:17 -0400
Received: by mail-qt0-x244.google.com with SMTP id c20so23934109qte.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:08:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170627161032.5014-1-david@redhat.com>
	<251b8047-7df4-50a5-cce7-b66858c781a1@redhat.com>
	<4c7a78bc-ec7f-9873-0bda-f3c8e76c844b@redhat.com>
	<3373125e-171a-0516-90f0-757d60eba32a@redhat.com>
	<449afc6c-1fbc-9ae9-8450-9c9a9e67f2c8@twiddle.net>
	<266c6260-cc9a-b765-6988-62c7e5777ce1@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6541ac01-526b-aa94-1297-380ca78a7f2d@twiddle.net>
Date: Mon, 3 Jul 2017 09:08:08 -0700
MIME-Version: 1.0
In-Reply-To: <266c6260-cc9a-b765-6988-62c7e5777ce1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: allow to enable "idtes"
 feature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>

On 07/03/2017 04:07 AM, Thomas Huth wrote:
> On 30.06.2017 21:22, Richard Henderson wrote:
>> On 06/29/2017 12:05 AM, Thomas Huth wrote:
>>> However, I'm not sure whether you can simply ignore the clearing-by-ASCE
>>> stuff in this case. For example, according to the PoP:
>>>
>>> "When the clearing-by-ASCE-option bit (bit 52 of gen-
>>>    eral register R2 is one), the M4 field is ignored."
>>>
>>> And the idte helper function currently always takes the M4 field into
>>> account...
>>
>> I don't see that quote.
> 
> Which version of the Principles of Operation are you using? I just
> checked, and that sentence seems to be available in version SA22-7832-10
> (but it is not in SA22-7832-09 yet).

I'm using -10.


r~
