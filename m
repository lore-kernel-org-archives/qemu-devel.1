Received: from eggs.gnu.org ([2001:4830:134:3::10]:58033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNBF8-0006nd-LE
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 00:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNBF3-0000jl-RD
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 00:58:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNBF3-0000im-L6
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 00:58:17 -0400
References: <20170615203735.19649-1-rth@twiddle.net>
	<82919db8-1004-9e42-e2a1-a4791e992524@redhat.com>
	<4c0385c0-ee69-013d-1dcb-573548fc9128@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4aae0af2-8563-ab13-3bec-b55ccf55ff7b@redhat.com>
Date: Tue, 20 Jun 2017 06:58:10 +0200
MIME-Version: 1.0
In-Reply-To: <4c0385c0-ee69-013d-1dcb-573548fc9128@twiddle.net>
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, David Hildenbrand <david@redhat.com>

On 20.06.2017 01:44, Richard Henderson wrote:
> On 06/19/2017 01:08 AM, Thomas Huth wrote:
>>> +    /* Sanity check the function code and storage characteristic.  */
>>> +    if (fc > 1 || sc > 3) {
>>> +        if (!s390_has_feat(S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2)) {
>>> +            goto spec_exception;
>>> +        }
>>> +        if (fc > 2 || sc > 4 || (fc == 2 && (r3 & 1))) {
>>
>> I think you could omit the "fc == 2" here. fc has to be bigger than 1
>> due to the outer if-statement, and if it is not 2, the first "fc > 1"
>> has already triggered. So "fc" has to be 2 here and the "fc == 2" is a
>> redundant check.
> 
> Not so.  We can also get here with fc == 0 && sc == 4.

Uh, right, sorry for the confusion!

 Thomas
