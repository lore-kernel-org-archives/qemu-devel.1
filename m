Received: from eggs.gnu.org ([2001:4830:134:3::10]:51532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGdx-0007VQ-3A
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYGdw-0007XS-Ci
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:57:49 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
	<d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
	<c1526558-db87-734b-c1dd-7601ceaa682c@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <06919388-6794-d0a0-f014-b95a9cc68460@twiddle.net>
Date: Thu, 20 Jul 2017 08:57:30 -1000
MIME-Version: 1.0
In-Reply-To: <c1526558-db87-734b-c1dd-7601ceaa682c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 07/20/2017 08:48 AM, Eric Blake wrote:
> On 07/20/2017 01:26 PM, Richard Henderson wrote:
>> On 07/20/2017 06:31 AM, Peter Maydell wrote:
>>> gdbstub.c:914:13: warning: array subscript has type 'char'
>>>
>>> This reflects the fact that toupper() and tolower() give
>>> undefined behaviour if they are passed a value that isn't
>>> a valid 'unsigned char' or EOF.
>>
>> Not saying we shouldn't use qemu_tolower etc, but this statement is not
>> true at all.  Officially, the argument to toupper and tolower is type int.
> 
> Correct. Officially, the argument to toupper is an int, but
> range-constrained to the set of ints that represent either EOF or an
> unsigned char value.

Please show me that language in C11 (or any other version).
My copy has:

    7.4.2.2 The toupper function

    Synopsis
1  #include <ctype.h>
    int toupper(int c);

    Description
2  The toupper function converts a lowercase letter to a corresponding
    uppercase letter.

    Returns
3  If the argument is a character for which islower is true and there
    are one or more corresponding characters, as specified by the current
    locale, for which isupper is true, the toupper function returns one
    of the corresponding characters (always the same one for any given
    locale); otherwise, the argument is returned unchanged.

I see nothing about range constraints.  The word "unsigned" does not appear.


r~
