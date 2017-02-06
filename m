Received: from eggs.gnu.org ([2001:4830:134:3::10]:55519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cagak-0003p9-6F
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cagaj-0007mP-58
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:32:14 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cagai-0007lk-Uc
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:32:13 -0500
Received: by mail-wr0-x22b.google.com with SMTP id o16so21288086wra.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 02:32:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170206085819.GF12744@in.ibm.com>
References: <1485946146-21639-1-git-send-email-bharata@linux.vnet.ibm.com>
	<CAFEAcA_gno6etAWKkssBYSzYethD7_qNQh6CJCdviTNPqn2x9Q@mail.gmail.com>
	<20170203151246.GD12744@in.ibm.com>
	<CAFEAcA-Oqk4kKjpsyhqgAn9bZt7uNNiwt6bQm1mqj9P8j38dpg@mail.gmail.com>
	<20170206085819.GF12744@in.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 10:31:49 +0000
Message-ID: <CAFEAcA8yDPDAK2zips8vHZkZiCkp_ewJmv0691rRMA5cO6Hktw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v0] softfloat: Add
 float128_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 6 February 2017 at 08:58, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> On Fri, Feb 03, 2017 at 03:39:16PM +0000, Peter Maydell wrote:
>> On 3 February 2017 at 15:12, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
>> > As I said above, it is based on float128_to_int64()
>>
>> Ah, right. I think that's probably a bad model to copy because
>> it's a conversion to signed integer, not a conversion to
>> unsigned integer (so the edge cases are different).
>
> I checked the original berkeley implementation and I see that
> float128_to_uint64 implementation there also is based on
> float128_to_int64 implementation with edge cases being different.
>
> To the best of my understanding, the corner cases for unsigned
> int are covered in the above implemenation. Could you please
> take a re-look at this ?

OK, but that's about 5 times harder to review because I have
to work everything out from scratch rather than being able to
say "yes, this is doing everything the same way that our
existing known-to-be-good other function is doing it".

thanks
-- PMM
