Received: from eggs.gnu.org ([2001:4830:134:3::10]:58897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6Le-0000CM-Gj
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6LZ-0003EK-M0
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:44:46 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:35818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6LZ-0003E3-EL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:44:41 -0400
Received: by mail-pg0-x22d.google.com with SMTP id 132so21198618pgb.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 16:44:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170615203735.19649-1-rth@twiddle.net>
	<82919db8-1004-9e42-e2a1-a4791e992524@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4c0385c0-ee69-013d-1dcb-573548fc9128@twiddle.net>
Date: Mon, 19 Jun 2017 16:44:38 -0700
MIME-Version: 1.0
In-Reply-To: <82919db8-1004-9e42-e2a1-a4791e992524@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, David Hildenbrand <david@redhat.com>

On 06/19/2017 01:08 AM, Thomas Huth wrote:
>> +    /* Sanity check the function code and storage characteristic.  */
>> +    if (fc > 1 || sc > 3) {
>> +        if (!s390_has_feat(S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2)) {
>> +            goto spec_exception;
>> +        }
>> +        if (fc > 2 || sc > 4 || (fc == 2 && (r3 & 1))) {
> 
> I think you could omit the "fc == 2" here. fc has to be bigger than 1
> due to the outer if-statement, and if it is not 2, the first "fc > 1"
> has already triggered. So "fc" has to be 2 here and the "fc == 2" is a
> redundant check.

Not so.  We can also get here with fc == 0 && sc == 4.


r~
